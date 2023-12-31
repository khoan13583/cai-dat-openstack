# OpenStack ocata installation script
#!/bin/bash -x
#
intype=vasabi-1234install_type4321-ibasav
full=full
#
mkdir $HOME/log
#
# node setups
ssh -t openstack@controller sudo /bin/bash -x ./OPSInstaller/controller/exe-stage01-SUDO-preinstall.sh | tee $HOME/log/s01-controller.log
ssh -t openstack@network sudo /bin/bash -x ./OPSInstaller/network/exe-stage02-SUDO-network-preinstall.sh | tee $HOME/log/s02-network.log
ssh -t openstack@compute sudo /bin/bash -x ./OPSInstaller/compute/exe-stage03-SUDO-compute-preinstall.sh | tee $HOME/log/s03-compute.log
if [ "$intype" == "$full" ]
then
ssh -t openstack@compute1 sudo /bin/bash -x ./OPSInstaller/compute1/exe-stage03-SUDO-compute-preinstall.sh | tee $HOME/log/s03-compute.log
fi
printf "\nnext run ./OS-installer-02-mysql.sh \n"
