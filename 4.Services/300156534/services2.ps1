# Afficher les 20 derniers evenements lies a NTDS
Get-EventLog -LogName "Directory Service" -Newest 20

# Afficher les logs du systeme
Get-EventLog -LogName "System" -Newest 20 | Where-Object {$_.Source -eq "Netlogon"}

# Afficher les logs via le journal moderne
Get-WinEvent -LogName "Directory Service" -MaxEvents 20 |
Format-Table TimeCreated, Id, LevelDisplayName, Message -AutoSize