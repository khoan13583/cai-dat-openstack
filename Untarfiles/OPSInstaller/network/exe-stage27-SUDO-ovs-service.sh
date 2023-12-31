# OpenStack installation script
#!/bin/bash -x
cd /home/vasabi-1234loginname4321-ibasav/OPSInstaller/network; pwd
echo "Run with sudo or as root."
#
printf "1. configure openvswitch service.. press \n"
#read varkey
service openvswitch-switch start
ovs-vsctl add-br br-provider
ovs-vsctl add-port br-provider vasabi-1234external_cidr_nic4321-ibasav
ovs-vsctl add-br br-vlan
ovs-vsctl add-port br-vlan vasabi-1234vlan_network_node_ip_nic4321-ibasav
#
cp files/openvswitch_agent.ini /etc/neutron/plugins/ml2/openvswitch_agent.ini
cp files/l3_agent.ini /etc/neutron/l3_agent.ini

printf "2. restart neutron agents.. press\n"
#read varkey
service openvswitch-switch restart
service neutron-openvswitch-agent restart
service neutron-metadata-agent restart
service neutron-dhcp-agent restart
service neutron-l3-agent restart
