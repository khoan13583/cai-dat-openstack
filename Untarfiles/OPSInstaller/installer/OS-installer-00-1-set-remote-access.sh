# OpenStack ocata installation script
#!/bin/bash -x
mkdir $HOME/log
#
sudo /bin/bash -x ./exe-preinstall00-SUDO-update.sh 2>&1 | tee $HOME/log/s00-installer.log 
/bin/bash -x ./exe-preinstall01-USER-set-remote-access.sh 2>&1 | tee $HOME/log/s02.log  
/bin/bash -x ./exe-preinstall02-USER-set-openstack-nodes.sh 2>&1 | tee $HOME/log/s03.log
printf "\nnext run ./OS-installer-00-2-update-ubuntu.sh\n"
