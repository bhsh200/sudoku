#!/bin/bash

echo "Do you want to start the game?(y/n)"

read reply

if [[ $reply == "y" ]];then
	nums=($(python3 qgen.py | tr -d '[],'))
echo "hi and bye"

echo "    a   b   c   d   e   f   g   h   i"
echo "  +---+---+---+---+---+---+---+---+---+"

i=0
for row in {1..9}; do
	echo -n "$row "
       for column in {a..i} ; do

	        if [ "$nums[$i]" = '0' ] ; then
		       echo -n "|  "
		else
		       echo -n "| ${nums[$i]} "
fi
i=$(( $i+1 ))
done
echo -e "|\n  +---+---+---+---+---+---+---+---+---+"
done

else 
	echo "Bye!"
fi






