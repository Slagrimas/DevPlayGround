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

yes=y
no=n
echo ${YELLOW}Welcome!
read -p "Do you want to configure the bucket to serve static websites? $foo? [yn]" answer
	if [[ $answer = y ]] ; then
	  echo running!
	else
		echo fine dont
	fi
