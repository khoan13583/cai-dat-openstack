# OpenStack installation script
#!/bin/bash -x
cd /home/vasabi-1234loginname4321-ibasav/OPSInstaller/compute; pwd

printf "\n2. install extra agents.. \n"
#read varkey
apt-get -y install neutron-l3-agent 

cp files/openvswitch_agent_stage33.ini /etc/neutron/plugins/ml2/openvswitch_agent.ini
cp files/l3_agent_stage33.ini /etc/neutron/l3_agent.ini

service openvswitch-switch restart
service neutron-openvswitch-agent restart
service neutron-l3-agent restart
