# ============================================================
# Script PowerShell para sincronizar Colorful-Plasma-Themes → HydraLife
# ============================================================

$DATESTAMP = Get-Date -Format "yyyy-MM-dd"
$TIMESTAMP = Get-Date -Format "HH-mm"

# --- Caminhos principais ---
$SOURCE   = "$env:USERPROFILE\Documents\GitHub\main\Colorful-Plasma-Themes"
$DEST     = "$env:USERPROFILE\Documents\GitHub\master\HydraLife\LifeCicles\Assets\themes\Colorful-Plasma-Themes"
$DESTLOG  = "$SOURCE\Logs"

# --- Garantir diretório de logs ---
if (!(Test-Path $DESTLOG)) {
    New-Item -ItemType Directory -Path $DESTLOG | Out-Null
}

# --- Copiar temas para HydraLife ---
Write-Host "[HYDRA] Copiando temas de $SOURCE → $DEST..."
robocopy $SOURCE $DEST /E /XD .git
Write-Host "[HYDRA] HydraLife atualizado com os novos temas em $DEST"

# --- Criar log de robocopy no fork (sem copiar outra vez) ---
$LOGFILE = "$DESTLOG\robocopy_log_$DATESTAMP_$TIMESTAMP.txt"
robocopy $SOURCE $DEST /L /E /XD .git /LOG:$LOGFILE
Write-Host "[HYDRA] Log de robocopy criado em $LOGFILE"
# ============================================================
# 1. Commit/push no submódulo HydraLife (Colorful-Plasma-Themes)
# ============================================================
Set-Location $DEST

$BRANCH = git branch --show-current
Write-Host "[HYDRA] Branch atual do submódulo: $BRANCH"

# Primeiro atualizar a partir do fork (origin)
git pull --rebase origin $BRANCH

# Depois adicionar e commitar as tuas alterações
git add .
git commit -m "Atualização de temas Colorful-Plasma em $DATESTAMP $TIMESTAMP"

# Finalmente enviar para o fork
git push origin $BRANCH

Write-Host "[HYDRA] Submódulo atualizado a partir do fork"

# ============================================================
# 2. Commit/push no repositório HydraLife (master)
# ============================================================
Set-Location "$env:USERPROFILE\Documents\GitHub\master\HydraLife"
git add LifeCicles/Assets/Themes/Colorful-Plasma-Themes
git commit -m "Referência do submódulo atualizada em $DATESTAMP $TIMESTAMP"
git push origin master

Write-Host "[HYDRA] Commit realizado no repositório HydraLife"
