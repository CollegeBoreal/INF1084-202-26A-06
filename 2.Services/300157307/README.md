1. Objectif du laboratoire

L’objectif de ce laboratoire est de travailler avec Active Directory sur Windows Server 2022. La tâche consiste à créer un utilisateur à l’aide de PowerShell, puis à lui attribuer des droits d’administration dans le domaine. Des commandes de vérification sont ensuite utilisées pour confirmer que le compte a bien été créé et qu’il possède les groupes nécessaires.

2. Vérification de l’environnement

Avant de commencer, PowerShell est ouvert avec les droits d’administrateur. On vérifie d’abord le nom du serveur, l’utilisateur connecté et le domaine Active Directory.

hostname

whoami

Get-ADDomain

La commande Get-ADDomain permet notamment de vérifier que le serveur est bien connecté à un domaine Active Directory et d’obtenir le nom DNS du domaine.

3. Vérification du module Active Directory

Le module Active Directory est chargé avec la commande suivante :

Import-Module ActiveDirectory

On peut ensuite afficher les utilisateurs déjà présents dans Active Directory :

Get-ADUser -Filter * | Select-Object Name,SamAccountName

4. Création du nouvel utilisateur

Un compte utilisateur est créé avec New-ADUser. Le mot de passe est demandé de manière sécurisée avec Read-Host -AsSecureString.

$domain = (Get-ADDomain).DNSRoot

New-ADUser `
-Name "Etudiant Admin" `
-GivenName "Etudiant" `
-Surname "Admin" `
-SamAccountName "etudiantadmin" `
-UserPrincipalName "etudiantadmin@$domain" `
-AccountPassword (Read-Host "Mot de passe" -AsSecureString) `
-Enabled $true

Important : le mot de passe réel ne doit pas être écrit dans la documentation, dans le README ou dans une capture d’écran.

5. Attribution des droits d’administration

Pour donner à l’utilisateur les droits d’administration du domaine, il est ajouté au groupe Domain Admins :

Add-ADGroupMember -Identity "Domain Admins" -Members "etudiantadmin"

L’appartenance au groupe est ensuite vérifiée avec :

Get-ADPrincipalGroupMembership "etudiantadmin" | Select-Object Name

Le résultat doit notamment afficher le groupe Domain Admins si l’ajout a été effectué correctement.

6. Vérification du compte

On vérifie que le compte existe bien dans Active Directory :

Get-ADUser -Identity "etudiantadmin"

Get-ADUser -Identity "etudiantadmin" -Properties Enabled,MemberOf

7. Ouverture de la console Active Directory

La console Active Directory Users and Computers peut être ouverte directement depuis PowerShell :

Start-Process dsa.msc

Dans la console, le compte etudiantadmin peut être recherché dans le conteneur Users ou dans l’unité d’organisation utilisée pour le laboratoire.

8. Résultat attendu

Le domaine Active Directory est accessible.

Le module Active Directory fonctionne dans PowerShell.

L’utilisateur etudiantadmin est créé et activé.

L’utilisateur appartient au groupe Domain Admins.

Le compte peut être retrouvé dans Active Directory Users and Computers.

9. Captures d’écran à fournir

Pour documenter la réalisation du laboratoire, les captures suivantes sont recommandées :

PowerShell avec Get-ADDomain montrant le domaine.

PowerShell avec la création de l’utilisateur.

PowerShell montrant l’utilisateur dans le groupe Domain Admins.

Active Directory Users and Computers montrant le compte créé.

10. Conclusion

Ce laboratoire m’a permis de pratiquer l’administration d’Active Directory avec PowerShell. J’ai vérifié le domaine, créé un compte utilisateur et vérifié son appartenance aux groupes d’administration. La console Active Directory permet également de vérifier visuellement la présence du compte
