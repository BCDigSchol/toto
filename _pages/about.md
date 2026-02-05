---
layout: page
title: About
permalink: about
show-title: false
---

<div class="about-hero" style="display:flex;align-items:center;gap:1.25rem;flex-wrap:wrap;padding:1.5rem 0;">
	<div style="flex:1;min-width:260px;max-width:720px;">
		<h1 style="font-size:2rem;margin:0 0 .5rem;color:#0b2140;">About the Digital Scholarship Group</h1>
		<p style="margin:0 0 1rem;color:#334155;line-height:1.6;">This platform is designed to share resources and discoveries about Digital Scholarship. It's powered by Jekyll — simply edit the project spreadsheet to add or update resources and the site publishes them.</p>

		<p style="margin:0 0 1rem;color:#334155;line-height:1.6;"><strong>Created by the Boston College Digital Scholarship Group</strong>, the site collects guides, media, and links to support research, teaching, and digital projects.</p>

		<a href="/index.html" style="display:inline-block;background:#0b5fff;color:#fff;padding:.6rem .9rem;border-radius:8px;text-decoration:none;font-weight:600;">Browse resources</a>
	</div>

	<div style="min-width:180px;max-width:320px;background:#f8fafc;border-radius:12px;padding:1rem;border:1px solid rgba(2,6,23,0.04);box-shadow:0 6px 18px rgba(2,6,23,0.04);">
		<h3 style="margin:0 0 .5rem;color:#0b2140;font-size:1.05rem;">Areas of expertise</h3>
		<p style="margin:0;color:#475569;line-height:1.45;font-size:.95rem;">The Digital Scholarship Group’s range of expertise includes:</p>
		<ul style="margin:.6rem 0 0;padding-left:1.1rem;color:#475569;line-height:1.6;">
			<li>3D modeling and immersive</li>
			<li>Coding and scripting</li>
			<li>Data acquisition &amp; management</li>
			<li>Data visualization</li>
			<li>Metadata &amp; digital collections</li>
			<li>GIS / mapping</li>
			<li>Text analysis &amp; encoding</li>
			<li>UI/UX design and web development</li>
		</ul>
	</div>
</div>

<section style="margin-top:1.25rem;color:#334155;line-height:1.7;">
	<h2 style="font-size:1.3rem;color:#0b2140;margin-bottom:.5rem;">How this site works</h2>
	<p style="margin:0 0 1rem;">The site is driven by a simple CSV data file maintained in the repository. Each row in the spreadsheet corresponds to a resource; you can add images, media, links, and metadata there. The Jekyll build reads the spreadsheet and renders a consistent listing for visitors.</p>

	<h2 style="font-size:1.1rem;color:#0b2140;margin-top:1rem;margin-bottom:.5rem;">Get involved</h2>
	<p style="margin:0 0 1rem;">If you'd like to contribute resources or request support from the Digital Scholarship Group, contact the team or propose additions via the project's issue tracker.</p>

	<div style="margin-top:1rem;padding:1rem;border-radius:8px;background:#f1f5f9;border:1px solid rgba(2,6,23,0.03);">
		<strong>Contact</strong>
		<p style="margin:.5rem 0 0;color:#475569;">Boston College Digital Scholarship Group</p>
	</div>
</section>

<style>
	/* Small responsive tweaks for the about page */
	@media (min-width: 1024px) {
		.about-hero { align-items:flex-start; }
	}
</style>

