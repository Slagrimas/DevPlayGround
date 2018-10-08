#!/bin/bash

#TRAP CTRL-C
function ctrl_c() {
  echo "\nGOOD-BYE"
  exit 1
}
trap ctrl_c INT

# Checking if needed packages are installed



mkdir $1

(cd ./$1 && npm init -y)
(cd ./$1 && echo "node_modules" > .gitignore)
(cd ./$1 && echo $1 > README.md)

echo cd into $1 to start

exit 1


