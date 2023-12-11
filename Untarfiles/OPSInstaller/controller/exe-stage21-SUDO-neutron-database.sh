# OpenStack installation script 
#
#!/bin/bash -x
cd /home/vasabi-1234loginname4321-ibasav/OPSInstaller/controller; pwd
echo "Run this script as a user."
printf "\nCreate neutron database...\n"

mysql -u root -pvasabilabMYSQL_PASS -e "CREATE DATABASE neutron;"
mysql -u root -pvasabilabMYSQL_PASS -e "GRANT ALL PRIVILEGES ON neutron.* TO 'neutron'@'localhost' IDENTIFIED BY 'vasabilabNEUTRON_DBPASS';"
mysql -u root -pvasabilabMYSQL_PASS -e "GRANT ALL PRIVILEGES ON neutron.* TO 'neutron'@'%' IDENTIFIED BY 'vasabilabNEUTRON_DBPASS';"
