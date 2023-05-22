#!/bin/bash

echo "SUDOKU"
echo "How to play:"
echo "The goal of Sudoku is to fill in a 9x9 grid with digits so that each column, row, and 3×3 section contain the numbers between 1 to 9. At the beginning of the game, the 9×9 grid will have some of the squares filled in. Your job is to use logic to fill in the missing digits and complete the grid. Don’t forget, a move is incorrect if:"
echo "1. Any row contains more than one of the same number from 1 to 9"
echo "2. Any column contains more than one of the same number from 1 to 9"
echo "3. Any 3x3 grid contains more than one of the same number from 1 to 9"
echo "Do you want to start the game?(y/n)"
nums=($(python3 qgen.py | tr -d '[],'))
read reply
function numberofelements(){
	p=0
	arr=("$@")
	for i in "${arr[@]}";
		do
            p=$(( $p+1 ))
	done
    echo "$p"
}

function finish(){
    nums=("$@")
    var="done"
    for i in "${nums[@]}"; 
        do
            if [[ $i == '0' ]] ; then
                var="notdone"
            fi
    done
    if [[ $var != "notdone" ]] ; then
        return 1
    else
        return 0
    fi
}

function isRow() {
    row=$1
    echo "ans$2"
    array=("${@:3}")
       for (( i = $(( $row* 9 - 8 )); i<=$(( $row* 9 )); i++)) do
	        if [[ ${array[$i]} == $2 || ${array[$i]} != '0' ]] ; then
                echo "Wrong$i"
            else
                echo "correct$i"
            fi
done
}

function isRepeated() {
    arr=("${@:2}")
    rep="notrepeated"
    for i in "${nums[@]}"; 
        do
            if [[ $i == $1 ]] ; then
                rep="repeated"
            fi
    done
    if [[ $rep == "repeated" ]] ; then
        echo "Incorrect!"
    fi
}

if [[ $reply == "y" ]];then
while ! finish "${nums[@]}"
echo "hi"
do
echo "    a   b   c   d   e   f   g   h   i"
echo "  +---+---+---+---+---+---+---+---+---+"

i=0
for row in {1..9}; do
	echo -n "$row "
       for column in {a..i} ; do

	        if [[ ${nums[$i]} == '0' ]] ; then
		       echo -n "|   "

		else
		       echo -n "| ${nums[$i]} "
fi
i=$(( $i+1 ))
done
echo -e "|\n  +---+---+---+---+---+---+---+---+---+"
done
read col row ans
isRow "$row" "$ans" "${nums[@]}"
done
else 
	echo "Bye!"
fi
