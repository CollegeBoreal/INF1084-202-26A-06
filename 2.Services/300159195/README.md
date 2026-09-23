# Laboratoire 2 - Gestion des services et utilisateurs

*Nom : Touadjni Islem*\
*ID : 300159195*

## Objectif

Créer un compte utilisateur local avec des privilèges d’administration sur Windows Server 2022 en utilisant des commandes PowerShell.

## Configuration du serveur

Le serveur Windows Server 2022 fonctionne actuellement dans un environnement WORKGROUP.

La vérification effectuée avec PowerShell affiche :

text
Domaine : WORKGROUP
DomainRole : 2


Le serveur n'étant pas configuré comme contrôleur de domaine Active Directory, un utilisateur local a été créé.

## Commandes PowerShell utilisées

powershell
$ID = "300159195"
$Nom = "Touadjni Islem"

$password = Read-Host "Entrez le mot de passe pour $ID" -AsSecureString

New-LocalUser `
    -Name $ID `
    -FullName $Nom `
    -Password $password

$adminGroup = Get-LocalGroup -SID "S-1-5-32-544"

Add-LocalGroupMember `
    -Group $adminGroup.Name `
    -Member $ID


## Vérification

Pour vérifier que l'utilisateur a bien été créé :

powershell
Get-LocalUser -Name "300159195"


Pour vérifier que l'utilisateur appartient au groupe Administrateurs :

powershell
$adminGroup = Get-LocalGroup -SID "S-1-5-32-544"

Get-LocalGroupMember -Group $adminGroup.Name |
    Where-Object {$_.Name -match "300159195"}

<img width="2048" height="1152" alt="image" src="https://github.com/user-attachments/assets/34f98d97-6494-4a56-a096-da657577d6d6" />

Conclusion
Ce laboratoire a permis de créer un utilisateur local sur Windows Server 2022 avec PowerShell et de lui attribuer les droits d’administration. Les commandes utilisées ont également permis de vérifier que le compte a bien été créé et ajouté au groupe Administrateurs

