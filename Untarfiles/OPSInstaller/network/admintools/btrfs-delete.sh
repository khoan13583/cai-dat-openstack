# Openstack icehouse installation script
#
#!/bin/bash -x
#
btrfs subvolume delete /mnt/@_snap_${1}
btrfs subvolume delete /mnt/@home_snap_${1}
#
