J’ai commencé par importer les modules ActiveDirectory et GroupPolicy dans PowerShell afin de pouvoir gérer les utilisateurs, 
les groupes et les GPO. Ensuite, j’ai récupéré les informations de mon domaine Active Directory, dont le nom NetBIOS `DC300160006` et le nom DNS `DC300160006.local`. 
J’ai également créé trois variables PowerShell : `$netbiosName`, `$domainDN` et `$StudentsOU`, pour faciliter la configuration du domaine et définir le chemin de l’unité d’organisation Students.
Les résultats obtenus montrent que les variables sont correctement définies.
![images alt](

J’ai créé l’unité d’organisation Students dans mon domaine Active Directory DC300160006.local. 
Cette unité d’organisation permettra d’organiser les comptes des étudiants et d’appliquer des stratégies de groupe (GPO) aux objets qu’elle contient. 
La création a réussi et le chemin de l’OU correspond à celui de mon domaine.

J’ai créé le groupe de sécurité Students dans l’unité d’organisation Students de mon domaine Active Directory.
J’ai choisi une portée globale et une catégorie de sécurité afin de pouvoir utiliser ce groupe pour gérer les permissions d’accès au dossier partagé et à la connexion à distance RDP. 
J’ai ensuite vérifié sa création avec PowerShell et confirmé que son nom, sa portée, sa catégorie et son emplacement sont corrects.

J’ai créé les comptes utilisateurs Etudiant1 et Etudiant2 dans Active Directory. 
Après avoir rencontré une erreur liée à la complexité du mot de passe, j’ai défini un nouveau mot de passe conforme à la stratégie de sécurité du domaine, puis j’ai activé les deux comptes. Je les ai ensuite ajoutés au groupe de sécurité Students.
Enfin, j’ai vérifié avec PowerShell que les deux comptes sont activés et membres du groupe.

J’ai créé le dossier C:\SharedResources sur mon serveur Windows Server 2022 et vérifié son existence avec la commande Test-Path, qui a retourné True. Ensuite,
j’ai créé un partage réseau SMB nommé SharedResources et accordé le contrôle total au groupe DC300160006\Students au niveau du partage. 
J’ai vérifié que le partage pointe vers le bon dossier.
J’ai vérifié les permissions du partage réseau SharedResources avec la commande Get-SmbShareAccess et confirmé que le groupe DC300160006\Students possède le contrôle total sur le partage.
Ensuite, j’ai utilisé la commande icacls pour accorder au groupe les permissions NTFS de modification sur le dossier C:\SharedResources, ainsi que sur ses fichiers et sous-dossiers. 
La vérification finale a confirmé que les permissions ont été appliquées sans erreur.

J’ai créé la stratégie de groupe MapSharedFolder et je l’ai liée à l’unité d’organisation Students de mon domaine Active Directory. 
J’ai ensuite vérifié le lien avec la commande Get-GPInheritance. Les résultats confirment que la GPO est activée, qu’elle cible la bonne OU et que l’héritage des stratégies de groupe n’est pas bloqué.

J’ai créé et configuré une stratégie de groupe nommée MapSharedFolder, liée à l’unité d’organisation Students. 
Cette stratégie permet de mapper automatiquement le partage réseau \\SRV300160006\SharedResources comme lecteur Z: pour les utilisateurs concernés.

J’ai vérifié que le Bureau à distance (RDP) était activé sur le serveur SRV300160006 et que le service TermService était en cours d’exécution. Ensuite, j’ai ajouté le groupe Active Directory Students au groupe local Remote Desktop Users.
J’ai vérifié l’ajout avec la commande net localgroup "Remote Desktop Users".

J’ai vérifié les règles du pare-feu Windows associées au Bureau à distance avec Get-NetFirewallRule. 
Les règles TCP et UDP affichées sont activées et configurées pour tous les profils réseau (Any).

Le script `utilisateurs1.ps1` permet de vérifier et de configurer les éléments nécessaires au partage de ressources. Il vérifie l’existence du dossier partagé, du groupe Active Directory `Students` et des comptes `Etudiant1` et `Etudiant2`. Il s’assure également que les utilisateurs appartiennent au groupe et que les permissions SMB et NTFS sont configurées. L’exécution du script s’est terminée avec succès.

Le script `utilisateurs2.ps1` permet de vérifier la configuration de la stratégie de groupe `MapSharedFolder`. Il vérifie l’existence de la GPO, son lien avec l’unité d’organisation `Students` et la configuration du lecteur réseau `Z:` vers le dossier partagé `\\SRV300160006\SharedResources`. L’exécution du script s’est terminée avec succès.

Le script `utilisateurs3.ps1` configure le Bureau à distance sur le serveur. Il active les connexions RDP, active les règles du pare-feu Windows et vérifie l’appartenance du groupe `Students` au groupe local `Remote Desktop Users`. Le service `TermService` est en cours d’exécution et la valeur `fDenyTSConnections` est égale à 0. L’exécution du script corrigé s’est terminée sans erreur.

J'ai testé l'accès à distance avec le compte Etudiant1. Depuis mon ordinateur, j'ai ouvert une connexion Bureau à distance (mstsc) vers l'adresse 10.7.237.228 avec le compte DC300160006\Etudiant1. La première tentative a été refusée, car le serveur est un contrôleur de domaine et le simple ajout du groupe Students à Remote Desktop Users ne suffisait pas. J'ai donc accordé le droit « Allow log on through Remote Desktop Services » aux groupes Students et Administrators dans la stratégie Default Domain Controllers Policy, puis j'ai vérifié avec secedit que la ligne SeRemoteInteractiveLogonRight contenait bien Students. Après cette modification, la connexion RDP avec Etudiant1 a réussi.

Dans la session, la commande whoami affiche dc300160006\etudiant1, la commande net use montre le lecteur Z: relié à \\SRV300160006\SharedResources avec le statut OK, et l'Explorateur de fichiers affiche le lecteur SharedResources (Z:). Le test confirme que le lecteur réseau est mappé pour un membre du groupe Students et que l'accès RDP fonctionne.

## Tableau récapitulatif

| Élément | Configuration | Vérification |
|---|---|---|
| Domaine | DC300160006.local | `Get-ADDomain` |
| Serveur | SRV300160006 (10.7.237.228) | `hostname` |
| Unité d'organisation | Students | `Get-ADOrganizationalUnit` |
| Groupe AD | Students (global, sécurité) | `Get-ADGroup` |
| Utilisateurs | Etudiant1 et Etudiant2, activés et membres de Students | `Get-ADUser`, `Get-ADGroupMember` |
| Dossier partagé | C:\SharedResources | `Test-Path` |
| Partage SMB | SharedResources, contrôle total pour Students | `Get-SmbShareAccess` |
| Permissions NTFS | Modification pour Students | `icacls` |
| GPO | MapSharedFolder, liée à l'OU Students | `Get-GPInheritance` |
| Lecteur réseau | Z: vers `\\SRV300160006\SharedResources` | `net use` (statut OK) |
| Bureau à distance | Activé (fDenyTSConnections = 0) | Registre, service TermService |
| Pare-feu | Règles Remote Desktop activées | `Get-NetFirewallRule` |
| Groupe Remote Desktop Users | Students ajouté | `Get-ADGroupMember` |
| Droit RDP sur le DC | Students et Administrators dans Default Domain Controllers Policy | `secedit` (SeRemoteInteractiveLogonRight) |
| Test RDP | Connexion réussie avec DC300160006\Etudiant1 | `whoami` |
| Test lecteur Z: | SharedResources (Z:) visible dans l'Explorateur | Capture d'écran |

## Conclusion

Ce laboratoire m'a permis de manipuler plusieurs objets Active Directory uniquement avec PowerShell : une unité d'organisation, un groupe de sécurité, des comptes utilisateurs, un dossier partagé SMB, une GPO et l'accès Bureau à distance.

Le test final avec le compte Etudiant1 a montré que l'ensemble fonctionne : la connexion RDP réussit, `whoami` confirme l'identité de l'utilisateur et le lecteur réseau Z: est relié au partage `\\SRV300160006\SharedResources`.

J'ai aussi appris qu'un contrôleur de domaine se comporte différemment d'un serveur membre. Ajouter le groupe Students à Remote Desktop Users ne suffisait pas : il a fallu accorder le droit « Allow log on through Remote Desktop Services » dans la stratégie Default Domain Controllers Policy. J'ai également compris qu'il faut utiliser le nom du serveur (SRV300160006) dans le chemin du partage, et non celui du domaine.


