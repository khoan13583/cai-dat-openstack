# OpenStack Queens installation script
#!/bin/bash -x
cd /home/vasabi-1234loginname4321-ibasav/OPSInstaller/controller; pwd
echo "check chrony"
chronyc sources
sleep 1
#
apt-get -y install software-properties-common
apt update ; apt upgrade -y; apt clean ; apt autoremove -y
apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
add-apt-repository "deb [arch=amd64,arm64,ppc64el] http://mariadb.mirror.liquidtelecom.com/repo/10.4/ubuntu $(lsb_release -cs) main"
apt-get -y install mariadb-server
apt-get -y install python3-pymysql
#
printf "* set openstack.cnf configuration... \n" 
sleep 2
#read varkey
cp files/99-openstack.cnf /etc/mysql/mariadb.conf.d/99-openstack.cnf

service mysql restart

printf "\n *** First, enter blank for mysql password. Then set new password to\n        vasabilabMYSQL_PASS \n*** \n" 
sleep 2
mysql_secure_installation
systemctl status mysql
