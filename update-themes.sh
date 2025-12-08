#!/bin/bash

echo "[HYDRA] 🌈 Iniciando atualização cerimonial de temas visuais..."

cd "$(dirname "$0")"

if [ ! -d ".git" ]; then
  echo "[HYDRA] ❌ Este script deve ser executado dentro da pasta 'Colorful-Plasma-Themes'."
  exit 1
fi

#Verificar nome da branch atual
BRANCH=$(git branch --show-current)

echo "[HYDRA] 🔍 Branch atual: $BRANCH"

# Sincronizar com upstream
git fetch upstream
git merge upstream/$BRANCH

# Push para o fork
git push origin $BRANCH

echo "[HYDRA] ✅ Temas sincronizados com sucesso: upstream → local → origin"

# 5. Chamar PowerShell para copiar e commitar em HydraLife
# powershell.exe -ExecutionPolicy Bypass -File ./updateplasma.ps1
