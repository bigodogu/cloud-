#!/bin/bash

#############################
# Author: Shiva kumar
# Date:  05/14/2025
# 
# This Script lists AWS Instances
#
############################

# Check if AWS CLI IS Installed

if ! command -v aws  &> /dev/null
then
	echo " AWS CLI is not installed. Please install it to continue"
	exit 1
fi

#echo "Fectching EC2 Instances"

# Describe instances and filter relevant data

#aws ec2 describe-instances \
#	--query "Reservations[].Instances[].{InstanceID:InstanceId,State:State.Name,Name:Tags[?Key=='Name'][0].Value}" \
#	--output table
echo "Fectching aws s3 buckets"

aws s3 ls
