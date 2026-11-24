# Afficher les 20 derniers événements du journal AD
Get-EventLog -LogName "Directory Service" -Newest 20

# Chercher les événements Netlogon parmi les 20 derniers du système
Get-EventLog -LogName "System" -Newest 20 |
    Where-Object {$_.Source -eq "Netlogon"}

# Consulter le journal AD avec Get-WinEvent
Get-WinEvent -LogName "Directory Service" -MaxEvents 20 |
    Format-Table TimeCreated, Id, LevelDisplayName, Message -AutoSize