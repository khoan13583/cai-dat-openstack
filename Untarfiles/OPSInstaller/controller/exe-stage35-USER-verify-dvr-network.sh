# OpenStack installation script 
#
#!/bin/bash -x
cd /home/vasabi-1234loginname4321-ibasav/OPSInstaller/controller; pwd
echo "Run this script as a user."
#read varkey
source ./admin-openrc.sh
openstack extension list --network
openstack compute service list
openstack network agent list
