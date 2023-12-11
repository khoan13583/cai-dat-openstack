# Openstack icehouse installation script
#
#!/bin/bash -x
echo service nova-api restart
service nova-api restart
echo service neutron-server restart
service neutron-server restart
