# OpenStack installation script 
#
#!/bin/bash -x
cd /home/vasabi-1234loginname4321-ibasav/OPSInstaller/controller; pwd
echo "Run this script as a user."
printf "\nCreate cinder database tables...\n"
#read varkey
mysql -u root -pmysqlpassword -e "CREATE DATABASE cinder;"
mysql -u root -pmysqlpassword -e "GRANT ALL PRIVILEGES ON cinder.* TO 'cinder'@'localhost' IDENTIFIED BY 'vasabilabCINDER_DBPASS';"
mysql -u root -pmysqlpassword -e "GRANT ALL PRIVILEGES ON cinder.* TO 'cinder'@'%' IDENTIFIED BY 'vasabilabCINDER_DBPASS';"
