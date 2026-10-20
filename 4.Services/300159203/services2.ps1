# ==========================================
# Script : services2.ps1
# Objectif : Afficher les événements d'un service AD
# ==========================================

Write-Host "--- 20 derniers événements de Directory Service ---" -ForegroundColor Cyan
Get-EventLog -LogName "Directory Service" -Newest 20

Write-Host "`n--- 20 derniers événements liés à Netlogon (Journal System) ---" -ForegroundColor Yellow
Get-EventLog -LogName "System" -Newest 20 | Where-Object { $_.Source -eq "Netlogon" }

Write-Host "`n--- Affichage via Get-WinEvent (Format moderne) ---" -ForegroundColor Green
Get-WinEvent -LogName "Directory Service" -MaxEvents 20 | Format-Table TimeCreated, Id, LevelDisplayName, Message -AutoSize