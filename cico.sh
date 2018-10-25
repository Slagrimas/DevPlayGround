#!/bin/bash

#TRAP CTRL-C
function ctrl_c() {
  echo "\nGOOD-BYE"
  exit 1
}
trap ctrl_c INT


# TEST VARIABLES
re='^[0-9]+$' #regex integer check

# ARGUMENT VARIABLES
user=$1
time=$2

# Checking if argument is empty
if [ "$user" == "" ]; then
		echo "Please try again, ex. cico baseem time" >&2;
		exit 1
fi

# Checking if argument is empty
if [ "$time" == "" ]; then
		echo "Please try again, ex. cico baseem time" >&2;
		exit 1
fi

echo $user $time 