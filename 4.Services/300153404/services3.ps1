# Créer le dossier C:\Logs s'il n'existe pas
if (!(Test-Path "C:\Logs")) {
    New-Item -Path "C:\Logs" -ItemType Directory
}

# Exporter les 50 derniers événements AD dans un fichier CSV
Get-WinEvent -LogName "Directory Service" -MaxEvents 50 |
    Export-Csv -Path "C:\Logs\ADLogs.csv" -NoTypeInformation