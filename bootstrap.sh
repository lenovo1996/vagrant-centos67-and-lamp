# #!/usr/bin/env bash
set -e
set -x

if [ -f /etc/disk_added_date ] ; then
   echo "disk already added so exiting."
   exit 0
fi

sudo fdisk -u /dev/sdb <<EOF
n
p
1


t
8e
w
EOF

sudo pvcreate /dev/sdb1
sudo vgextend VolGroup /dev/sdb1
sudo lvextend -L100GB /dev/VolGroup/lv_root
sudo resize2fs /dev/VolGroup/lv_root
date > /etc/disk_added_date
