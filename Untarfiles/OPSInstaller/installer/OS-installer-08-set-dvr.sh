# OpenStack ocata installation script
#!/bin/bash -x
#
#
intype=vasabi-1234install_type4321-ibasav
full=full
#
# neutron
ssh -t openstack@controller sudo /bin/bash -x ./OPSInstaller/controller/exe-stage31-SUDO-dvr-controller-conf.sh | tee $HOME/log/s31-controller.log
sleep 5
ssh -t openstack@network sudo /bin/bash -x ./OPSInstaller/network/exe-stage32-SUDO-dvr-network-conf.sh | tee $HOME/log/ss32-network.log
sleep 5
ssh -t openstack@compute sudo /bin/bash -x ./OPSInstaller/compute/exe-stage33-SUDO-dvr-compute-conf.sh | tee $HOME/log/s33-compute.log
sleep 5
if [ "$intype" == "$full" ]
then
ssh -t openstack@compute1 sudo /bin/bash -x ./OPSInstaller/compute1/exe-stage34-SUDO-dvr-compute1-conf.sh | tee $HOME/log/s34-compute.log
fi
sleep 5
ssh -t openstack@controller /bin/bash -x ./OPSInstaller/controller/exe-stage35-USER-verify-dvr-network.sh | tee $HOME/log/s35-controller.log
printf "\nnext run ./OS-installer-09-initial-user-network.sh\n"
