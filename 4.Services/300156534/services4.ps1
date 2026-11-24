# Arret et redemarrage du service DFSR

Write-Host "Etat initial du service DFSR"
Get-Service -Name DFSR

Write-Host "Arret du service DFSR"
Stop-Service -Name DFSR

Start-Sleep -Seconds 3

Write-Host "Verification apres arret"
Get-Service -Name DFSR

Write-Host "Redemarrage du service DFSR"
Start-Service -Name DFSR

Start-Sleep -Seconds 3

Write-Host "Verification finale"
Get-Service -Name DFSR