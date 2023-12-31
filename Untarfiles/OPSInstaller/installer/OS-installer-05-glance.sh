
# OpenStack ocata installation script
#!/bin/bash -x
#
# glance
ssh -t openstack@controller sudo /bin/bash -x ./OPSInstaller/controller/exe-stage12-SUDO-glance-database.sh | tee $HOME/log/s12-controller.log
ssh -t openstack@controller /bin/bash -x ./OPSInstaller/controller/exe-stage13-USER-glance-endpoints.sh | tee $HOME/log/s13-controller.log
ssh -t openstack@controller sudo /bin/bash -x ./OPSInstaller/controller/exe-stage14-SUDO-glance.sh | tee $HOME/log/s14-controller.log
ssh -t openstack@controller sudo /bin/bash -x ./OPSInstaller/controller/exe-stage14-x1-SUDO-glance.sh | tee $HOME/log/s14-x1-controller.log
sleep 5
ssh -t openstack@controller /bin/bash -x ./OPSInstaller/controller/exe-stage15-USER-verify-glance.sh | tee $HOME/log/s15-controller.log
printf "\nnext run ./OS-installer-06-nova.sh\n"
