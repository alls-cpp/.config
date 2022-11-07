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
for ((testNum=0;testNum<$4;testNum++))
do
    ProgressBar ${testNum} ${4}
    ./$3.exe > input
    ./$2.exe < input > outSlow
    ./$1.exe < input > outWrong
    H1=`md5sum outWrong`
    H2=`md5sum outSlow`
    if !(cmp -s "outWrong" "outSlow")
    then
        echo -e "${RED}Error found!"
        echo -e "${BLUE}Input:${NC}"
        cat input
        echo -e "${BLUE}$1 output:${NC}"
        cat outWrong
        echo -e "${BLUE}$2 output:${NC}"
        cat outSlow
        exit
    fi
done
echo ""
echo Passed $4 tests


