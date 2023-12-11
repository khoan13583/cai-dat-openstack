# OpenStack ocata installation script
#!/bin/bash -x
#
nettype=vasabi-1234network_type4321-ibasav
dvr=dvr_ovs
#
# initial user network
if [ "$nettype" == "$dvr" ]
then
ssh -t openstack@controller /bin/bash -x ./OPSInstaller/controller/exe-stage36-USER-initial-network.sh | tee $HOME/log/s36-controller.log
fi
printf "\nNext ./OS-installer-10-horizon.sh\n"
