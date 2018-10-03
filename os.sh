#!/bin/bash

RED="\033[1;31m" # warning
GREEN="\033[1;32m" # info
YELLOW="\033[93m" # question user
CYAN="\033[96m" # success echo
BOLDUNDERLINE="\033[1;4m" # warning echo

function buildWindows(){
	echo ${RED} Not yet supported.
}

function buildLinux(){
	pip install awscli --upgrade --user
	aws configure
}

function ctrl_c() {
  echo "\n${RED}${BOLDUNDERLINE}**** You have exited during mid process, sorry to see you leave ****"
  echo "${GREEN} You can start over again...just run the script"
  exit 1
}

# listen for ctrl_c during process - call the func
trap ctrl_c INT

function createBucket(){
	echo ${GREEN}Now that your all setup, lets create a bucket!

	# Create new S3 bucket that's public, read only:
	echo ${YELLOW}What would you like to name the bucket?
	read bucketname
	{ # try

    aws s3api create-bucket --bucket $bucketname --acl public-read --region us-west-2 --create-bucket-configuration LocationConstraint=us-west-2

	} || {

		echo ${RED} ERROR!

		exit 1
	}
	
	echo ${GREEN}Lets keep going...${YELLOW}

	# Configure bucket to serve static website
	read -p "Do you want to configure the bucket to serve static websites? $foo? [yn]" answer
	if [[ $answer = y ]] ; then
		echo "aws s3 website s3://$bucketname/ --index-document index.html --error-document index.html"
	  #aws s3 website s3://$bucketname/ --index-document index.html --error-document index.html
	else
		echo ${GREEN}Okay we wont!${YELLOW}
	fi

	# Upload all files in current directory excluding .git folder and apply public-read permissions to all files
	read -p "Do you want to upload all files in the current directory to your S3 bucket $foo? [yn]" answer
	if [[ $answer = y ]] ; then
	  aws s3 sync . s3://$bucketname --delete --grants --acl public-read --exclude '.git*'
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



