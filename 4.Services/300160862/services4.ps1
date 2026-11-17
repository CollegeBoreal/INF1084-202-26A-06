# Yamna Cherif - 300160862
# services4.ps1 : arreter puis demarrer DFSR

# Arreter le service et afficher son etat
Stop-Service -Name DFSR -ErrorAction Stop
(Get-Service -Name DFSR).Status

# Demarrer le service et afficher son etat
Start-Service -Name DFSR -ErrorAction Stop
(Get-Service -Name DFSR).Status