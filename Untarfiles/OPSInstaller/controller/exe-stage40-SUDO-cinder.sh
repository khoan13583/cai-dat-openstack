# OpenStack installation script 
#
#!/bin/bash -x
cd /home/vasabi-1234loginname4321-ibasav/OPSInstaller/controller; pwd
echo "Run this script with sudo or as root."
echo -n "Install placement"

apt -y install cinder-api cinder-scheduler 

cp files/cinder.conf /etc/cinder/cinder.conf
cp files/nova-stage40.conf /etc/nova/nova.conf

echo "su -s /bin/sh -c \"cinder-manage db sync\" cinder"
su -s /bin/sh -c "cinder-manage db sync" cinder
#
service nova-api restart
service cinder-scheduler restart
#
service apache2 restart
#
