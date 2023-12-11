# Openstack icehouse installation script 
#
#!/bin/bash -x
#
btrfs subvolume snapshot /mnt/@ /mnt/@_snap_${1}
btrfs subvolume snapshot /mnt/@home /mnt/@home_snap_${1}
#
