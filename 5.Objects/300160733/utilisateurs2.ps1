Import-Module GroupPolicy

# Nom de la GPO
$GPOName = "MapSharedFolder"

# Verifier la GPO
Get-GPO -Name $GPOName

# Verifier le lien avec OU Students
Get-GPInheritance -Target "OU=Students,DC=DC300160733,DC=local"

# Creer un rapport de verification
Get-GPOReport -Name $GPOName -ReportType Html -Path "C:\300160733\GPO_MapSharedFolder.html"

# Afficher le partage reseau
Get-SmbShare -Name "SharedResources"