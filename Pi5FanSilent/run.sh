#!/bin/sh

echo "[Pi5 Fan Silent] A montar /dev/mmcblk0p1..."
mkdir -p /tmp/bootmnt

if mount -t vfat -o rw /dev/mmcblk0p1 /tmp/bootmnt 2>/dev/null; then
    echo "Montado. Conteudo:"
    ls -la /tmp/bootmnt/
    echo "---"
    ls -la /tmp/bootmnt/firmware/ 2>/dev/null || echo "(sem pasta firmware)"
    umount /tmp/bootmnt
else
    echo "[ERRO] Falhou ao montar /dev/mmcblk0p1"
    echo "A tentar p2..."
    if mount /dev/mmcblk0p2 /tmp/bootmnt 2>/dev/null; then
        echo "p2 montado. Conteudo:"
        ls -la /tmp/bootmnt/
        umount /tmp/bootmnt
    fi
fi
