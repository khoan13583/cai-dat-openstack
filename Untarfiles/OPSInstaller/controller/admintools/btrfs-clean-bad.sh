# Openstack icehouse installation script 
#
#!/bin/bash -x
#
btrfs subvolume delete /mnt/@_badroot_of_snap_${1}
btrfs subvolume delete /mnt/@_badhome_of_snap_${1}
#
