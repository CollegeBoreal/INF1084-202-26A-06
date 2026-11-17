# Yamna Cherif - 300160862
# services3.ps1 : exporter les 50 derniers evenements AD

# Creer le dossier de destination
New-Item -Path C:\Logs -ItemType Directory -Force | Out-Null

# Exporter les evenements dans un fichier CSV
Get-WinEvent -LogName "Directory Service" -MaxEvents 50 |
    Export-Csv -Path "C:\Logs\ADLogs.csv" -NoTypeInformation -Encoding UTF8

# Verifier le fichier et le nombre d'evenements exportes
Get-Item C:\Logs\ADLogs.csv
Import-Csv C:\Logs\ADLogs.csv | Measure-Object