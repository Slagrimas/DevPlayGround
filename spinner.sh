#!/bin/bash

#TRAP CTRL-C
function ctrl_c() {
  echo "\nGOOD-BYE"
  exit 1
}
trap ctrl_c INT

# spinner example
# i=1
# sp="/-\|"

# while true
# do
#     printf "\b${sp:i++%${#sp}:1}"
# done


function progressBar() {
  local duration=1000

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

progressBar INT