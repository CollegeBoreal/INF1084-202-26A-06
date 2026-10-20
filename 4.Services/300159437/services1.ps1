# ==========================================
# Script : Verification-AD.ps1
# Objectif : Vérifier les services essentiels
#            d'Active Directory
# ==========================================

Write-Host "=== Vérification des services Active Directory ==="

$servicesAD = @(
    "NTDS",
    "ADWS",
    "DFSR",
    "KDC",
    "Netlogon"
)

foreach ($service in $servicesAD) {

    $etat = Get-Service -Name $service -ErrorAction SilentlyContinue

    if ($etat) {
        Write-Host "$($etat.DisplayName) : $($etat.Status)"
    }
    else {
        Write-Host "Service $service introuvable"
    }
}

Write-Host "=== Vérification terminée ==="