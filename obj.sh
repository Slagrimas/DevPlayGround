#!/bin/bash

#TRAP CTRL-C
function ctrl_c() {
  echo "\nGOOD-BYE"
  exit 1
}
trap ctrl_c INT

#groupid=`cat groupid.json`

value=($(jq -r '.GroupId' groupid.json))

echo $value