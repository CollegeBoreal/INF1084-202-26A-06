New-Item -Path "C:\Logs" -ItemType Directory -Force

Get-WinEvent -LogName "Directory Service" -MaxEvents 50 |
    Export-Csv -Path "C:\Logs\ADLogs.csv" -NoTypeInformation