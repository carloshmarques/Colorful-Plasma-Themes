#!/bin/bash

echo "[HYDRA] 🌈 Iniciando atualização cerimonial de temas visuais..."

cd "$(dirname "$0")"

if [ ! -d ".git" ]; then
  echo "[HYDRA] ❌ Este script deve ser executado dentro da pasta 'Colorful-Plasma-Themes'."
  exit 1
fi

BRANCH=$(git branch --show-current)
echo "[HYDRA] 🔍 Branch atual: $BRANCH"

# Salvar alterações locais (se houver)
git add .
git commit -m "Atualização local antes de sincronizar" || echo "[HYDRA] ⚠️ Nenhuma alteração local para commitar"

# Atualizar fork com upstream e origin
git fetch upstream
git rebase upstream/$BRANCH
git pull --rebase origin $BRANCH
git push origin $BRANCH

echo "[HYDRA] ✅ Temas sincronizados com sucesso: upstream → local → origin"

# Chamar PowerShell para copiar e commitar em HydraLife
powershell.exe -ExecutionPolicy Bypass -File ./updateplasma.ps1
