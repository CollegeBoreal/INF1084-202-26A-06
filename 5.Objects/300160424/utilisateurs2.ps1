. "$PSScriptRoot\bootstrap.ps1"

# Verifier la GPO
Get-GPO -Name "MapSharedFolder"

# Verifier le lien avec l'OU Students
Get-GPInheritance -Target "OU=Students,DC=DC300160424,DC=local"

# Verifier le lecteur reseau Z:
$GPO = Get-GPO -Name "MapSharedFolder"
$ID = $GPO.Id.ToString("B")
Get-Content "C:\Windows\SYSVOL\domain\Policies\$ID\User\Preferences\Drives\Drives.xml"