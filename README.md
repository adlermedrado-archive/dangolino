# Just my simple blog engine

<hr>

*it's my static site generator* written in Ruby.

<hr>

## How it works

First, you need to create 3 templates:

* index.mustache
* all_posts.mustache
* post.mustache

index.mustache will be parsed to be your homepage, post.mustache will be parsed to each post to your site and all_posts.mustache will be parsed to create an post listing.

Every new post, must be written in HTML or Markdown and after it'll be parsed and your new post will be generated to a plain HTML file.

Just like that:

	cd bin
	ruby dangolino.rb --year 2012 --month 09 --file /home/adler/posts/my_new_post.md --link my-new-post --title "My new Post" --format markdown

_If you want to parse from HTML files, you can ommit --format parameter._

The comand above will generate the new files and create new all_posts.html and index.html files.

## Configuration file

For configure your site, you will need to create an yaml file like this one located at: dangolino_dir/lib/dangolino/config/settings.yml

	---
	path:
	    root_dir: /Users/adler/Dropbox/dangolino
	    generate_dir: /Users/adler/Dropbox/dangolino/site
	    template_dir: /Users/adler/Dropbox/dangolino/templates
	    lib_dir: /Users/adler/Dropbox/dangolino/lib
	    datafile: /Users/adler/Dropbox/dangolino/lib/dangolino/data/post_listing
	    url: http://yoursite.com
	mysql:
	    host: 127.0.0.1
	    user: root
	    pass: ""
	    dbname: blog_adler


## Import from Wordpress

You can import from wordpress filling database data on settings.yml above and running:

	cd bin/
	ruby dangolino-import.rb
	

## To-do list

* Create an database backend instead of a flat file
* Improve multi-site support
* Support Less

## Notice

It's open-source, BSD-like licensed and you can use without restrictions, but, at your own risk.

## And... 

I did it for myself, i use this on my personal website: http://adlermedrado.com.br.

It works fine for me, but it doesn't means that it will work fine for you.


