# OpenStack installation script
#!/bin/bash -x
cd /home/vasabi-1234loginname4321-ibasav/OPSInstaller/controller; pwd
#
echo -n "* install rabbitmq.. press" 
#read varkey
apt-get -y install rabbitmq-server

echo -n "* set rabbitmq password for guest...press"
#read varkey
rabbitmqctl add_user openstack vasabilabRABBIT_PASS
rabbitmqctl set_permissions openstack ".*" ".*" ".*"

printf "* install memcache..press\n"
#read varkey
apt-get -y install memcached python3-memcache
cp files/memcached.conf /etc/memcached.conf
service memcached restart

apt -y install etcd

cp files/etcd /etc/default/etcd

systemctl enable etcd
systemctl start etcd
