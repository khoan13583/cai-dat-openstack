# Openstack icehouse installation script 
#
#!/bin/bash -x
#
echo service glance-registry restart
service glance-registry restart
echo service glance-api restart
service glance-api restart
#
