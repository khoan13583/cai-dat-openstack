# OpenStack ocata installation script
#!/bin/bash -x
#
if [ $# -ne 1 ]
then
  echo "./OS-newcompute-01-nova-neutron-ovs.sh <newHostname>"
  echo "  This script assumes that the same hostname and IP addressed are already defined at the destination."
  exit 1
fi
#
newHostname=${1}
#
ssh -t openstack@${newHostname} sudo /bin/bash -x ./OPSInstaller/newcompute/exe-stage03-SUDO-compute-preinstall.sh | tee $HOME/log/s03-${newHostname}-compute.log
ssh -t openstack@${newHostname} sudo /bin/bash -x ./OPSInstaller/newcompute/exe-stage06-SUDO-compute-mysql.sh | tee $HOME/log/s06-${newHostname}-compute.log
ssh -t openstack@${newHostname} sudo /bin/bash -x ./OPSInstaller/newcompute/exe-stage19-SUDO-nova-compute.sh | tee $HOME/log/s19-${newHostname}-compute.log
sleep 5
ssh -t openstack@controller /bin/bash -x ./OPSInstaller/controller/exe-stage20-0-USER-verify-nova-compute.sh | tee $HOME/log/s20-${newHostname}-controller.log
ssh -t openstack@controller /bin/bash -x ./OPSInstaller/controller/exe-stage20-1-USER-verify-nova-compute1.sh | tee $HOME/log/s20-${newHostname}-controller.log
ssh -t openstack@controller /bin/bash -x ./OPSInstaller/controller/exe-stage20-2-USER-verify-nova.sh | tee $HOME/log/s20-${newHostname}-controller.log
ssh -t openstack@${newHostname} sudo /bin/bash -x ./OPSInstaller/newcompute/exe-stage29-SUDO-compute-neutron.sh | tee $HOME/log/s29-${newHostname}-compute.log
sleep 5
ssh -t openstack@controller /bin/bash -x ./OPSInstaller/controller/exe-stage30-USER-verify-neutron3.sh | tee $HOME/log/s30-${newHostname}-controller.log
printf "\nnext, if you want to set ${newHostname} to be a DVR node, run ./OS-newcompute-02-set-dvr.sh\n"
