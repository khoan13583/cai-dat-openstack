# OpenStack ocata installation script
#!/bin/bash -x
#
# horizon
ssh -t openstack@controller sudo /bin/bash -x ./OPSInstaller/controller/exe-stage37-SUDO-horizon.sh | tee $HOME/log/s37-controller.log
printf "\n./OS-installer-11-cinder.sh\n"
