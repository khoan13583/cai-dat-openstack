# OpenStack installation script 
#
#!/bin/bash -x
cd /home/vasabi-1234loginname4321-ibasav/OPSInstaller/controller; pwd
echo "Run this script with sudo or as root."
echo -n "Install nuetron..."
#read varkey
apt-get -y install neutron-server neutron-plugin-ml2 
apt-get -y install python3-neutronclient
apt-get -y install openvswitch-switch

cp files/neutron.conf /etc/neutron/neutron.conf
cp files/ml2_conf.ini /etc/neutron/plugins/ml2/ml2_conf.ini
cp files/nova-stage23.conf /etc/nova/nova.conf

su -s /bin/sh -c "neutron-db-manage --config-file /etc/neutron/neutron.conf \
  --config-file /etc/neutron/plugins/ml2/ml2_conf.ini upgrade head" neutron

service nova-api restart
service neutron-server restart
