#!/bin/bash

RED="\033[1;31m" # warning
GREEN="\033[1;32m" # info
YELLOW="\033[93m" # question user
CYAN="\033[96m" # success echo
BOLDUNDERLINE="\033[1;4m" # warning echo

function ctrl_c() {
  echo "${RED}${BOLDUNDERLINE}**** You have exited during mid process, sorry to see you leave ****"
  echo "${GREEN} You can start over again...just run the script"
  exit 1
}

# listen for ctrl_c during process - call the func
trap ctrl_c INT

# Ask the user for their name
echo ${YELLOW}Lets create a AWS group, what name would you like to give it${RED}?
read groupname

{ # try

    aws iam create-group --group-name $groupname &&
    echo ${CYAN}AWS $groupname has been created!

} || 

echo ${YELLOW}For the AWS group $groupname, what policy would you like to attach${RED}?
read policy
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/$policy --group-name $groupname
echo ${CYAN}Fantastic! the $policy has been attached to $groupname
echo "***************************"
echo ${GREEN}Wow! That was easy...
echo ${YELLOW}Okay what is your username, we will add it to the new group${RED}?
read username
aws iam add-user-to-group --user-name $username --group-name $groupname
echo ${CYAN}Done and Done! User is now a member of $groupname


function buildWindows(){
	echo ${RED} Not yet supported.
}

function buildLinux(){
	pip install awscli --upgrade --user
	aws configure
}

function createBucket(){
	echo ${GREEN}Now that your all setup, lets create a bucket!

	# Create new S3 bucket that's public, read only:
	echo ${YELLOW}What would you like to name the bucket?
	read bucketname
	aws s3api create-bucket --bucket $bucketname --acl public-read --region us-west-2 --create-bucket-configuration LocationConstraint=us-west-2
	
	echo ${GREEN}Lets keep going...${YELLOW}

	# Configure bucket to serve static website
	read -p "Do you want to configure the bucket to serve static websites? $foo? [yn]" answer
	if [[ $answer = y ]] ; then
	  aws s3 website s3://$bucketname/ --index-document index.html --error-document index.html
	else
		echo ${GREEN}Okay we wont!${YELLOW}
	fi

	# Upload all files in current directory excluding .git folder and apply public-read permissions to all files
	read -p "Do you want to upload all files in the current directory to your S3 bucket $foo? [yn]" answer
	if [[ $answer = y ]] ; then
	  aws s3 sync . s3://$bucketname --delete --acl public-read --exclude '.git*'
	else
		echo ${GREEN}Okay we wont!
	fi

	echo ${CYAN}Setup Complete! - We are opening your S3 bucket in the browser now, enjoy...

	open http://$bucketname.s3-website-us-west-2.amazonaws.com

	exit 1

}






function buildMac(){
	# step 1 brew install awscli
	echo "${RED}Enter Access Key Id & Secret Access Key"
	echo ${RED}Set Default region to us-west-2${CYAN}
	# step 2 aws configurition
	#aws configure

	# continue to step 3
	createBucket INT
}


# Detect the platform (similar to $OSTYPE)
OS="`uname`"
case $OS in
  'Linux')
    OS='Linux'
    buildLinux INT
    ;;
  'FreeBSD')
    OS='FreeBSD'
    alias ls='ls -G'
    ;;
  'WindowsNT')
    OS='Windows'
    buildWindows INT
    ;;
  'Darwin') 
    OS='mac'
    buildMac INT
    ;;
  'SunOS')
    OS='Solaris'
    ;;
  'AIX') ;;
  *) ;;
esac