# Chemin du dossier
$SharedFolder = "C:\SharedResources"

# Créer le dossier
New-Item -Path $SharedFolder -ItemType Directory -Force

# Groupe AD
$GroupName = "Students"

# Créer le groupe AD
New-ADGroup `
    -Name $GroupName `
    -GroupScope Global `
    -Description "Users allowed RDP and shared folder access"

# Créer les utilisateurs AD
$Users = @("Etudiant1","Etudiant2")

foreach ($user in $Users) {

    New-ADUser `
        -Name $user `
        -SamAccountName $user `
        -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) `
        -Enabled $true `
        -Path "OU=Students,DC=DC300151722,DC=local"

    Add-ADGroupMember `
        -Identity $GroupName `
        -Members $user
}

# Partager le dossier
New-SmbShare `
    -Name "SharedResources" `
    -Path $SharedFolder `
    -FullAccess $GroupName