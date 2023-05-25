#!/bin/bash

echo "SUDOKU"
echo "How to play:"
echo "The goal of Sudoku is to fill in a 9x9 grid with digits so that each column, row, and 3×3 section contain the numbers between 1 to 9. At the beginning of the game, the 9×9 grid will have some of the squares filled in. Your job is to use logic to fill in the missing digits and complete the grid. Don’t forget, a move is incorrect if:"
echo "1. Any row contains more than one of the same number from 1 to 9"
echo "2. Any column contains more than one of the same number from 1 to 9"
echo "3. Any 3x3 grid contains more than one of the same number from 1 to 9"
echo "Do you want to start the game?(y/n)"
read reply
RED="\e[31m"
GREEN='\033[00;32m'
YELLOW='\033[00;33m'
BLUE='\033[00;34m'
PURPLE='\033[00;35m'
CYAN='\033[00;36m'
LIGHTGRAY='\033[00;37m'
clear='\033[0m'
BOLDGREEN="\e[1;${GREEN}"
function numberExists() {
    local target=$1
    local array=("${@:2}")
    for num in "${array[@]}"; do
        if [ $num -eq $target ]; then
            return 0  # Number exists in the array
        fi
    done

    return 1  # Number does not exist in the array
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
    local row=$1
    local array=("${@:3}")
       for (( i = $(( $row* 9 - 8 )); i<=$(( $row* 9 )); i++)) do
	        if [[ ${array[$(( $i-1 ))]} == $2 ]] ; then
                return 1
            fi
done
    return 0
}
function isColumn() {
    local cols=$1
    local colar=("${@:3}")
    local ascii=$(printf '%d' "'$cols")
    local column=$(( $ascii-96 ))
    for (( j = $column; j<=81; j=$(($j+9)))) do
	        if [[ ${colar[$(( $j-1 ))]} == $2 ]] ; then
                return 1
            fi
    done
    return 0
}
function isBox() {
    local cols=$1
    local colar=("${@:4}")
    local ascii=$(printf '%d' "'$cols")
    local col=$(( $ascii-96 ))
    local row=$2
    local arr=("${@:4}")
    if numberExists "$row" 1 2 3 ; then
        startRow=1
    elif numberExists "$row" 4 5 6 ; then
        startRow=4
    elif numberExists "$row" 7 8 9 ; then
        startRow=7
    fi
    if numberExists "$col" 1 2 3 ; then
        startCol=1
    elif numberExists "$col" 4 5 6 ; then
        startCol=4
    elif numberExists "$col" 7 8 9 ; then
        startCol=7
    fi
    for (( k = $startRow; k< $(($startRow+3)); k++)) do
	    for ((l = $startCol; l < $(($startCol + 3)); l++)); do
            local in=$((9*$k+$l-10))
            echo "$in ${arr[$in]}"
            if [[ ${arr[$in]} == $3 ]] ; then
                return 1
            fi
    done
    done
}


if [[ $reply == "y" ]];then
nums=($(python3 qgen.py | tr -d '[],'))
hu=0
while (finish "${nums[@]}") ; do
echo -e "${CYAN}    a   b   c   d   e   f   g   h   i"
echo -e "${YELLOW}  +---+---+---+---+---+---+---+---+---+"
i=0
for row in {1..9}; do
	echo -ne "${CYAN}$row "
       for column in {a..i} ; do

	        if [[ ${nums[$i]} == '0' ]] ; then
		       echo -ne "${YELLOW}|   "

		else
		       echo -ne "${YELLOW}| ${clear}${nums[$i]} "
fi
i=$(( $i+1 ))
done
echo -e "${YELLOW}|\n  +---+---+---+---+---+---+---+---+---+"
done 
read col row ans
if isBox "$col" "$row" "$ans" "${nums[@]}" && isRow "$row" "$ans" "${nums[@]}" && isColumn "$col" "$ans" "${nums[@]}" ; then
    ascii_val=$(printf '%d' "'$col")
    integer_val=$(( $ascii_val-96 ))
    hor=$(($row*9-9))
    index=$(($hor+$integer_val-1))
    nums[$index]=${BOLDGREEN}$ans
    echo "${nums[$index]}"
else
    echo -e "${RED}Incorrect move!"
fi
done
else 
	echo "Bye!"
fi
