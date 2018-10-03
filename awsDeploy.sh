#!/bin/bash

RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[93m"
CYAN="\033[96m"
BOLDUNDERLINE="\033[1;4m"

function ctrl_c() {
  echo "${RED}${BOLDUNDERLINE}**** You have exited during mid process, sorry to see you leave ****"
  echo "${GREEN} You can start over again...just run the script"
  exit 1
}

# listen for ctrl_c during process - call the func
trap ctrl_c INT

# Ask user for AWS group name
echo ${YELLOW}Lets create a AWS group, what name would you like to give it${RED}?
read groupname
# run aws-cli command to create groupname
aws iam create-group --group-name $groupname
# confirm its been created
echo ${GREEN}AWS $groupname has been created!
# ask user what policy should be attached to the newly created group
echo ${YELLOW}For the AWS group $groupname, what policy would you like to attach${RED}?
read policy
# run aws-cli command to attach policy to the group
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/$policy --group-name $groupname
# confirm policy has been added to group
echo ${GREEN}Fantastic! the $policy has been attached to $groupname
echo "***************************"
echo ${CYAN}Wow! That was easy...let continue
# ask user what username should be added to this policy
echo ${GREEN}Okay what is your username, we will add it to the new group${RED}?
read username
# run aws-cli command to add user to the newly created group
aws iam add-user-to-group --user-name $username --group-name $groupname
# confirm user was added
echo ${CYAN}Done and Done!
