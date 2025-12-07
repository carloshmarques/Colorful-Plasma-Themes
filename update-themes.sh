#!/bin/bash

echo "[HYDRA] 🌈 Iniciando atualização cerimonial de temas visuais..."

cd "$(dirname "$0")"

if [ ! -d ".git" ]; then
  echo "[HYDRA] ❌ Este script deve ser executado dentro da pasta 'Colorful-Plasma-Themes'."
  exit 1
fi

BRANCH=$(git branch --show-current)
echo "[HYDRA] 🔍 Branch atual: $BRANCH"

# 1. Salvar alterações locais sempre sobrescrevendo o último commit
git add .
git commit --amend -C HEAD || echo "[HYDRA] ⚠️ Nenhuma alteração local para commitar"

# 2. Atualizar com upstream
git fetch upstream
git rebase upstream/$BRANCH || echo "[HYDRA] ⚠️ Nenhuma atualização de upstream"

# 3. Atualizar com origin
git pull --rebase origin $BRANCH

# 4. Push para origin
git push origin $BRANCH

echo "[HYDRA] ✅ Temas sincronizados com sucesso: upstream → local → origin"

# 5. Chamar PowerShell para copiar e commitar em HydraLife
powershell.exe -ExecutionPolicy Bypass -File ./updateplasma.ps1
