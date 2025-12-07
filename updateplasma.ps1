# Script PowerShell para sincronizar Colorful-Plasma-Themes → HydraLife e commitar ambos

$DATESTAMP = Get-Date -Format "yyyy-MM-dd"
$TIMESTAMP = Get-Date -Format "HH-mm"

$SOURCE = "$env:USERPROFILE\Documents\GitHub\main\Colorful-Plasma-Themes"
$DEST   = "$env:USERPROFILE\Documents\GitHub\master\HydraLife\LifeCicles\Assets\Themes\Colorful-Plasma-Themes"
$HYDRA  = "$env:USERPROFILE\Documents\GitHub\master\HydraLife"

Write-Host "[HYDRA] Copiando temas de $SOURCE para $DEST..."
robocopy $SOURCE $DEST /E /XD .git /XF sync-to-hydralife.sh update-themes.sh updateplasma.ps1 /LOG:$SOURCE\robocopy_log.txt
Write-Host "[HYDRA] HydraLife atualizado com os novos temas em $DEST"

# 1. Commit/push no repositório Colorful-Plasma-Themes (fork main)
Set-Location $SOURCE
git add .
git commit -m "Atualização cerimonial dos temas em $DATESTAMP $TIMESTAMP"
git push origin main
Write-Host "[HYDRA] Commit realizado no repositório Colorful-Plasma-Themes (fork)"

# 2. Atualizar referência do submódulo em HydraLife
Write-Host "[HYDRA] Atualizando referência do submódulo em HydraLife..."
Set-Location $HYDRA
git add LifeCicles/Assets/Themes/Colorful-Plasma-Themes
git commit -m "[HYDRA] Referência do submódulo atualizada em $DATESTAMP $TIMESTAMP"
git push origin master
Write-Host "[HYDRA] Referência do submódulo atualizada no repositório HydraLife"



