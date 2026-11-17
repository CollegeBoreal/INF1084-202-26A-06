# Yamna Cherif - 300160862
# services1.ps1 : afficher les services Active Directory

Get-Service | Where-Object {
    $_.DisplayName -like "*Directory*" -or
    $_.Name -match "NTDS|ADWS|DFSR|kdc|Netlogon|IsmServ"
} | Sort-Object DisplayName

# Verifier les trois services principaux
Get-Service -Name NTDS, ADWS, DFSR