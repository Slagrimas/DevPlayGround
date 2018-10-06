#!/bin/bash

#TRAP CTRL-C
function ctrl_c() {
  echo "\nGOOD-BYE"
  exit 1
}
trap ctrl_c INT

ssh -i testseven-key.pem ubuntu@18.191.211.17 'bash -s' < os.sh
