New-Item -Path C:\Logs -ItemType Directory -Force; Get-WinEvent -LogName "Directory Service" -MaxEvents 100 | Export-Csv -Path C:\Logs\ADLogs.csv -NoTypeInformation; Get-Item C:\Logs\ADLogs.csv
