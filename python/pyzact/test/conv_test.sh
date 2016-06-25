#!/bin/bash

source "$(dirname $0)/utils.sh"
SCRIPT="./conv"

echo "=== $SCRIPT ==="


cmd="seq 10 | $SCRIPT 2"
expect="\
1 2
2 3
3 4
4 5
5 6
6 7
7 8
8 9
9 10"
actual=$(eval "$cmd")

echo "> $cmd"
gdiff <(echo "$expect") <(echo "$actual")


cmd="yes | awk '\$0=NR' | $SCRIPT 3 | head -5"
expect="\
1 2 3
2 3 4
3 4 5
4 5 6
5 6 7"
actual=$(eval "$cmd")

echo "> $cmd"
gdiff <(echo "$expect") <(echo "$actual")