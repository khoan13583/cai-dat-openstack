# OpenStack ocata installation script
#
#!/bin/bash 
#

cp files/hosts /etc/hosts
#cp /etc/apt/sources.list /etc/apt/sources.list.saved
#cp files/local-sources.list /etc/apt/sources.list
 
#apt-get -y install ubuntu-keyring

apt-get update
#
# We assume the ubuntu OS on every host is up to date.
#
#apt-get -y dist-upgrade

echo "Make sure to adjust the sudoer file to allow sudo without password."
read;
#echo "adjust sudoer file"
#./files/adjustsudoer.sh

apt-get -y install --no-install-recommends expect 
apt-get -y install sshpass
