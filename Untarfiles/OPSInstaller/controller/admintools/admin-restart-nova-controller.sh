# Openstack icehouse installation script 
#
#!/bin/bash -x
echo service nova-api restart
service nova-api restart
echo service nova-consoleauth restart
service nova-consoleauth restart
echo service nova-scheduler restart
service nova-scheduler restart
echo service nova-conductor restart
service nova-conductor restart
echo service nova-novncproxy restart
service nova-novncproxy restart
