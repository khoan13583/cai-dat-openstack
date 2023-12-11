# OpenStack installation script
#
#!/bin/bash -x
cd /home/vasabi-1234loginname4321-ibasav/OPSInstaller/controller; pwd
echo "Run this script as a sudo user."
echo -n "1. create keystone database user..."
#read varkey
#
mysql -u root -pvasabilabMYSQL_PASS -e "CREATE DATABASE keystone;"
mysql -u root -pvasabilabMYSQL_PASS -e "GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'localhost' IDENTIFIED BY 'vasabilabKEYSTONE_DBPASS';"
mysql -u root -pvasabilabMYSQL_PASS -e "GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'%' IDENTIFIED BY 'vasabilabKEYSTONE_DBPASS';"
#
