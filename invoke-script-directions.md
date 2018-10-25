Having written the script, you can invoke it by sh scriptname, [1] or alternatively bash scriptname. (Not recommended is using sh <scriptname, since this effectively disables reading from stdin within the script.) Much more convenient is to make the script itself directly executable with a chmod.

Either:
chmod 555 scriptname (gives everyone read/execute permission) [2]

or
chmod +rx scriptname (gives everyone read/execute permission)

chmod u+rx scriptname (gives only the script owner read/execute permission)

Having made the script executable, you may now test it by ./scriptname. [3] If it begins with a "sha-bang" line, invoking the script calls the correct command interpreter to run it.

As a final step, after testing and debugging, you would likely want to move it to /usr/local/bin (as root, of course), to make the script available to yourself and all other users as a systemwide executable. The script could then be invoked by simply typing scriptname [ENTER] from the command-line.

source: http://tldp.org/LDP/abs/html/invoking.html