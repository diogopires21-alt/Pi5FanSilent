#!/bin/sh

echo "=== Partições disponíveis ==="
cat /proc/partitions 2>/dev/null

echo "=== Mounts do host ==="
cat /proc/mounts 2>/dev/null | grep mmcblk

echo "=== Tipo de filesystem ==="
blkid /dev/mmcblk0p1 2>/dev/null || fdisk -l /dev/mmcblk0 2>/dev/null | head -20

echo "=== A tentar montar sem especificar tipo ==="
mkdir -p /tmp/bootmnt
mount /dev/mmcblk0p1 /tmp/bootmnt 2>&1
echo "Exit code: $?"
ls /tmp/bootmnt/ 2>/dev/null
umount /tmp/bootmnt 2>/dev/null
