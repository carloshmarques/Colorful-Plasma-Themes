# Script PowerShell para sincronizar Colorful-Plasma-Themes → HydraLife e commitar ambos

$DATESTAMP = Get-Date -Format "yyyy-MM-dd"
$TIMESTAMP = Get-Date -Format "HH-mm"

$SOURCE = "$env:USERPROFILE\Documents\GitHub\main\Colorful-Plasma-Themes"
$DEST   = "$env:USERPROFILE\Documents\GitHub\master\HydraLife\LifeCicles\Assets\Themes\Colorful-Plasma-Themes"

Write-Host "[HYDRA] Copiando temas de $SOURCE para $DEST..."
robocopy $SOURCE $DEST /E /XD .git /LOG:$SOURCE\robocopy_log.txt
Write-Host "[HYDRA] HydraLife atualizado com os novos temas em $DEST"

# 1. Commit/push no repositório Colorful-Plasma-Themes (main)
Set-Location $SOURCE
git add .
git commit -m "Atualização cerimonial dos temas em $DATESTAMP $TIMESTAMP"
git push origin main
Write-Host "[HYDRA] Commit realizado no repositório Colorful-Plasma-Themes"

# 2. Commit/push no submódulo HydraLife
Set-Location $DEST
git add .
git commit -m "Atualização de temas Colorful-Plasma em $DATESTAMP $TIMESTAMP"
git push origin main
Write-Host "[HYDRA] Commit realizado no submódulo Colorful-Plasma-Themes"

# 3. Commit/push no repositório HydraLife
Set-Location "$env:USERPROFILE\Documents\GitHub\master\HydraLife"
git add LifeCicles/Assets/Themes/Colorful-Plasma-Themes
git commit -m "Referência do submódulo atualizada em $DATESTAMP $TIMESTAMP"
git push origin master
Write-Host "[HYDRA] Commit realizado no repositório HydraLife"
