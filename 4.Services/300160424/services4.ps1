# Arrêter DFSR et afficher son état
Stop-Service -Name DFSR
(Get-Service -Name DFSR).Status

# Démarrer DFSR et afficher son état
Start-Service -Name DFSR
(Get-Service -Name DFSR).Status