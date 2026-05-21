#!/bin/sh

echo "[Pi5 Fan Silent] A tentar aceder via /proc/1/root..."
echo "Conteudo de /proc/1/root/mnt/:"
ls /proc/1/root/mnt/ 2>/dev/null || echo "Nao acessivel"

CONFIG_FILE=""
for TRY in "/proc/1/root/mnt/boot/config.txt" "/proc/1/root/boot/firmware/config.txt" "/proc/1/root/boot/config.txt"; do
    if [ -f "$TRY" ]; then
        echo "Encontrado: $TRY"
        CONFIG_FILE="$TRY"
        break
    fi
done

if [ -z "$CONFIG_FILE" ]; then
    echo "[ERRO] Nao encontrado. Conteudo de /proc/1/root/:"
    ls /proc/1/root/ 2>/dev/null
    exit 1
fi

sed -i '/^dtparam=fan_temp/d' "$CONFIG_FILE"
printf '\ndtparam=fan_temp0=70000,fan_temp0_hyst=15000,fan_temp0_speed=75\n' >> "$CONFIG_FILE"
printf 'dtparam=fan_temp1=75000,fan_temp1_hyst=5000,fan_temp1_speed=150\n' >> "$CONFIG_FILE"
printf 'dtparam=fan_temp2=80000,fan_temp2_hyst=5000,fan_temp2_speed=250\n' >> "$CONFIG_FILE"

echo "[Pi5 Fan Silent] Configuracao aplicada!"
grep "fan_temp" "$CONFIG_FILE"
echo "Feito! Faz DOIS reboots completos."
