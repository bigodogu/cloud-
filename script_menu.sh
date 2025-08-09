#!/bin/bash

####################
# Author: Shiva
# Date: 05/06/25
# 
# This script is to dispaly options to print system resources
#####################

while true; do
	echo "========MENU========"
	echo "1.Check disk Space"
	echo "2. Check Memory"
	echo "3. List users"
	echo "4. Exit"
	echo " ======================"
	read -p "Enter Your Choice (1-4): " choice 

	case $choice in
	
	1)
	echo "Disk Space:"
	df -h
	;;

	2)
	echo "Memory Usage"
	free -h
	;;

	3)
	echo "List users"
	who
	;;
	
	4)
	echo "Existing"
	break
	;;
	
	*)
	echo "Invalid choice. Please select 1-4."
	;;
	esac
	echo " "
	done

