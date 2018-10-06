#!/bin/bash

#TRAP CTRL-C
function ctrl_c() {
  echo "\nGOOD-BYE"
  exit 1
}
trap ctrl_c INT

echo MacOS support only - initiating ec2 instance tool


# Checking if needed packages are installed
package_name=jq
t=`which $package_name`
[ -z "$t" ] && brew install jq

package_name=aws
t=`which $package_name`
[ -z "$t" ] && echo You are missing the aws-cli. You can install it by typing 'brew install awscli' && exit 1

# FIRST Get region to set ami allowed
aws configure get region &> region.txt

region=`cat region.txt`
case $region in
  'us-east-1')
    region='us-east-1'
    instanceid=0ac019f4fcb7cb7e6
    echo ATTN: We will setup a Ubuntu 18.04 instance, at the time this script was made - 10/2018 - this ami-$instanceid was "Free Tier Eligible"
    ;;
  'us-east-2')
    region='us-east-2'
    instanceid=0f65671a86f061fcd
    echo ATTN: We will setup a Ubuntu 18.04 instance, at the time this script was made - 10/2018 - this ami-$instanceid was "Free Tier Eligible"
    ;;
  'us-west-1')
    region='us-west-1'
    instanceid=063aa838bd7631e0b
    echo ATTN: We will setup a Ubuntu 18.04 instance, at the time this script was made - 10/2018 - this ami-$instanceid was "Free Tier Eligible"
    ;;
  'us-west-2') 
    region='us-west-2'
    instanceid=0bbe6b35405ecebdb
    echo ATTN: We will setup a Ubuntu 18.04 instance, at the time this script was madee - 10/2018 - this ami-$instanceid was "Free Tier Eligible"
    ;;
  'us-east-222')
    echo Your region is not supported yet
    ;;
  'AIX') ;;
  *) ;;
esac

echo Please enter a security group name[lowercase]?
read groupname

aws ec2 create-security-group --group-name $groupname --description "security group for development environment" &> groupid.txt

groupid=`cat groupid.txt`



