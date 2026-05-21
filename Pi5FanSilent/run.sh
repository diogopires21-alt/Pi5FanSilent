#!/bin/bash

CONFIG_FILE="/mnt/boot/config.txt"

echo "[Pi5 Fan Silent] A iniciar configuração da ventoinha..."

if [ ! -f "$CONFIG_FILE" ]; then
    echo "[ERRO] Ficheiro $CONFIG_FILE não encontrado."
    exit 1
fi

echo "[Pi5 Fan Silent] Ficheiro config.txt encontrado."

# Remover linhas fan_temp existentes para evitar duplicados
sed -i '/^dtparam=fan_temp/d' "$CONFIG_FILE"
sed -i '/^# Pi 5 Fan Silent/d' "$CONFIG_FILE"

# Adicionar configuração para silêncio máximo (ventoinha só a 70°C)
echo "" >> "$CONFIG_FILE"
echo "# Pi 5 Fan Silent - Silencio maximo (ventoinha so a 70C)" >> "$CONFIG_FILE"
echo "dtparam=fan_temp0=70000,fan_temp0_hyst=15000,fan_temp0_speed=75" >> "$CONFIG_FILE"
echo "dtparam=fan_temp1=75000,fan_temp1_hyst=5000,fan_temp1_speed=150" >> "$CONFIG_FILE"
echo "dtparam=fan_temp2=80000,fan_temp2_hyst=5000,fan_temp2_speed=250" >> "$CONFIG_FILE"

echo "[Pi5 Fan Silent] Configuração aplicada com sucesso!"
echo "[Pi5 Fan Silent] Linhas adicionadas ao config.txt:"
grep "fan_temp" "$CONFIG_FILE"
echo ""
echo "[Pi5 Fan Silent] IMPORTANTE: Faz DOIS reboots completos (tira o cabo) para as alterações terem efeito."
