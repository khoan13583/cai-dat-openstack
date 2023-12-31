#!/bin/bash 
#
# OpenStack Installation script (parameter definition)
#
export INSTALL_TYPE=full
export NETWORK_TYPE=dvr_ovs
export PASSWD_TYPE=studypass
#
# There are two kinds of installation: full or compact.
# Full has 2 compute node, while compact has only 1 compute. 
# There are also two types of network: classic_ovs or dvr_ovs.
# classic_ovs has no HA capability. dvr_ovs represents the 
# distributed virtual router HA capability. 
# The password is either "randompass" or "studypass" (default). 
# The "randompass" produces randomly generated passwords for 
# openstack components while "studypass" generates readable 
# password for learning and debugging.
#
export OPS_LOGIN_NAME=openstack
export OPS_LOGIN_PASS=openstack
export OPS_TIMEZONE=Asia\\/Bangkok
#
export OPS_MYSQL_PASS=mysqlpassword
export DEMO_PASS=demopassword
export ADMIN_PASS=adminpassword
#
#export HYPERVISOR=qemu
export HYPERVISOR=kvm
#
export INIT_IMAGE_LOCATION=http:\\/\\/download.cirros-cloud.net\\/0.4.0\\/cirros-0.4.0-x86_64-disk.img
export INIT_IMAGE_NAME=cirros
#
# The domainname of every node
export DOMAINNAME=cs.tu.ac.th
#
# Ubuntu Repository Parameters
#
export LOCAL_REPO=th.archive.ubuntu.com
export LOCAL_SECURITY_REPO=security.ubuntu.com
#
# ntp servers
export NTP_SERVER0=0.th.pool.ntp.org
export NTP_SERVER1=1.th.pool.ntp.org
export NTP_SERVER2=2.th.pool.ntp.org
export NTP_SERVER3=3.th.pool.ntp.org
#
# Management Network
#
export MANAGEMENT_NETWORK=10.0.6.0
export MANAGEMENT_NETWORK_NETMASK=255.255.255.0
export MANAGEMENT_BROADCAST_ADDRESS=10.0.6.255 
export DNS_IP=8.8.8.8
#
# This GATEWAY_IP define the IP addr of the gateway of 
# the management network on every node.
#
export GATEWAY_IP=10.0.6.1
#
#
# ---- controller host ----
#
export CONTROLLER_IP=10.0.6.11
export CONTROLLER_IP_NIC=eno3
#
# ---- network host ----
#
export NETWORK_IP=10.0.6.11
export NETWORK_IP_NIC=eno3
#
export DATA_TUNNEL_NETWORK_NODE_IP=10.0.1.11
export DATA_TUNNEL_NETWORK_NODE_IP_NIC=ens1f0
export DATA_TUNNEL_NETWORK_ADDRESS=10.0.1.0
export DATA_TUNNEL_NETWORK_NETMASK=255.255.255.0
export VLAN_NETWORK_NODE_IP_NIC=eno1
#
export EXTERNAL_CIDR=10.0.6.0\\/24
export EXTERNAL_CIDR_NIC=eno4
export EXTERNAL_GATEWAY_IP=10.0.6.1
#
# For DVR, the EXTERNAL_CIDR* of network node is the same for every compute node.
#
export START_FLOATING_IP=10.0.6.100
export END_FLOATING_IP=10.0.6.180
#
# ---- compute host ----
#
export COMPUTE_IP=10.0.6.31
export COMPUTE_IP_NIC=eno3
export DATA_TUNNEL_COMPUTE_NODE_IP=10.0.1.31
export DATA_TUNNEL_COMPUTE_NODE_IP_NIC=ens1f0
export VLAN_COMPUTE_NODE_IP_NIC=eno1
#
# ---- compute1 host ----
#
export COMPUTE1_IP=10.0.6.32
export COMPUTE1_IP_NIC=ens3
export DATA_TUNNEL_COMPUTE1_NODE_IP=10.0.1.32
export DATA_TUNNEL_COMPUTE1_NODE_IP_NIC=ens1f0
export VLAN_COMPUTE1_NODE_IP_NIC=eno1
