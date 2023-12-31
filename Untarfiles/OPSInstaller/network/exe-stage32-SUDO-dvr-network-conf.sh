# OpenStack installation script
#!/bin/bash -x
cd /home/vasabi-1234loginname4321-ibasav/OPSInstaller/network; pwd
echo "Run with sudo or as root."
#
printf "1. configure openvswitch service.. \n"
#read varkey
cp files/openvswitch_agent_stage32.ini /etc/neutron/plugins/ml2/openvswitch_agent.ini
cp files/l3_agent_stage32.ini /etc/neutron/l3_agent.ini

printf "2. restart neutron agents.. \n"
#read varkey
service openvswitch-switch restart
service neutron-openvswitch-agent restart
service neutron-l3-agent restart
