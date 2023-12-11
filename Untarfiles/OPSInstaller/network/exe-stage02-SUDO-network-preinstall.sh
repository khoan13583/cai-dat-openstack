# OpenStack installation script
#!/bin/bash -x
cd /home/vasabi-1234loginname4321-ibasav/OPSInstaller/network; pwd
printf "1. set interface/hosts files.. press any key\n"
#read varkey
cp files/interfaces /etc/network/interfaces
cp files/hosts /etc/hosts

printf "2. set ntp server.. press any key\n"
#read varkey
apt-get -y install chrony
cp files/chrony.conf /etc/chrony/chrony.conf
service chrony restart

printf "3. restart eth networking.. press\n"
#read varkey
#ifdown vasabi-1234network_ip_nic4321-ibasav
#ifup vasabi-1234network_ip_nic4321-ibasav
ifdown vasabi-1234data_tunnel_network_node_ip_nic4321-ibasav
ifup vasabi-1234data_tunnel_network_node_ip_nic4321-ibasav
ifdown vasabi-1234vlan_network_node_ip_nic4321-ibasav
ifup vasabi-1234vlan_network_node_ip_nic4321-ibasav
ifdown vasabi-1234external_cidr_nic4321-ibasav
ifup vasabi-1234external_cidr_nic4321-ibasav
#
service networking restart
#
sleep 5
date
# restore later 
#cp /etc/sudoers files/sudoers.save
#
ifconfig
