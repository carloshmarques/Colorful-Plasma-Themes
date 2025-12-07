#!/bin/bash

echo "[HYDRA] 🌈 Iniciando atualização cerimonial de temas visuais..."

cd "$(dirname "$0")"

if [ ! -d ".git" ]; then
  echo "[HYDRA] ❌ Este script deve ser executado dentro da pasta 'Colorful-Plasma-Themes'."
  exit 1
fi

BRANCH=$(git branch --show-current)
echo "[HYDRA] 🔍 Branch atual: $BRANCH"
# Adicionar este script ao controle de versão local
git add update-themes.sh
git commit -m "Adicionar update-themes.sh local"

# Salvar alterações locais antes de atualizar
git add .
git commit -m "Salvar alterações locais antes de merge/rebase"

git stash push -m "Guardar alterações locais temporariamente"
git pull --rebase origin main
git stash pop
echo "[HYDRA] 🔄 Sincronizando temas visuais com upstream e origin..."
# Atualizar fork com upstream e origin
git fetch upstream
git rebase upstream/$BRANCH
git pull --rebase origin $BRANCH
git push origin $BRANCH
echo "[HYDRA] ✅ Temas sincronizados com sucesso: upstream → local → origin"

# Chamar PowerShell para copiar e commitar em HydraLife
powershell.exe -ExecutionPolicy Bypass -File ./updateplasma.ps1
