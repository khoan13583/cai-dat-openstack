# OpenStack installation script 
#
#!/bin/bash -x
cd /home/vasabi-1234loginname4321-ibasav/OPSInstaller/controller; pwd
echo "Run this script as a user."
echo -n "Verify neutron"
source ./admin-openrc.sh
openstack extension list --network
