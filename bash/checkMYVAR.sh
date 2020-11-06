#!/bin/bash
# This script demonstrates testing if a variable named MYVAR exists and whether it is empty
# It is expected that you use this script to test if MYVAR is inherited from a parent process
#   since it is not created or modified in this script

[ -v MYVAR ] && echo "The variable MYVAR exists"
[ -v MYVAR ] || echo "The variable MYVAR does not exist"

[ -v MYVAR ] && [ -n "$MYVAR" ] && echo "The variable MYVAR has data in it"
[ -v MYVAR ] && [ -z "$MYVAR" ] && echo "The variable MYVAR is empty"
