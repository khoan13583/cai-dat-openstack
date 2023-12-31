# OpenStack ocata installation script
#!/bin/bash -x
#
if [ $# -ne 1 ]
then
  echo "./OS-newcompute-02-set-dvr.sh <newHostname>"
  echo "  This script assumes that the same hostname and IP addressed are already defined at the destination."
  exit 1
fi
#
newHostname=${1}
#
ssh -t openstack@${newHostname} sudo /bin/bash -x ./OPSInstaller/newcompute/exe-stage34-SUDO-dvr-compute1-conf.sh | tee $HOME/log/s34-${newHostname}-compute.log
sleep 5
ssh -t openstack@controller /bin/bash -x ./OPSInstaller/controller/exe-stage35-USER-verify-dvr-network.sh | tee $HOME/log/s35-${newHostname}-controller.log
printf "\nDone!\n"
