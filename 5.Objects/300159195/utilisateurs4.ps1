# Recuperer le SID du groupe Students
$StudentsSID = (Get-ADGroup Students).SID.Value

# Exporter la politique locale
secedit /export /cfg C:\secpol.cfg

# Lire le fichier
$Content = Get-Content C:\secpol.cfg

# Trouver la ligne du droit RDP
$Line = $Content | Where-Object {
    $_ -like "SeRemoteInteractiveLogonRight*"
}

# Ajouter Students sans supprimer les groupes deja presents
if ($Line) {
    $NewLine = $Line + ",*$StudentsSID"
    $Content = $Content -replace [regex]::Escape($Line), $NewLine
}
else {
    $Content += "SeRemoteInteractiveLogonRight = *$StudentsSID"
}

# Enregistrer la nouvelle configuration
Set-Content -Path C:\secpol.cfg -Value $Content

# Reimporter la politique
secedit /import /cfg C:\secpol.cfg /db C:\secpol.sdb /overwrite
