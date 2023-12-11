# Openstack icehouse installation script
#
#!/bin/bash -x
#
btrfs subvolume delete /mnt/@_snap_*
btrfs subvolume delete /mnt/@home_snap_*
#
