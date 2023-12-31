# OpenStack installation script
#!/bin/bash -x
cd /home/vasabi-1234loginname4321-ibasav/OPSInstaller/compute; pwd

printf "\n2. install neutron.. \n"
#read varkey
apt-get -y install neutron-plugin-ml2 neutron-openvswitch-agent openvswitch-switch 
apt-get -y install neutron-dhcp-agent neutron-metadata-agent 

cp files/neutron.conf /etc/neutron/neutron.conf
cp files/ml2_conf.ini /etc/neutron/plugins/ml2/ml2_conf.ini
cp files/openvswitch_agent.ini /etc/neutron/plugins/ml2/openvswitch_agent.ini
cp files/dhcp_agent.ini /etc/neutron/dhcp_agent.ini
cp files/metadata_agent.ini /etc/neutron/metadata_agent.ini
#
service openvswitch-switch start
ovs-vsctl add-br br-provider
ovs-vsctl add-port br-provider vasabi-1234external_cidr_nic4321-ibasav
ovs-vsctl add-br br-vlan
ovs-vsctl add-port br-vlan vasabi-1234vlan_compute_node_ip_nic4321-ibasav

service openvswitch-switch restart

cp files/nova-stage29.conf /etc/nova/nova.conf

service nova-compute restart
service openvswitch-switch restart
service neutron-openvswitch-agent restart
service neutron-metadata-agent restart
service neutron-dhcp-agent restart
