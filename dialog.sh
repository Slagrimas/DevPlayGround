#!/bin/bash

#TRAP CTRL-C
function ctrl_c() {
  echo "\nGOOD-BYE"
  exit 1
}
trap ctrl_c INT

# start editing your bash script here


function stretchTime(){
	read -r -d '' applescriptCode <<'EOF'
   set dialogText to text returned of (display dialog "Stretch! Enter secret code to end!" default answer "")
   return dialogText
EOF

dialogText=$(osascript -e "$applescriptCode");

if [ "$dialogText" = "done" ]; then
    echo "Go back to work!"
else
	osascript -e 'tell app "System Events" to display dialog "Dont skip stretch time!"'
fi
}

stretchTime INT