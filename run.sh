#!/bin/sh

selection=$1
arg=$2


case $selection in
	new | n)
    article=$(echo $arg | sed -e 's/\ /-/g')
	  hugo new posts/${article}.md
	  mkdir -p content/posts/${article}/
	  mv content/posts/${article}.md content/posts/${article}/index.md
	;;

	serve | s)
	   hugo --config config.toml serve -D --disableFastRender --port 3030 --bind ${arg}
	;;

	local | l)
	   hugo --config config.toml serve -D --disableFastRender --port 3030 --bind $(hostname -I)
	;;
	*)
	   echo "Usage:"
	   echo "$0 [new|n] 'article title name' - To create new article"
	   echo "$0 [local|l]  To start server to ip bind"
	   echo "$0 [serve|s]  IP_BIND - To start server and bind to ip"
	;;
esac
