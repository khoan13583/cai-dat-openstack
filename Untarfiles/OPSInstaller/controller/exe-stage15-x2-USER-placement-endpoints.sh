# OpenStack installation script
#
#!/bin/bash -x
cd /home/vasabi-1234loginname4321-ibasav/OPSInstaller/controller; pwd
echo "Run this script as a user."
source ./admin-openrc.sh
#
openstack user create --domain default --password vasabilabPLACEMENT_PASS placement
#
openstack role add --project service --user placement admin
#
openstack service create --name placement \
  --description "Placement API" placement

openstack endpoint create --region RegionOne \
  placement public http://controller:8778
openstack endpoint create --region RegionOne \
  placement internal http://controller:8778
openstack endpoint create --region RegionOne \
  placement admin http://controller:8778
