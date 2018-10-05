#!/bin/bash

curl http://localhost:9000/ &> curlmsg.txt

# Look if the word refused is in log file
if grep Failed curlmsg.txt; then
    echo ${RED}Curl failed
    rm curlmsg.txt
    exit 1
fi
