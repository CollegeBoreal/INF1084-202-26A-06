# ==========================================
# Script : services1.ps1
# Objectif : Lister les services AD et vérifier leur état
# ==========================================

Write-Host "--- Liste des services liés à Active Directory ---" -ForegroundColor Cyan

# Lister tous les services contenant 'Directory' ou correspondant aux noms de services AD
Get-Service | Where-Object {
    $_.DisplayName -like "*Directory*" -or $_.Name -match "NTDS|ADWS|DFSR|kdc|Netlogon|IsmServ"
} | Sort-Object DisplayName

Write-Host "`n--- État détaillé des services principaux ---" -ForegroundColor Yellow

# Vérifier l'état spécifique de NTDS, ADWS et DFSR
Get-Service -Name NTDS, ADWS, DFSR