#!/bin/sh

echo "[Pi5 Fan Silent] A ler config.txt via mtools..."
DEVICE="/dev/mmcblk0p1"

mtype -i "$DEVICE" ::/config.txt > /tmp/config.txt 2>/dev/null
if [ ! -s /tmp/config.txt ]; then
    echo "[ERRO] Nao foi possivel ler config.txt do dispositivo $DEVICE"
    exit 1
fi

echo "Ficheiro lido com sucesso. Ultimas linhas:"
tail -5 /tmp/config.txt

sed -i '/^dtparam=fan_temp/d' /tmp/config.txt
printf '\ndtparam=fan_temp0=70000,fan_temp0_hyst=15000,fan_temp0_speed=75\n' >> /tmp/config.txt
printf 'dtparam=fan_temp1=75000,fan_temp1_hyst=5000,fan_temp1_speed=150\n' >> /tmp/config.txt
printf 'dtparam=fan_temp2=80000,fan_temp2_hyst=5000,fan_temp2_speed=250\n' >> /tmp/config.txt

echo "A escrever de volta..."
mcopy -i "$DEVICE" -o /tmp/config.txt ::/config.txt 2>&1

echo "[Pi5 Fan Silent] Feito! Configuracao aplicada:"
grep "fan_temp" /tmp/config.txt
echo "Faz DOIS reboots completos para as alteracoes terem efeito."
