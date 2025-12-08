# ============================================================
# Script PowerShell para sincronizar Colorful-Plasma-Themes → HydraLife
# ============================================================

$DATESTAMP = Get-Date -Format "yyyy-MM-dd"
$TIMESTAMP = Get-Date -Format "HH-mm"

# --- Caminhos principais ---
#$SOURCE   = "$env:USERPROFILE\Documents\GitHub\main\Colorful-Plasma-Themes"
$DEST     = "$env:USERPROFILE\Documents\GitHub\master\HydraLife\LifeCicles\Assets\themes\Colorful-Plasma-Themes"



# ============================================================
# 1. Commit/push no submódulo HydraLife (Colorful-Plasma-Themes)
# ============================================================
Set-Location $DEST

$BRANCH = git branch --show-current
Write-Host "[HYDRA] Branch atual do submódulo: $BRANCH"

git fetch upstream
git checkout main
git merge upstream/main
git push origin main
Write-Host "[HYDRA] Submódulo atualizado a partir do upstream"
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
