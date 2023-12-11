# Openstack icehouse installation script
#
#!/bin/bash -x
#
mv /mnt/@ /mnt/@_badroot
mv /mnt/@home /mnt/@_badhome
#
mv /mnt/@_snapshot1 /mnt/@
mv /mnt/@home_snapshot1 /mnt/@home
#
echo "Rebooting host"
reboot
