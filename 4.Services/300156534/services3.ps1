# Exportation des evenements Active Directory

if (!(Test-Path "C:\Logs")) {
    New-Item -Path "C:\Logs" -ItemType Directory
}

Get-WinEvent -LogName "Directory Service" -MaxEvents 50 |
Select-Object TimeCreated, Id, LevelDisplayName, Message |
Export-Csv -Path "C:\Logs\ADLogs.csv" -NoTypeInformation -Encoding UTF8

Write-Host "Exportation terminee avec succes"

Get-Item "C:\Logs\ADLogs.csv"