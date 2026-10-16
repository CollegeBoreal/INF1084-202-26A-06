Laboratoire — Active Directory, partage SMB, GPO et RDP

Collège Boréal — Techniques des systèmes informatiques

Cours : INF1084 — Objets gérables par Active Directory

Étudiant : Riadh Sahraoui

Matricule : 300159203

Système : Windows Server 2022 Datacenter

Domaine : DC300159203.local

Serveur : SRV300159203

1. Objectif du laboratoire

L’objectif de ce travail est de gérer les accès aux ressources dans un domaine Active Directory sous Windows Server 2022.

Le travail comprend :

La création d’une unité organisationnelle (Students) ;

La création d’un groupe de sécurité global (Students) ;

La création des comptes utilisateurs (Etudiant1, Etudiant2) ;

La configuration et la sécurisation d’un partage SMB (C:\SharedResources) ;

La création et la liaison d’une stratégie de groupe (GPO) pour le mappage automatique du lecteur réseau Z: ;

L’activation du Bureau à distance (RDP) et la vérification des autorisations d’accès.

2. Environnement de travail

Élément

Configuration

Contrôleur de domaine

SRV300159203

Système d'exploitation

Windows Server 2022 Datacenter

Domaine DNS

DC300159203.local

Nom NetBIOS

DC300159203

Nom distinctif du domaine

DC=DC300159203,DC=local

Unité organisationnelle (OU)

Students

Groupe de sécurité

Students

Utilisateurs

Etudiant1, Etudiant2

Dossier partagé

C:\SharedResources

Chemin réseau

\SRV300159203\SharedResources

Stratégie de groupe (GPO)

MapSharedFolder

Lecteur réseau

Z:

3. Création des objets Active Directory et du partage SMB

Les objets Active Directory ainsi que le répertoire partagé ont été configurés à l'aide de scripts PowerShell sous la session administrateur du contrôleur de domaine. L'unité d'organisation Students regroupe l'ensemble des comptes du laboratoire.

# Création de l'OU et du groupe
New-ADOrganizationalUnit -Name "Students" -Path "DC=DC300159203,DC=local"
New-ADGroup -Name "Students" -GroupScope Global -Description "Users allowed RDP and shared folder access"


Le script utilisateurs1.ps1 a permis de créer les comptes Etudiant1 et Etudiant2, de les ajouter au groupe Students, de créer le répertoire C:\SharedResources et d'établir le partage SMB.

<img width="1345" height="823" alt="image" src="https://github.com/user-attachments/assets/7b918ce2-d24e-4ca8-97a0-04564a9dcb2c" />  



Rôle : Preuve de l'exécution du script utilisateurs1.ps1 (création OU, groupe Students, utilisateurs Etudiant1/Etudiant2, dossier et partage SMB).

4. Configuration de la stratégie de groupe (GPO)

Une stratégie de groupe (GPO) intitulée MapSharedFolder a été créée puis liée directement à l'OU Students. Cette GPO permet de mapper automatiquement le lecteur réseau Z: vers le chemin \\SRV300159203\SharedResources.

# Création et liaison de la GPO
New-GPO -Name "MapSharedFolder"
New-GPLink -Name "MapSharedFolder" -Target "OU=Students,DC=DC300159203,DC=local"


Le script utilisateurs2.ps1 applique la GPO, active le Bureau à distance (RDP) et configure les règles de pare-feu nécessaires.

<img width="1223" height="913" alt="image" src="https://github.com/user-attachments/assets/3c0fe75d-f7f9-445b-99f0-e0e0d93e7673" />  
<img width="1269" height="1334" alt="image" src="https://github.com/user-attachments/assets/2db85aa0-3833-46ef-9976-4f0f64071f1a" />




Rôle : Preuve de l'exécution du script utilisateurs2.ps1 (création GPO, liaison à l'OU Students, activation RDP et pare-feu).

5. Validation de la connexion client et du partage réseau

Connexion sous la session de l'utilisateur Etudiant1. La commande gpupdate /force permet de forcer la mise à jour des stratégies utilisateur. Le lecteur réseau Z: est correctement monté via net use Z: et s'affiche dans l'explorateur Ce PC.

<img width="1024" height="802" alt="image" src="https://github.com/user-attachments/assets/f0a95fdd-8417-4f5c-b280-c6988febea34" />


Rôle : Preuve de l'exécution de gpupdate /force, net use Z: et affichage du lecteur réseau Z: dans Ce PC sous la session Etudiant1.

L'ouverture du lecteur réseau Z: (SharedResources \\SRV300159203) dans l'Explorateur de fichiers confirme que les accès SMB et NTFS sont correctement configurés.

<img width="1694" height="947" alt="image" src="https://github.com/user-attachments/assets/b5eb8124-a967-49ee-97bc-648f68fcf17f" />


Rôle : Preuve de l'ouverture du lecteur Z: dans l'Explorateur de fichiers.

6. Test de sécurité RDP (Utilisateur hors du groupe)

Afin de vérifier que seuls les membres du groupe Students sont autorisés à se connecter à distance, un test a été effectué avec un compte utilisateur non membre (UserTest).

Lors de la tentative de connexion RDP vers l'adresse IP 10.7.237.222, le système bloque la connexion et affiche le message d'erreur :

"The connection was denied because the user account is not authorized for remote login."

Ce refus d'accès confirme la bonne application des restrictions de sécurité RDP.

<img width="799" height="742" alt="image" src="https://github.com/user-attachments/assets/eb84a027-27f3-46e3-92a6-d3734b457b2a" />


Rôle : Preuve du message d'erreur RDP lors de la tentative de connexion avec UserTest.

7. Conclusion

Ce laboratoire a permis de valider la gestion centralisée des utilisateurs et des ressources sous Windows Server 2022. L'utilisation conjointe d'Active Directory, des partages SMB, des GPO et des restrictions RDP garantit un accès sécurisé et automatisé pour les utilisateurs autorisés.
