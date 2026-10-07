# Lister tous les services liés à AD
Get-Service | Where-Object {
    $_.DisplayName -like "*Directory*" -or
    $_.Name -match "NTDS|ADWS|DFSR|Kdc|Netlogon|IsmServ"
} | Sort-Object DisplayName

# Vérifier l'état de services spécifiques
Get-Service -Name NTDS, ADWS, DFSR