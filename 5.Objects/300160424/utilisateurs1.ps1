. "C:\Users\Administrator\300160424\bootstrap.ps1"

$SharedFolder = "C:\SharedResources"
$GroupName = "Students"
$Users = @("Etudiant1", "Etudiant2")

# Verifier le dossier partage
Get-Item $SharedFolder

# Verifier le groupe AD
Get-ADGroup -Identity $GroupName

# Verifier les utilisateurs
foreach ($user in $Users) {
    Get-ADUser -Identity $user
}

# Verifier les permissions du partage
Get-SmbShareAccess -Name "SharedResources"