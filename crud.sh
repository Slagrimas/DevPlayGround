#!/bin/bash

#KEYS --------->
# --silent => if successful no output required



#COLOR VARIABLES
RED="\033[1;31m" # warning echo
GREEN="\033[1;32m" # info echo
YELLOW="\033[93m" # question echo
CYAN="\033[96m" # success echo
BOLDUNDERLINE="\033[1;4m" # warning echo

# Check bash version --silent
if test -z "$BASH_VERSION"; then
  echo "${RED}Please run this script using bash, not sh or any other shell." >&2
  exit 1
fi

#FUNCTIONS --------->

#TRAP CTRL-C
function ctrl_c() {
  echo "\n${RED}${BOLDUNDERLINE}GOOD-BYE"
  exit 1
}


#FUNCTIONS --------->

# TRAP CTRL-C
trap ctrl_c INT
# TRAP CTRL-C


# SYSTEM VARIABLES
re='^[0-9]+$' #regex integer check

# ARGUMENT VARIABLES
PORT=$1
projectname=$2

# Checking if argument is empty
if [ "$PORT" == "" ]; then
		echo "${RED}Please try again, pass in a port number ex. crud 3000 projectname" >&2;
		exit 1
fi

# Checking if argument $1 is an integer
if ! [[ $PORT =~ $re ]] ; then
   echo "${RED}Please enter arguments in this order & use only number for the port - ex.${GREEN} crud 3000 projectname" >&2; 
   exit 1
fi

# Checking if more than one argument was passed
if [ "$#" -ne 2 ]; then
    echo "${RED}Looks like you forgot something - ex. crud 3000 projectname" >&2;
    exit 1
fi

# check if port is running
# if it is give user option to kill and replace with new one
# if they dont want to replace - exit and give option to re-run with new port number

# this command probably only works on mac
# TODO: do an OS check here for different commands
lsof -ti tcp:$PORT > portlog.txt

pid=`cat portlog.txt`

if [ "$pid" != "" ]; then
    echo "${RED}Looks like $PORT is in use, do you want us to kill it for you?[y|n]"
    read kill
    if [[ $kill = y ]] ; then
      kill $pid
    else
      echo "${RED}You can start over, re-run the script with a new port number"
      rm portlog.txt
      exit 1
    fi
fi
rm portlog.txt

# Begin folder & file creation
mkdir $projectname
# init npm
(cd $projectname && npm init -y > ./log )
(cd $projectname && rm log)
(cd $projectname && rm package.json)

echo "node_modules" > ./$projectname/.gitignore

# Replace with new package.json
echo '{
  "name": "express-crud-server",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1",
    "start": "npx nodemon index.js"
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "dependencies": {
    "body-parser": "^1.18.3",
    "express": "^4.16.3",
    "nodemon": "^1.18.4"
  }
}' > ./$projectname/package.json

# Create new CRUD Express file
echo "const express = require('express');
const bodyParser = require('body-parser');
const PORT = 9000;

// INIT
const app = express();

// parse application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: false }))
// parse application/json
app.use(bodyParser.json())

// READ
app.get('/', (req,res) => {
  // Serve Home Content here
  res.json({
    message: 'Read route',
    method: 'GET'
  });
});

// CREATE
app.post('/new', (req,res) => {
  let { email, password } = req.body;
  // Create new user here
  res.json({
    message: 'Create new route',
    method: 'POST',
    body: req.body
  });
});

// UPDATE
app.post('/edit', (req,res) => {
  let { email, password } = req.body;
  // Edit user here
  res.json({
    message: 'Edit route',
    method: 'POST',
    body: req.body
  });
});

// DELETE/ARCHIVE
app.post('/archive', (req,res) => {
  let { email, password } = req.body;
  // Archive user here
  res.json({
    message: 'Archive route',
    method: 'POST',
    body: req.body
  });
});

// 404
app.get('/*', (req,res) => {
  res.json({
    message: '404 route',
    method: 'GET'
  });
})

// LISTEN
app.listen(PORT, () => {
  console.log("'`Listening on port: ${PORT}`'")
});" > ./$projectname/index.js

# npm install packages
(cd $projectname && npm install)

# Run server
(cd $projectname && npm start)

# Test if server is up
curl http://localhost:$PORT/ &> curlmsg.txt

# Look if the word Failed is in log file
if grep Failed curlmsg.txt; then
    echo ${RED}Server is not up - ERROR found
    rm curlmsg.txt
    exit 1
else
  open http://localhost:${PORT}
fi
# Remove Log file
rm curlmsg.txt
exit 1