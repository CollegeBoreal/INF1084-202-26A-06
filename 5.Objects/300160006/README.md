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

