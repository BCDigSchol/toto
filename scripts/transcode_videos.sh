#!/usr/bin/env bash
set -euo pipefail

# Transcode videos to web-friendly H.264 MP4 using ffmpeg
# Usage:
#   ./scripts/transcode_videos.sh [-i input_dir] [-o output_dir] [-q crf] [-p preset] [-f] [--dry-run]
# Defaults: input_dir=objects, output_dir=objects/converted_mp4, crf=23, preset=medium

INPUT_DIR="objects"
OUTPUT_DIR="objects/converted_mp4"
CRF=23
PRESET="medium"
FORCE_MP4=1
DRY_RUN=0

print_help(){
  cat <<EOF
Usage: $0 [options]

Options:
  -i DIR     Input directory containing video files (default: objects)
  -o DIR     Output directory for converted files (default: objects/converted_mp4)
  -q CRF     ffmpeg CRF value (quality) (default: 23)
  -p PRESET  ffmpeg preset (ultrafast, superfast, veryfast, faster, fast, medium, slow, slower, veryslow) (default: medium)
  -f         Force re-encode MP4 inputs as well (default: skip existing MP4s)
  -n         Dry run (don't execute ffmpeg, just print commands)
  -h         Show this help

Example:
  $0 -i objects -o objects/mp4 -q 20 -p fast

This script requires ffmpeg to be installed and available on PATH.
EOF
}

while getopts ":i:o:q:p:fnh" opt; do
  case $opt in
    i) INPUT_DIR="$OPTARG" ;;
    o) OUTPUT_DIR="$OPTARG" ;;
    q) CRF="$OPTARG" ;;
    p) PRESET="$OPTARG" ;;
    f) FORCE_MP4=1 ;;
    n) DRY_RUN=1 ;;
    h) print_help; exit 0 ;;
    \?) echo "Invalid option: -$OPTARG" >&2; print_help; exit 2 ;;
  esac
done

if ! command -v ffmpeg >/dev/null 2>&1; then
  echo "ffmpeg not found. Install ffmpeg (e.g., brew install ffmpeg) and retry." >&2
  exit 3
fi

mkdir -p -- "${OUTPUT_DIR}"

shopt -s nullglob
FILES=("${INPUT_DIR}"/*.{mp4,mov,avi,mkv,webm} )
shopt -u nullglob

if [ ${#FILES[@]} -eq 0 ]; then
  echo "No video files found in ${INPUT_DIR}." >&2
  exit 0
fi

for src in "${FILES[@]}"; do
  filename=$(basename -- "$src")
  ext="${filename##*.}"
  # portable lowercase conversion for macOS / older bash
  ext_lc=$(printf "%s" "$ext" | tr '[:upper:]' '[:lower:]')
  name="${filename%.*}"
  out="${OUTPUT_DIR}/${name}.mp4"

  # Skip mp4 unless forced
  if [ "$ext_lc" = "mp4" ] && [ "$FORCE_MP4" -eq 0 ]; then
    echo "Skipping MP4 (use -f to force re-encode): ${src} -> ${out}"
    continue
  fi

  echo "Transcoding: ${src} -> ${out} (crf=${CRF}, preset=${PRESET})"

  cmd=(ffmpeg -hide_banner -loglevel info -y -i "$src" -c:v libx264 -preset "$PRESET" -crf "$CRF" -c:a aac -b:a 128k -movflags +faststart "$out")

  if [ "$DRY_RUN" -eq 1 ]; then
    printf '%s\n' "${cmd[@]}"
  else
    "${cmd[@]}"
    rc=$?
    if [ $rc -ne 0 ]; then
      echo "ffmpeg failed for ${src} (exit $rc)" >&2
    else
      echo "Saved: ${out}"
    fi
  fi
done

echo "Done. Converted files are in: ${OUTPUT_DIR}"
