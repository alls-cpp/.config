#!/usr/bin/env bash

RED='\033[0;35m'
BLUE='\033[0;36m'
NC='\033[0m' # no color

function ProgressBar {
    let _progress=(${1}*100/${2}*100)/100
    let _done=(${_progress}*4)/10
    let _left=40-$_done
    _fill=$(printf "%${_done}s")
    _empty=$(printf "%${_left}s")
    printf "\rProgress : [${_fill// /#}${_empty// /-}] ${_progress}%%"
}

if [ "$1" == "-h" ] ; then
	echo -e "${RED}EXAMPLE"
    echo "compare.sh  solution1  solution2  generator  numTests"
	echo ""
	echo -e "${BLUE}remove cin >> testcase${NC}"
    exit 0
fi
g++ $1.cpp -o $1
g++ $2.cpp -o $2 
g++ $3.cpp -o $3
if [ ! -f $1 ] || [ ! -f $2 ] || [ ! -f $3 ]; then
    exit 0
fi
for ((testNum=0;testNum<$4;testNum++))
do
    ProgressBar ${testNum} ${4}
    ./$3 > input
    ./$2 < input > outSlow
    ./$1 < input > outWrong
    if !(cmp -s "outWrong" "outSlow")
    then
        echo ""
        echo -e "${RED}Error found!"
        echo -e "${BLUE}Input:${NC}"
        cat input
        echo -e "${BLUE}$1 output:${NC}"
        cat outWrong
        echo -e "${BLUE}$2 output:${NC}"
        cat outSlow
        rm $1 $2 $3 input outWrong outSlow
        exit 0
    fi
done
echo ""
echo -e "${BLUE}Passed $4 tests!!!${NC}"
rm $1 $2 $3 input outWrong outSlow
exit 0