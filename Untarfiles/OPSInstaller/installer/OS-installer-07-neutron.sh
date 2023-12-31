# OpenStack ocata installation script
#!/bin/bash -x
#
#
intype=vasabi-1234install_type4321-ibasav
full=full
#
nettype=vasabi-1234network_type4321-ibasav
ovs=classic_ovs
#
# neutron
ssh -t openstack@controller sudo /bin/bash -x ./OPSInstaller/controller/exe-stage21-SUDO-neutron-database.sh | tee $HOME/log/s21-controller.log
ssh -t openstack@controller /bin/bash -x ./OPSInstaller/controller/exe-stage22-USER-neutron-endpoints.sh | tee $HOME/log/s22-controller.log
ssh -t openstack@controller sudo /bin/bash -x ./OPSInstaller/controller/exe-stage23-SUDO-neutron.sh | tee $HOME/log/s23-controller.log
sleep 5
ssh -t openstack@controller /bin/bash -x ./OPSInstaller/controller/exe-stage24-USER-verify-neutron.sh | tee $HOME/log/s24-controller.log
sleep 5
ssh -t openstack@network sudo /bin/bash -x ./OPSInstaller/network/exe-stage25-SUDO-network-neutron.sh | tee $HOME/log/s25-network.log
sleep 5
ssh -t openstack@controller sudo /bin/bash -x ./OPSInstaller/controller/exe-stage26-SUDO-reconfig-neutron-nova.sh | tee $HOME/log/s26-controller.log
sleep 5
ssh -t openstack@network sudo /bin/bash -x ./OPSInstaller/network/exe-stage27-SUDO-ovs-service.sh | tee $HOME/log/s27-network.log
sleep 5
ssh -t openstack@controller /bin/bash -x ./OPSInstaller/controller/exe-stage28-USER-verify-neutron2.sh | tee $HOME/log/s28-controller.log
sleep 5
ssh -t openstack@compute sudo /bin/bash -x ./OPSInstaller/compute/exe-stage29-SUDO-compute-neutron.sh | tee $HOME/log/s29-compute.log
sleep 5
if [ "$intype" == "$full" ]
then
ssh -t openstack@compute1 sudo /bin/bash -x ./OPSInstaller/compute1/exe-stage29-SUDO-compute-neutron.sh | tee $HOME/log/s29-compute.log
fi
sleep 5
ssh -t openstack@controller /bin/bash -x ./OPSInstaller/controller/exe-stage30-USER-verify-neutron3.sh | tee $HOME/log/s30-controller.log
if [ "$nettype" == "$ovs" ]
then
  ssh -t openstack@controller /bin/bash -x ./OPSInstaller/controller/exe-stage36-USER-initial-network.sh | tee $HOME/log/s37-controller.log
  printf "\nnext run ./OS-installer-09-horizon.sh\n"
else
  printf "\nnext run ./OS-installer-08-set-dvr.sh\n"
fi
