Import-Module ActiveDirectory

# Dossier partage
$SharedFolder = "C:\SharedResources"

if (-not (Test-Path $SharedFolder)) {
    New-Item -Path $SharedFolder -ItemType Directory
}

# Groupe Students
$GroupName = "Students"

if (-not (Get-ADGroup -Filter "SamAccountName -eq '$GroupName'")) {
    New-ADGroup -Name $GroupName -GroupScope Global `
        -GroupCategory Security
}

# Utilisateurs
$Users = @("Etudiant1", "Etudiant2")

foreach ($user in $Users) {
    if (-not (Get-ADUser -Filter "SamAccountName -eq '$user'")) {
        Write-Host "Utilisateur absent : $user"
    }

    Add-ADGroupMember -Identity $GroupName -Members $user
}

# Verification
Get-ADGroupMember -Identity $GroupName

Get-SmbShare -Name "SharedResources"