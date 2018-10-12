#!/bin/bash


# Progress BAR
function progressBar() {
  local duration=20

  already_done() { for ((done=0; done<elapsed; done=done+1)); do printf "▇"; done }
  remaining() { for ((remain=elapsed; remain<duration; remain=remain+1)); do printf " "; done }
  percentage() { printf "| %s%%" $(( ((elapsed)*100)/(duration)*100/100 )); }
  clean_line() { printf "\r"; }

  for (( elapsed=1; elapsed<=duration; elapsed=elapsed+1 )); do
      already_done; remaining; percentage
      sleep 1
      clean_line
  done
  clean_line
}

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
rm region.txt

echo Please enter a security group name[lowercase]?
read groupname
# create aws security group name
aws ec2 create-security-group --group-name $groupname --description "security group for development environment" &> groupid.json

groupid=($(jq -r '.GroupId' groupid.json))
rm groupid.json

# give security group permission to expose port 22
aws ec2 authorize-security-group-ingress --group-name $groupname --protocol tcp --port 22 --cidr 0.0.0.0/0

echo Port 22 has been exposed
echo Which additional port do you want to expose[8080]?
read portnumber
# give security group permission to expose desired port
aws ec2 authorize-security-group-ingress --group-name $groupname --protocol tcp --port $portnumber --cidr 0.0.0.0/0

# create pem key
aws ec2 create-key-pair --key-name $groupname-key --query 'KeyMaterial' --output text > $groupname-key.pem

# give pem permission
chmod 400 $groupname-key.pem

# start instance - set ami id pass in group id - and use key pem
aws ec2 run-instances --image-id ami-$instanceid --security-group-ids $groupid --count 1 --instance-type t2.micro --key-name $groupname-key --query 'Instances[0].InstanceId' &> getipid.txt

getipid=`cat getipid.txt | sed -e 's/^"//' -e 's/"$//'`
progressBar INT
# give aws time to start-up ip
echo Checking if instance is running....


# get new instance ip address
aws ec2 describe-instances --instance-ids $getipid --query 'Reservations[0].Instances[0].PublicIpAddress' &> ip.txt

awsip=`cat ip.txt | sed -e 's/^"//' -e 's/"$//'`
rm ip.txt
rm getipid.txt

# TO BE CONTINUED ON part2.sh

# ssh -i $groupname-key.pem ubuntu@$awsip

echo "done"


#rm $groupname-key.pem





