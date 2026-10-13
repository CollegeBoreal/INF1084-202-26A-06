# Laboratoire Windows Server 2022 — Active Directory, SMB et GPO
Collège Boréal — Techniques des systèmes informatiques
Identifiant étudiant : 300159437
Serveur : SRV300159437
Domaine : DC300159437.local
Environnement : Windows Server 2022 / Hyper-V

1. Objectif du laboratoire
L'objectif de ce laboratoire est de mettre en pratique l'administration d'un environnement Windows Server 2022 en utilisant Active Directory Domain Services (AD DS), PowerShell, les partages réseau SMB et les stratégies de groupe (GPO).
Les principales tâches sont :
- Créer une unité organisationnelle (OU).
- Créer un groupe de sécurité Active Directory.
- Créer deux utilisateurs et les ajouter au groupe.
- Configurer un dossier partagé avec des autorisations NTFS et SMB.
- Créer une stratégie de groupe pour mapper automatiquement un lecteur réseau.
- Vérifier les configurations et résoudre les problèmes d'accès.
2. Environnement de travail
Élément	Configuration
Système	Windows Server 2022
Virtualisation	Hyper-V
Domaine	DC300159437.local
Contrôleur de domaine	SRV300159437
Adresse IP	10.7.237.223
OU	Students
Groupe	Students
Utilisateurs	Etudiant1, Etudiant2
Dossier partagé	C:\SharedResources
GPO	MapSharedFolder
Lecteur réseau	Z:
3. Création de l'unité organisationnelle
Nous avons commencé par importer le module Active Directory et créer l'unité organisationnelle Students.
Import-Module ActiveDirectory

$DomainDN = (Get-ADDomain).DistinguishedName

New-ADOrganizationalUnit `
    -Name "Students" `
    -Path $DomainDN
<img src="images/ChatGPT%20Image%20Oct%2013%2C%202026%2C%2001_07_15%20PM.png" width="50%" height="50%">

Pour vérifier la création :
Get-ADOrganizationalUnit -Filter * |
Select-Object Name,DistinguishedName


Résultat : l'OU Students a été créée avec succès dans le domaine DC300159437.local.
4. Création du groupe de sécurité
Nous avons créé un groupe global de sécurité nommé Students, permettant de gérer les autorisations des utilisateurs.
New-ADGroup `
    -Name "Students" `
    -SamAccountName "Students" `
    -GroupScope Global `
    -GroupCategory Security `
    -Path "OU=Students,DC=DC300159437,DC=local"


Vérification :
Get-ADGroup -Identity "Students"


5. Création des utilisateurs
Deux utilisateurs ont été créés dans l'OU Students.
$OU = "OU=Students,DC=DC300159437,DC=local"

$Password1 = Read-Host "Mot de passe Etudiant1" -AsSecureString

New-ADUser `
    -Name "Etudiant1" `
    -SamAccountName "Etudiant1" `
    -Path $OU `
    -AccountPassword $Password1 `
    -Enabled $true


Pour le deuxième utilisateur :
$Password2 = Read-Host "Mot de passe Etudiant2" -AsSecureString

New-ADUser `
    -Name "Etudiant2" `
    -SamAccountName "Etudiant2" `
    -Path $OU `
    -AccountPassword $Password2 `
    -Enabled $true


Les utilisateurs ont ensuite été ajoutés au groupe :
Add-ADGroupMember `
    -Identity "Students" `
    -Members "Etudiant1","Etudiant2"


Vérification :
Get-ADGroupMember -Identity "Students" |
Select-Object Name,SamAccountName,ObjectClass


Résultat : les deux utilisateurs appartiennent au groupe Students et leurs comptes sont activés.
6. Création du dossier partagé
Nous avons créé un dossier sur le serveur pour permettre aux étudiants de partager des ressources.
$SharedFolder = "C:\SharedResources"

New-Item -Path $SharedFolder -ItemType Directory -Force


Vérification :
Test-Path "C:\SharedResources"


Résultat :
True


Configuration des permissions NTFS
icacls "C:\SharedResources" /grant "DC300159437\Students:(OI)(CI)M"


Cette commande accorde au groupe Students le droit de modification sur le dossier, ses fichiers et ses sous-dossiers.
Création du partage SMB
New-SmbShare `
    -Name "SharedResources" `
    -Path "C:\SharedResources" `
    -ChangeAccess "DC300159437\Students"


