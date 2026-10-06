# ==========================================
# Script : services3.ps1
# Objectif : Exporter les événements
#            Active Directory dans un CSV
# ==========================================

Write-Host "=== Exportation des logs Active Directory ==="

# Vérifier si le dossier C:\Logs existe
if (!(Test-Path "C:\Logs")) {
    New-Item -Path "C:\Logs" -ItemType Directory
    Write-Host "Le dossier C:\Logs a été créé."
}

# Récupérer les 50 derniers événements AD
$logsAD = Get-WinEvent -LogName "Directory Service" -MaxEvents 50

# Exporter les événements dans un fichier CSV
$logsAD | Export-Csv -Path "C:\Logs\ADLogs.csv" -NoTypeInformation

Write-Host "Exportation terminée."
Write-Host "Fichier créé : C:\Logs\ADLogs.csv"