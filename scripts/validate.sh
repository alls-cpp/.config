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
	echo "validate.sh  solution  validator  generator  numTests"
	echo ""
	echo -e "${BLUE}remove cin >> testcase"
	echo "validator should return "OK" or the string that explain the error"
	echo -e "validator first take in input the generator input and next the program output${NC}"
    exit 0
fi
for ((testNum=0;testNum<$4;testNum++))
do
    ProgressBar ${testNum} ${4}
    ./$3.exe > input
    ./$1.exe < input > out
    cat input out > data
    ./$2.exe < data > res
    result=$(cat res)
    if [ "${result:0:2}" != "OK" ];
    then
        echo -e "${RED}Error found!${NC}"
        echo -e "${BLUE}Input:${NC}"
        cat input
        echo -e "${BLUE}Output:${NC}"
        cat out
        echo -e "${BLUE}Validator result:${NC}"
        cat res 
        exit
    fi
done
echo ""
echo Passed $4 tests


