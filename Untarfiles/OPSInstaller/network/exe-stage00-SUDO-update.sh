# OpenStack installation script
#!/bin/bash 
#
cd /home/vasabi-1234loginname4321-ibasav/OPSInstaller/network; pwd

cp files/hosts /etc/hosts
#cp /etc/apt/sources.list /etc/apt/sources.list.saved
#cp files/local-sources.list /etc/apt/sources.list
 
apt-get update
#printf "set repo and update\n"
#apt-get -y install software-properties-common
add-apt-repository cloud-archive:victoria
#add-apt-repository cloud-archive:wallaby
#
# assume the controller is up to date.
#
apt-get update 
apt-get -y dist-upgrade
apt-get -y install python3-openstackclient
apt -y install ifupdown net-tools
# reboot (if needed)
reboot
