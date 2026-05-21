#!/bin/sh

echo "[Pi5 Fan Silent] A procurar particao de boot..."
echo "Dispositivos disponiveis:"
ls /dev/mmcblk* /dev/sd* /dev/nvme* 2>/dev/null

mkdir -p /tmp/bootmnt

for DEV in /dev/mmcblk0p1 /dev/mmcblk1p1 /dev/sda1 /dev/nvme0n1p1; do
    if [ -b "$DEV" ]; then
        echo "A tentar montar $DEV..."
        if mount -t vfat -o rw "$DEV" /tmp/bootmnt 2>/dev/null; then
            if [ -f /tmp/bootmnt/config.txt ]; then
                echo "[Pi5 Fan Silent] config.txt encontrado!"
                sed -i '/^dtparam=fan_temp/d' /tmp/bootmnt/config.txt
                printf '\ndtparam=fan_temp0=70000,fan_temp0_hyst=15000,fan_temp0_speed=75\n' >> /tmp/bootmnt/config.txt
                printf 'dtparam=fan_temp1=75000,fan_temp1_hyst=5000,fan_temp1_speed=150\n' >> /tmp/bootmnt/config.txt
                printf 'dtparam=fan_temp2=80000,fan_temp2_hyst=5000,fan_temp2_speed=250\n' >> /tmp/bootmnt/config.txt
                echo "Configuracao aplicada:"
                grep "fan_temp" /tmp/bootmnt/config.txt
                umount /tmp/bootmnt
                echo "[Pi5 Fan Silent] Feito! Faz DOIS reboots completos."
                exit 0
            fi
            umount /tmp/bootmnt 2>/dev/null
        fi
    fi
done

echo "[ERRO] Nao foi possivel encontrar a particao de boot."
