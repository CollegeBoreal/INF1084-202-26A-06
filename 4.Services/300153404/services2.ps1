# Afficher les 20 derniers événements liés à NTDS
Get-EventLog -LogName "Directory Service" -Newest 20

# Afficher les événements Netlogon du journal System
Get-EventLog -LogName "System" -Newest 20 |
    Where-Object { $_.Source -eq "Netlogon" }

# Afficher les événements avec Get-WinEvent
Get-WinEvent -LogName "Directory Service" -MaxEvents 20 |
    Format-Table TimeCreated, Id, LevelDisplayName, Message -AutoSize