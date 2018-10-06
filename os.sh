#!/bin/bash

username=userone

sudo adduser $username && sudo mkdir /home/$username/.ssh && sudo bash -c "echo '<id-rsa.pub' > /home/$username/.ssh/authorized_keys" && sudo usermod -aG sudo $username && sudo chown -R $username:$username /home/$username/.ssh


exit