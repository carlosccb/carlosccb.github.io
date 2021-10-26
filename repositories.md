---
layout: default
permalink: "/repositories"
---

<!--  Sources for the idea:
	https://jekyll.github.io/github-metadata/site.github/
	https://github.com/jekyll/github-metadata
 -->

### Github repositories

I started using Github back in 2015. I wanted the hability to have private repositories so I moved most of my codes to bitbucket which had private repositories then. Now I'm slowly moving back to Github which has some other advantages on top of having incorporated private repositories. Most of my repositories are hidden and have code from university assignments.

Here are my public repositories:

{% for repository in site.github.public_repositories %}
  * [{{ repository.name }}]({{ repository.html_url }})
{% endfor %}
