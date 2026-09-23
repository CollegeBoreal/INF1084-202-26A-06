# Laboratoire 2 - Services

**Nom : Islam Oustani**  
**ID : 300151722**

## Objectif

Créer un utilisateur ayant les droits d’administration sur Windows Server 2022 en utilisant PowerShell.

## Configuration du serveur

Le serveur Windows Server 2022 est configuré en mode `WORKGROUP`.

La vérification PowerShell a donné :

```text
Domaine : WORKGROUP
DomainRole : 2
```

Le serveur n'étant pas un contrôleur de domaine Active Directory, un utilisateur local a été créé.

## Commandes PowerShell utilisées

```powershell
$ID = "300151722"
$Nom = "Islam Oustani"

$password = Read-Host "Entrez le mot de passe pour $ID" -AsSecureString

New-LocalUser `
    -Name $ID `
    -FullName $Nom `
    -Password $password

$adminGroup = Get-LocalGroup -SID "S-1-5-32-544"

Add-LocalGroupMember `
    -Group $adminGroup.Name `
    -Member $ID
```

## Vérification

```powershell
Get-LocalUser -Name "300151722"

$adminGroup = Get-LocalGroup -SID "S-1-5-32-544"

Get-LocalGroupMember -Group $adminGroup.Name |
    Where-Object {$_.Name -match "300151722"}
```

## Résultat

L'utilisateur local `300151722` a été créé et activé avec succès sur Windows Server 2022.

L'utilisateur a également été ajouté au groupe des administrateurs du serveur.

## Preuve

<img width="1022" height="618" alt="Image Codex 23 sept  2026, 19_05_56" src="https://github.com/user-attachments/assets/6e86d3b9-c0c7-40a3-b411-0ecd9e40e85a" />

<img width="3955" height="2448" alt="Document numérisé 7_page-0001" src="https://github.com/user-attachments/assets/077c36d0-1c8a-4859-a63b-4a09fe7bd383" />


## Conclusion

Ce laboratoire m'a permis de créer un utilisateur local avec PowerShell et de lui attribuer les droits d'administration sur Windows Server 2022.
