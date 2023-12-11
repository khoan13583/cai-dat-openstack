# OpenStack installation script 
#
#!/bin/bash -x
cd /home/vasabi-1234loginname4321-ibasav/OPSInstaller/controller; pwd
echo "Run this script with sudo or as root."
echo -n "Install placement"

apt -y install placement-api 

cp files/placement.conf /etc/placement/placement.conf

echo "su -s /bin/sh -c \"placement-manage db sync\" placement"
su -s /bin/sh -c "placement-manage db sync" placement
#
service apache2 restart
#
