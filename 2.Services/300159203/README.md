Laboratoire — Création d’un utilisateur administrateur (Windows Server 2022)
Créer un utilisateur local 300159203 et lui attribuer les droits d’administration sur Windows Server 2022 Datacenter, en utilisant PowerShell.
1-Ouvrir PowerShell

2-Créer l’utilisateur local 
$Password = Read-Host -Prompt "Entrer le mot de passe pour 300159203" -AsSecureString

New-LocalUser -Name "300159203" `
    -Password $Password `
    -FullName "Riadh Sahraoui (ID 300159203)" `
    -Description "Compte admin pour Windows Server 2022 (Rack 2, U13)" `
    -PasswordNeverExpires:$true `
    -UserMayNotChangePassword:$true

3️-Ajouter l’utilisateur au groupe Administrators
Add-LocalGroupMember -Group "Administrators" -Member "300159203"

4-Vérifier l’ajout
Get-LocalGroupMember -Group "Administrators"
<img width="1536" height="2048" alt="image" src="https://github.com/user-attachments/assets/22812d60-e2fe-43a7-9398-1cbd8c08556a" />
<img width="2048" height="1536" alt="image" src="https://github.com/user-attachments/assets/ccf2eac7-a1d7-4219-8968-7d97ea448eb6" />

