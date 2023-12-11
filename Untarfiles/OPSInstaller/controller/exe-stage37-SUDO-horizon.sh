# OpenStack installation script 
#
#!/bin/bash -x
cd /home/vasabi-1234loginname4321-ibasav/OPSInstaller/controller; pwd
echo "Run this script with sudo or as root."
echo "install horizon.."
#read varkey

apt-get -y install openstack-dashboard

cp files/local_settings.py /etc/openstack-dashboard/local_settings.py
cp files/openstack-dashboard.conf /etc/apache2/conf-available/openstack-dashboard.conf

systemctl reload apache2.service
