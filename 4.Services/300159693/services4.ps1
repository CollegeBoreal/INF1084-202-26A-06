# Arrêter le service DFSR
Stop-Service -Name DFSR

# Vérifier son état
(Get-Service -Name DFSR).Status

# Redémarrer le service DFSR
Start-Service -Name DFSR
