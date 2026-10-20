# ==========================================
# Script : services4.ps1
# Objectif : Arrêter, vérifier et redémarrer
#            le service DFS Replication
# ==========================================

Write-Host "=== Test du service DFSR ==="

# Afficher l'état initial
Write-Host "`nÉtat initial :"
Get-Service -Name DFSR

# Arrêter le service DFSR
Write-Host "`nArrêt du service DFSR..."
Stop-Service -Name DFSR

# Vérifier son état
Write-Host "`nÉtat après l'arrêt :"
(Get-Service -Name DFSR).Status

# Redémarrer le service DFSR
Write-Host "`nRedémarrage du service DFSR..."
Start-Service -Name DFSR

# Vérifier l'état final
Write-Host "`nÉtat final :"
(Get-Service -Name DFSR).Status

Write-Host "`n=== Test terminé ==="