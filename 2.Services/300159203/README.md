Laboratoire — Création d’un utilisateur administrateur (Windows Server 2022)
Créer un utilisateur local 300159203 et lui attribuer les droits d’administration sur Windows Server 2022 Datacenter, en utilisant PowerShell.
1-Ouvrir PowerShell

2-Créer l’utilisateur local 
$Password = Read-Host -Prompt "Entrer le mot de passe pour 300159203" -AsSecureString

New-LocalUser -Name "300159203" `
    -Password $Password `
    -FullName "Administrateur local - ID 300159203" `
    -Description "Compte admin pour Windows Server 2022 (Rack 2, U13)" `
    -PasswordNeverExpires:$true `
    -UserMayNotChangePassword:$true

3️-Ajouter l’utilisateur au groupe Administrators
Add-LocalGroupMember -Group "Administrators" -Member "300159203"

4-Vérifier l’ajout
Get-LocalGroupMember -Group "Administrators"
