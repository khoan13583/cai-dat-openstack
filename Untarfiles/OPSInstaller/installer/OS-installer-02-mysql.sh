
# OpenStack ocata installation script
#!/bin/bash -x
#
#
intype=vasabi-1234install_type4321-ibasav
full=full
#
# mysql
printf "\nIn this part of the installation, you need to remeber the MYSQL PASSWORD of MYSQL root user\n"
printf "set earlier in the .install_paramrc.sh file. The script will ask for the password when install mysql. \n"
ssh -t openstack@controller sudo /bin/bash -x ./OPSInstaller/controller/exe-stage04-SUDO-mysql.sh | tee $HOME/log/s04-controller.log
ssh -t openstack@network sudo /bin/bash -x ./OPSInstaller/network/exe-stage05-SUDO-network-mysql.sh | tee $HOME/log/s05-network.log
ssh -t openstack@compute sudo /bin/bash -x ./OPSInstaller/compute/exe-stage06-SUDO-compute-mysql.sh | tee $HOME/log/s06-compute.log
if [ "$intype" == "$full" ]
then
ssh -t openstack@compute1 sudo /bin/bash -x ./OPSInstaller/compute1/exe-stage06-SUDO-compute-mysql.sh | tee $HOME/log/s06-compute.log
fi
printf "\nnext run ./OS-installer-03-rabbitmq.sh\n"
