#!/bin/bash

#TRAP CTRL-C
function ctrl_c() {
  echo "\nGOOD-BYE"
  exit 1
}
trap ctrl_c INT



package_name=aws
t=`which $package_name`
[ -z "$t" ] && echo "the $package_name isn't installed!"