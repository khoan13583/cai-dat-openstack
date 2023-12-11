# Openstack icehouse installation script
#
#!/bin/bash -x
#
mv /mnt/@ /mnt/@_badroot_of_snap_${1}
mv /mnt/@home /mnt/@_badhome_of_snap_${1}
#
mv /mnt/@_snap_${1} /mnt/@
mv /mnt/@home_snap_${1} /mnt/@home
#
echo "Rebooting host"
reboot
