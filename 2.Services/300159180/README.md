🖥️ Création d'un utilisateur administrateur — Windows Server 2022
🎯 Objectif

Créer l'utilisateur 300159180 sur Windows Server 2022 et lui attribuer les droits d'administration à l'aide de PowerShell.

1. Créer le mot de passe
$password = Read-Host "Entrer le mot de passe" -AsSecureString

2. Créer l'utilisateur
New-LocalUser -Name "300159180" -Password $password -Description "Compte administrateur du laboratoire"

3. Ajouter l'utilisateur au groupe Administrators
Add-LocalGroupMember -Group "Administrators" -Member "300159180"

4. Vérifier la création de l'utilisateur
Get-LocalUser -Name "300159180"

5. Vérifier les droits administrateur
Get-LocalGroupMember -Group "Administrators"

L'utilisateur 300159180 doit apparaître dans la liste des membres du groupe Administrators.
