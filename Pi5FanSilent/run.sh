#!/bin/sh

echo "[Pi5 Fan Silent] A aceder ao sistema de ficheiros do host..."

nsenter -t 1 -m -- sh << 'EOF'
CONFIG_FILE="/mnt/boot/config.txt"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "[ERRO] config.txt nao encontrado"
    ls /mnt/ 2>/dev/null
    exit 1
fi

echo "[Pi5 Fan Silent] Ficheiro encontrado!"
sed -i '/^dtparam=fan_temp/d' "$CONFIG_FILE"
printf '\ndtparam=fan_temp0=70000,fan_temp0_hyst=15000,fan_temp0_speed=75\n' >> "$CONFIG_FILE"
printf 'dtparam=fan_temp1=75000,fan_temp1_hyst=5000,fan_temp1_speed=150\n' >> "$CONFIG_FILE"
printf 'dtparam=fan_temp2=80000,fan_temp2_hyst=5000,fan_temp2_speed=250\n' >> "$CONFIG_FILE"
echo "[Pi5 Fan Silent] Configuracao aplicada:"
grep "fan_temp" "$CONFIG_FILE"
EOF

echo "[Pi5 Fan Silent] Feito! Faz DOIS reboots completos para as alteracoes terem efeito."
