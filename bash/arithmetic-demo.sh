#!/bin/bash
#
# this script demonstrates doing arithmetic

# Task 1: Remove the assignments of numbers to the first and second number variables.
#         Use one or more read commands to get 3 numbers from the user.
# Task 2: Change the output to only show:
#    the sum of the 3 numbers with a label
#    the product of the 3 numbers with a label

read -p "Please enter 3 numbers: " num1 num2 num3

sum=$(( num1 + num2 + num3))
product=$(( num1 * num2 * num3 ))

cat <<EOF
The sum of $num1, $num2, and $num3 is $sum.
The product of these three numbers is $product.
EOF
