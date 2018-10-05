#!/bin/bash

#KEYS --------->
# --silent => if successful no output required


#COLOR VARIABLES
RED="\033[1;31m" # warning echo
GREEN="\033[1;32m" # info echo
YELLOW="\033[93m" # question echo
CYAN="\033[96m" # success echo
BOLDUNDERLINE="\033[1;4m" # warning echo

# Check bash version --silent
if test -z "$BASH_VERSION"; then
  echo "${RED}Please run this script using bash, not sh or any other shell." >&2
  exit 1
fi

#FUNCTIONS --------->

#TRAP CTRL-C
function ctrl_c() {
  echo "\n${RED}${BOLDUNDERLINE}GOOD-BYE"
  exit 1
}


#FUNCTIONS --------->

# TRAP CTRL-C
trap ctrl_c INT
# TRAP CTRL-C


# SYSTEM VARIABLES
re='^[0-9]+$' #regex integer check

# ARGUMENT VARIABLES
PORT=$1

# Checking if argument is empty
if [ "$PORT" == "" ]; then
		echo "${RED}Please try again, pass in a port number ex. crud 3000" >&2;
		exit 1
fi

# Checking if argument is an integer
if ! [[ $PORT =~ $re ]] ; then
   echo "${RED}Please enter a port number only - ex. crud 3000" >&2; 
   exit 1
fi

# Checking if more than one argument was passed
if [ "$#" -ne 1 ]; then
    echo "${RED}Please enter only one argument - ex. crud 3000" >&2;
    exit 1
fi

echo 'everything worked!'

