#!/bin/bash

#TRAP CTRL-C
function ctrl_c() {
  echo "\nGOOD-BYE"
  exit 1
}
trap ctrl_c INT

secretcode=$1


function stretchTime(){
	read -r -d '' applescriptCode <<'EOF'
   set dialogText to text returned of (display dialog "Stretch! Enter secret code to end!" default answer "")
   return dialogText
EOF

dialogText=$(osascript -e "$applescriptCode");

if [ "$dialogText" = "$secretcode" ]; then
    echo "Go back to work!"
else
	osascript -e 'tell app "System Events" to display dialog "Dont skip stretch time!"'
fi
}


# start editing your bash script here
echo starting stretch timer...
while true; do
  sleep 10
  stretchTime INT
done


