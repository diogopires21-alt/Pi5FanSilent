#!/bin/sh

echo "[Pi5 Fan Silent] A procurar config.txt..."
echo "[Pi5 Fan Silent] Conteudo de /mnt/:"
ls /mnt/ 2>/dev/null || echo "(vazio ou inacessivel)"
echo "[Pi5 Fan Silent] Conteudo de /mnt/boot/:"
ls /mnt/boot/ 2>/dev/null || echo "(vazio ou inacessivel)"
echo "[Pi5 Fan Silent] Conteudo de /boot/:"
ls /boot/ 2>/dev/null || echo "(vazio ou inacessivel)"

for PATH_TRY in "/mnt/boot/config.txt" "/boot/config.txt" "/boot/firmware/config.txt" "/mnt/boot/firmware/config.txt"; do
    if [ -f "$PATH_TRY" ]; then
        echo "[Pi5 Fan Silent] Encontrado: $PATH_TRY"
        CONFIG_FILE="$PATH_TRY"
        break
    fi
done

if [ -z "$CONFIG_FILE" ]; then
    echo "[ERRO] config.txt nao encontrado em nenhum caminho."
    exit 1
fi

echo "[Pi5 Fan Silent] A configurar ventoinha em $CONFIG_FILE..."
sed -i '/^dtparam=fan_temp/d' "$CONFIG_FILE"
echo "" >> "$CONFIG_FILE"
echo "dtparam=fan_temp0=70000,fan_temp0_hyst=15000,fan_temp0_speed=75" >> "$CONFIG_FILE"
echo "dtparam=fan_temp1=75000,fan_temp1_hyst=5000,fan_temp1_speed=150" >> "$CONFIG_FILE"
echo "dtparam=fan_temp2=80000,fan_temp2_hyst=5000,fan_temp2_speed=250" >> "$CONFIG_FILE"

echo "[Pi5 Fan Silent] Feito! Faz DOIS reboots completos para as alteracoes terem efeito."
