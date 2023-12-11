# OpenStack ocata installation script
#!/bin/bash -x
#
# rabbitmq
ssh -t openstack@controller sudo /bin/bash -x ./OPSInstaller/controller/exe-stage07-SUDO-rabbit.sh | tee $HOME/log/s07-controller.log
printf "\nnext run ./OS-installer-04-keystone.sh\n"
