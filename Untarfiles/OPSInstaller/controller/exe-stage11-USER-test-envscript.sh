# OpenStack installation script 
#
#!/bin/bash -x
cd /home/vasabi-1234loginname4321-ibasav/OPSInstaller/controller; pwd
echo "Run this script with sudo or as root."
echo -n "1. set admin-openrc.sh "
source ./admin-openrc.sh

openstack token issue
