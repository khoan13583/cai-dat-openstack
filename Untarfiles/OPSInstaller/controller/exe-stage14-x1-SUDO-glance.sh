# OpenStack installation script 
#
#!/bin/bash -x
cd /home/vasabi-1234loginname4321-ibasav/OPSInstaller/controller; pwd
echo "Run this script with sudo or as root."
echo -n "Install glance... again"

#Fix bug
#dpkg -i --force-overwrite /var/cache/apt/archives/python3-cinderclient_1%3a5.0.0-0ubuntu2~cloud0_all.deb
#apt-get -y install glance
#echo -n "re dpkg ..press any key"
#read varkey
#dpkg -i --force-overwrite /var/cache/apt/archives/python3-cinderclient_1%3a5.0.0-0ubuntu2~cloud0_all.deb

cp files/glance-api.conf /etc/glance/glance-api.conf

echo "su -s /bin/sh -c \"glance-manage db_sync\" glance"
su -s /bin/sh -c "glance-manage db_sync" glance
#
service glance-api restart
#