Nous avons également accordé un accès complet aux administrateurs du domaine :
Grant-SmbShareAccess `
    -Name "SharedResources" `
    -AccountName "DC300159437\Domain Admins" `
    -AccessRight Full `
    -Force


Vérification :
Get-SmbShareAccess -Name "SharedResources"


Résultat :
Groupe	Autorisation
Students	Change
Domain Admins	Full
7. Création de la stratégie de groupe GPO
Nous avons créé une GPO appelée MapSharedFolder afin de connecter automatiquement le lecteur réseau Z: pour les utilisateurs de l'OU Students.
Import-Module GroupPolicy

New-GPO -Name "MapSharedFolder"


Liaison de la GPO :
New-GPLink `
    -Name "MapSharedFolder" `
    -Target "OU=Students,DC=DC300159437,DC=local"


Ensuite, nous avons ouvert la console :
gpmc.msc


Dans l'éditeur de stratégie de groupe :
User Configuration
└── Preferences
    └── Windows Settings
        └── Drive Maps


Les paramètres suivants ont été configurés :
Paramètre	Valeur
Action	Update
Location	\SRV300159437\SharedResources
Drive Letter	Z:
Label	SharedResources
8. Tests et vérifications
Nous avons vérifié l'accès au dossier partagé :
Test-Path "\\SRV300159437\SharedResources"


Lors du premier test, le système a affiché :
Access is denied
False


Après vérification des autorisations SMB et ajout du groupe Domain Admins, le test a retourné :
True


Cela confirme que le compte administrateur pouvait accéder au partage réseau.
Nous avons également vérifié les permissions NTFS :
icacls "C:\SharedResources"


Les résultats ont confirmé que le groupe Students possédait les droits de modification.
Le lecteur Z: n'était pas présent dans la session administrateur. Cela est cohérent avec le fait que la GPO cible les utilisateurs de l'OU Students. Le mappage automatique doit être validé dans une session utilisateur sur une machine membre du domaine.
9. Difficultés rencontrées
Pendant ce laboratoire, j'ai rencontré plusieurs difficultés.
La première concernait la configuration du domaine Active Directory. J'ai dû vérifier les paramètres de mon contrôleur de domaine afin de corriger le nom du domaine.
La deuxième difficulté concernait les autorisations du dossier partagé. Lorsque j'ai essayé d'accéder au partage avec le compte administrateur, Windows affichait le message Access is denied.
J'ai utilisé les commandes Get-SmbShareAccess et icacls pour analyser les permissions et identifier les autorisations à corriger.
Enfin, j'ai appris qu'un lecteur réseau configuré dans une GPO n'apparaît pas nécessairement dans toutes les sessions Windows. Son application dépend notamment de l'utilisateur connecté et de l'emplacement de son compte dans Active Directory.
10. Conclusion personnelle
Ce laboratoire m'a permis de développer mes connaissances en administration de Windows Server 2022, notamment dans la gestion des utilisateurs, des groupes de sécurité et des ressources partagées.
J'ai appris à utiliser PowerShell pour automatiser certaines tâches administratives, à configurer les autorisations NTFS et SMB et à créer des stratégies de groupe.
J'ai également rencontré des erreurs qui m'ont aidé à mieux comprendre l'importance de vérifier chaque configuration avant de passer à l'étape suivante.
Grâce à ce travail, je comprends mieux le fonctionnement d'Active Directory et la manière dont un administrateur système peut gérer les accès et les ressources dans un environnement professionnel.
Ce laboratoire représente une expérience pratique importante dans mon apprentissage de l'administration des systèmes informatiques.
