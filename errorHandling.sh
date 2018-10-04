#!/bin/bash

RED="\033[1;31m" # warning
GREEN="\033[1;32m" # info
YELLOW="\033[93m" # question user
CYAN="\033[96m" # success echo
BOLDUNDERLINE="\033[1;4m" # warning echo

function ctrl_c() {
  echo "\n${RED}${BOLDUNDERLINE}**** You have exited during mid process, sorry to see you leave ****"
  echo "${GREEN} You can start over again...just run the script"
  exit 1
}

# listen for ctrl_c during process - call the func
trap ctrl_c INT

rm error.txt


function continueSetup(){
	echo continue the work duuuuuuude
}


# Ask the user for their name
function build(){
	echo ${YELLOW}Lets create a AWS group, what name would you like to give it${RED}?
	read groupname
	aws iam create-group --group-name $groupname &> error.txt

	# Ask the user for their name
	if grep EntityAlreadyExists error.txt; then
			echo ${RED}Looks like the group already exists...Lets try that again, with a new name
	    build INT
	else
		# Ask the user for their name
		if grep CreateDate error.txt; then
				echo ${CYAN}Success..lets continue
				continueSetup INT
		fi
	fi
}


build INT