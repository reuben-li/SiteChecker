#!/bin/bash

echo enter URL
read URL

echo pagename
read name

echo enter number of iterations
read iter

echo "enter interval in seconds"
read interval

mkdir -p errors/
x=0
error=0
wget "$URL" -O "$name".html
SECONDS=0
while [ $x -lt $iter ]; do  wget "$URL" -O "$name"BUG.html -q; x=$(( $x + 1 ));
	if [ $(diff "$name".html "$name"BUG.html  | wc -l) == 0 ];
	then echo "iteration $x: no difference";
	else echo "iteration $x: DIFFERENCE SPOTTED"; cp "$name".html errors/; mv "$name"BUG.html errors/"$name"BUG"$error".html  ; error=$(( $error + 1 ));
	fi; sleep $interval;
done
rm "$name"BUG.html

echo "URL tested: $URL"
echo "Number of iterations: $iter"
echo "Number of errors: $error"
echo "Time taken: $SECONDS seconds"
echo
echo "click to exit"; read $STOP; exit

