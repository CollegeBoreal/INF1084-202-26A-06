# Yamna Cherif - 300160862
# services2.ps1 : consulter les evenements AD

# Afficher les 20 derniers evenements Directory Service
Get-EventLog -LogName "Directory Service" -Newest 20

# Rechercher Netlogon parmi les 20 derniers evenements Systeme
Get-EventLog -LogName "System" -Newest 20 |
    Where-Object { $_.Source -eq "Netlogon" }

# Afficher les evenements avec la commande moderne
Get-WinEvent -LogName "Directory Service" -MaxEvents 20 |
        Format-Table TimeCreated, Id, LevelDisplayName, Message -AutoSize