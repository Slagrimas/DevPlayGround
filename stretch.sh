#!/bin/bash

#TRAP CTRL-C
function ctrl_c() {
  echo "\nGOOD-BYE"
  exit 1
}
trap ctrl_c INT

# start editing your bash script here

while true; do
		sleep 30m
    osascript -e 'tell app "System Events" to display dialog "Stretch!"'
done