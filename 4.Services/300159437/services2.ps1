# ==========================================
# Script : services2.ps1
# Objectif : Vérifier les événements
#            Active Directory et Netlogon
# ==========================================

Write-Host "=== 20 derniers événements Active Directory ==="

Get-WinEvent -LogName "Directory Service" -MaxEvents 20 |
Format-Table TimeCreated, Id, LevelDisplayName, Message -AutoSize


Write-Host "`n=== 20 derniers événements Netlogon ==="

Get-EventLog -LogName "System" -Newest 100 |
Where-Object {
    $_.Source -eq "NETLOGON"
} |
Select-Object -First 20 |
Format-Table TimeGenerated, EventID, EntryType, Source, Message -AutoSize


Write-Host "`n=== Vérification terminée (Merci !!) ==="