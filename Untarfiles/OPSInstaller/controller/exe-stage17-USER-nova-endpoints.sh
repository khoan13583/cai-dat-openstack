# OpenStack installation script 
#
#!/bin/bash -x
cd /home/vasabi-1234loginname4321-ibasav/OPSInstaller/controller; pwd
echo "Run this script  as user."
echo -n "Create nova user and endpoint..."
#read varkey

source ./admin-openrc.sh

openstack user create --domain default --password vasabilabNOVA_PASS nova
openstack role add --project service --user nova admin
openstack service create --name nova \
  --description "OpenStack Compute" compute
openstack endpoint create --region RegionOne \
  compute public http://controller:8774/v2.1/
openstack endpoint create --region RegionOne \
  compute internal http://controller:8774/v2.1/
openstack endpoint create --region RegionOne \
  compute admin http://controller:8774/v2.1/
