# OpenStack ocata installation script
#!/bin/bash -x
#
if [ $# -ne 11 ]
then
  echo "./OS-newcompute-00-set-new-node.sh <newHostname> <newMaageIPNic> <newHostManagementIP> <ManagePhysicalNic> <newDataIpNic> <newHostDataTunnelIP> <dataPhysicalNIC> <newVlanNic> <vlanPhysicalNic> <newExtNic> <controllerIP>"
  echo "  The script will remove any existing mapping of the <newHostManagementIP> in the /etc/hosts file" 
  echo "  and then insert a new mapping of <newHostManagementIP> and <newHostname> in there."
  echo "  This script assumes that the same hostname and IP addressed are already defined at the destination."
  exit 1
fi
#
newHostname=${1}
newHostManagementIPNic=${2}
newHostManagementIP=${3}
newHostManagementPhysicalNic=${4}
newHostDataTunnelIPNic=${5}
newHostDataTunnelIP=${6}
newHostDataTunnelPhysicalNic=${7}
newHostVlanIPNic=${8}
newHostVlanPhysicalNic=${9}
newHostExternalIPNic=${10}
ControllerIP=${11}
#
sudo sed -i "/${newHostManagementIP}/d" /etc/hosts
sudo sed -i "/${ControllerIP}/a ${newHostManagementIP}          ${newHostname}" /etc/hosts
#
echo "delete hostname and IP from knownhost if any"
ssh-keygen -R ${newHostname}
ssh-keygen -R ${newHostManagementIP}
#
echo "accept host keys"
./expectsshyesno.sh vasabi-1234loginname4321-ibasav ${newHostname}

echo "propagate credentials"
sshpass -pvasabi-1234loginpassword4321-ibasav scp /home/vasabi-1234loginname4321-ibasav/.ssh/id_rsa.pub vasabi-1234loginname4321-ibasav@${newHostname}:/home/vasabi-1234loginname4321-ibasav/authorized_keys
#
sshpass -pvasabi-1234loginpassword4321-ibasav ssh  vasabi-1234loginname4321-ibasav@${newHostname} "(mkdir /home/vasabi-1234loginname4321-ibasav/.ssh; mv /home/vasabi-1234loginname4321-ibasav/authorized_keys /home/vasabi-1234loginname4321-ibasav/.ssh/authorized_keys)"
#
echo "check date time of new compute node"
ssh  vasabi-1234loginname4321-ibasav@${newHostname} date
#
echo "set sudoers"
sshpass -pvasabi-1234loginpassword4321-ibasav scp files/adjustsudoer.sh vasabi-1234loginname4321-ibasav@${newHostname}:/home/vasabi-1234loginname4321-ibasav/adjustsudoer.sh
#
./expectsetsudoer.sh vasabi-1234loginname4321-ibasav ${newHostname} vasabi-1234loginpassword4321-ibasav
#
echo "set timezone on the new compute node"
ssh -t vasabi-1234loginname4321-ibasav@${newHostname} sudo timedatectl set-timezone vasabi-1234timezone4321-ibasav

echo "set date of the new compute node"
ssh -t vasabi-1234loginname4321-ibasav@${newHostname} sudo date --set=\"$(date)\"
#
#-----section 2
#
echo "copy installer tarball to the new compute node"
#read varkey
scp OPSInstaller.tar openstack@${newHostname}:/home/openstack/OPSInstaller.tar
#
echo "remove existing OPSInstaller on the new compute node"
ssh openstack@${newHostname} rm -rf /home/openstack/OPSInstaller 
#
echo "extract installer files on the new compute node."
ssh openstack@${newHostname} tar xvf /home/openstack/OPSInstaller.tar 
echo "replace parameters on the new compute node."
ssh openstack@${newHostname} /home/openstack/OPSInstaller/replace-newcompute-genericnames.sh ${newHostname} ${newHostManagementIPNic} ${newHostManagementIP} ${newHostManagementPhysicalNic} ${newHostDataTunnelIPNic} ${newHostDataTunnelIP} ${newHostDataTunnelPhysicalNic} ${newHostVlanIPNic} ${newHostVlanPhysicalNic} ${newHostExternalIPNic}
#
ssh openstack@${newHostname} /home/openstack/OPSInstaller/remove-all-except-newcompute.sh 
#
echo | ssh -t openstack@${newHostname}  sudo /bin/bash -x ./OPSInstaller/newcompute/exe-stage00-SUDO-update.sh | tee $HOME/log/s00-${newHostname}.log
#
ssh -t openstack@${newHostname}  sudo /bin/bash -x ./OPSInstaller/newcompute/exe-stage01-SUDO-set-compute-host-network.sh | tee $HOME/log/s00-${newHostname}.log
printf "\nWait until the rebooted node resume and proceed to run ./OS-newcompute-01-nova-neutron-ovs.sh \n"
