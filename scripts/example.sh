#!/usr/bin/env bash

BLUE='\033[0;36m'
NC='\033[0m' # no color

echo -e "${BLUE}cpb test a.cpp${NC} test your program against all available test cases"
echo -e "${BLUE}cpb test a.cpp -d${NC} to use keyboard as input"
echo -e "${BLUE}cpb test a.cpp -t 2 -d${NC} to use a test case file as input"
echo -e "${BLUE}cpb submit a.cpp${NC} submits your file to the corresponding judge"