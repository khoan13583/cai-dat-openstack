# OpenStack installation script 
#
#!/bin/bash -x
cd /home/vasabi-1234loginname4321-ibasav/OPSInstaller/controller; pwd
echo "Run this script with sudo or as root."
#read varkey

cp files/neutron_stage31.conf /etc/neutron/neutron.conf

service neutron-server restart
