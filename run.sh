#!/bin/sh

selection=$1
arg=$2


case $selection in
	new | n)
	   hugo new posts/${arg}.md
	   mkdir -p content/posts/${arg}/
	   mv content/posts/${arg}.md content/posts/${arg}/index.md
	;;

	serve | s)
	   hugo --config config.toml serve -D --disableFastRender --port 3030 --bind ${arg}
	;;
	*)
	   echo "Usage:"
	   echo "$0 [new|n] 'article-title-name' - To create new article"
	   echo "$0 [serve|s]  IP_BIND - To start server and bind to ip"
	;;
esac
