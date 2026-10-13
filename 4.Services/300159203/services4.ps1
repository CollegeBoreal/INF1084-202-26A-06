# ==========================================
# Script : services4.ps1
# Objectif : Arrêter, vérifier le statut et redémarrer le service DFSR
# ==========================================

Write-Host "1. Arrêt du service DFSR..." -ForegroundColor Red
Stop-Service -Name DFSR

Write-Host "`n2. Statut actuel du service DFSR :" -ForegroundColor Yellow
(Get-Service -Name DFSR).Status

Write-Host "`n3. Redémarrage du service DFSR..." -ForegroundColor Green
Start-Service -Name DFSR

Write-Host "`n4. Vérification finale du statut :" -ForegroundColor Cyan
(Get-Service -Name DFSR).Status