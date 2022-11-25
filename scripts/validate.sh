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
	echo "validator should return the string 'OK' or the string that explains the error"
	echo -e "validator first take in input the generator input and next the program output${NC}"
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
    ./$1 < input > out
    cat input out > data
    ./$2 < data > res
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
        rm $1 $2 $3 input out res data
        exit
    fi
done
echo ""
echo -e "${BLUE}Passed $4 tests!!!${NC}"
rm $1 $2 $3 input out res data