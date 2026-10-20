# ==========================================
# Script : services3.ps1
# Objectif : Capturer et exporter les événements AD dans un fichier CSV
# ==========================================

# Vérifier si le dossier C:\Logs existe, sinon le créer
If (!(Test-Path "C:\Logs")) {
    New-Item -ItemType Directory -Path "C:\Logs" | Out-Null
    Write-Host "Le dossier C:\Logs a été créé." -ForegroundColor Yellow
}

Write-Host "Exportation des 50 derniers événements de Directory Service dans C:\Logs\ADLogs.csv..." -ForegroundColor Cyan

# Exporter les événements au format CSV
Get-WinEvent -LogName "Directory Service" -MaxEvents 50 | Export-Csv -Path "C:\Logs\ADLogs.csv" -NoTypeInformation

Write-Host "Exportation terminée avec succès !" -ForegroundColor Green