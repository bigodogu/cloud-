#!/bin/bash
#
#
#
#condi1 && condi2 || condi3
#
read -p "enter your age: " age

[[ $age -ge 18 ]] && echo "adult" || echo "minor"
