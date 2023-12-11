# Openstack icehouse installation script 
# run with sudo or as root.
#
#!/bin/bash -x
echo ovs-vsctl show 
ovs-vsctl show 
echo service openvswitch-switch restart
service openvswitch-switch restart
echo service nova-compute restart
service nova-compute restart
echo service openvswitch-switch restart
service openvswitch-switch restart
echo service neutron-openvswitch-agent restart
service neutron-openvswitch-agent restart
echo service neutron-metadata-agent restart
service neutron-metadata-agent restart
echo service neutron-dhcp-agent restart
service neutron-dhcp-agent restart
