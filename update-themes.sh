#!/bin/bash

echo "[HYDRA] Iniciando atualização cerimonial de temas visuais..."
cd "$(dirname "$0")"

# Garantir que estamos no repo correto
if [ ! -d ".git" ]; then
  echo "[HYDRA] Este script deve ser executado dentro da pasta 'Colorful-Plasma-Themes'."
  exit 1
fi

# Remotes e branch
BRANCH=$(git branch --show-current)
echo "[HYDRA] Branch atual: $BRANCH"

# Mantém o fork alinhado com o upstream
git fetch upstream origin
git checkout main
git merge upstream/main
git push origin main

echo "[HYDRA] Temas sincronizados com sucesso: upstream → local → origin"

# Avançar referência do submódulo em HydraLife via PowerShell
powershell.exe -ExecutionPolicy Bypass -File "$PWD/updateplasma.ps1"

