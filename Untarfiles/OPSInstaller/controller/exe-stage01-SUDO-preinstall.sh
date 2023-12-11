# OpenStack Queens installation script
#!/bin/bash -x
#
cd /home/vasabi-1234loginname4321-ibasav/OPSInstaller/controller; pwd
printf "1. inspect controller's  interface/hosts files..\n"
#read varkey

cat /etc/netplan/00-installer-config.yaml
cat /etc/hosts

printf "2. set ntp server usig chrony\n"
#read varkey
apt-get -y install chrony

cp files/chrony.conf /etc/chrony/chrony.conf
service chrony restart
#
