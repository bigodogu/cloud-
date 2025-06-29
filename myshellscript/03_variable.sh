#!/bin/bash
#
#
#Script to show how to use variables
#

a=20
name="Shekhar"
age=28

echo "My name is $name and age is $age"

name="mahesh"

echo "my name is $name"

# showing the hostname with command

HOSTNAME=$(hostname)

echo "name of the machine $HOSTNAME"

