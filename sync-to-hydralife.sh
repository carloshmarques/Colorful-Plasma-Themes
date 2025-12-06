#!/bin/bash

echo "[HYDRA] 🔄 Copiando temas para HydraLife..."

cd "$(dirname "$0")"

# Caminho relativo correto: de main/Colorful-Plasma-Themes → master/HydraLife
HYDRALIFE_PATH="../../master/HydraLife/LifeCicles/Assets/Themes/Colorful-Plasma-Themes"

# Se preferires absoluto (menos confusão):
# HYDRALIFE_PATH="$USERPROFILE/Documents/GitHub/master/HydraLife/LifeCicles/Assets/Themes/Colorful-Plasma-Themes"

mkdir -p "$HYDRALIFE_PATH"

robocopy . "$HYDRALIFE_PATH" /E /XD .git


echo "[HYDRA] 🎨 HydraLife atualizado com os novos temas em:"
echo "       $HYDRALIFE_PATH"
