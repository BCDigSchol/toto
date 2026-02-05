# toto

Digital Scholarship Resources Site

By David J. Thomas, Boston College

## About

Share information, videos, images, and links about Digital Scholarship in a social media lookalike format. Simply edit a few spreadsheets to customize the site's content to your liking, and publish it on Github Pages or your own server.

## Local Development

* Follow [this guide](https://jekyllrb.com/docs/installation/) to install Ruby and Jekyll
* Install [Node](https://nodejs.org/en)
* `git clone` this repo and then `cd` inside the directory
* Comment out the `url` and `baseurl` lines of `_config.yml` when working locally
* Install Ruby dependencies by running `bundle install`
* Transcode any videos by running `./scripts/transcode_videos.sh`
* Run the server with `bundle exec jekyll serve`