# OpenStack installation script 
#
#!/bin/bash -x
cd /home/vasabi-1234loginname4321-ibasav/OPSInstaller/controller; pwd
echo "Run this script as a user."
echo -n "Verify nova"
#read varkey
source ./admin-openrc.sh

#openstack hypervisor list
#sudo su -s /bin/sh -c "nova-manage cell_v2 discover_hosts --verbose" nova
