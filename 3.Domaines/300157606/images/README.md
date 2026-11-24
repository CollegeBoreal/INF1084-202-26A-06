TP03 – Windows : Domaines
Installation et configuration d’un domaine Active Directory
Collège Boréal
INF1084 – Administration Windows
Nom : Ouahiba Bouzidi 
Matricule : 300157606
Date : 24 novembre 2026


Introduction et objectifs

	Ce laboratoire consiste à installer le rôle AD DS sur Windows Server 2022 Datacenter, à créer une nouvelle forêt avec DNS intégré et à vérifier le fonctionnement du contrôleur de domaine à l’aide de PowerShell et de la console graphique.


Configuration du laboratoire

Paramètre : Valeur
Serveur : SRV300157606
Domaine et forêt : DC300157606.local
NetBIOS : DC300157606
Adresse IPv4 : 10.7.237.216
Système : Windows Server 2022 Datacenter


1. Qu’est-ce qu’un domaine dans Active Directory ?

Une unité logique d’administration regroupant les utilisateurs, ordinateurs, groupes et ressources partageant un annuaire, des politiques de sécurité et une authentification commune.

2. Quel est le rôle principal d’un contrôleur de domaine ?

Il héberge la base Active Directory, authentifie les utilisateurs et ordinateurs, participe à l’application des GPO et réplique les données avec les autres contrôleurs du domaine.

3. Pourquoi le DNS est-il indispensable ?

Il résout les noms et permet de localiser les contrôleurs de domaine et leurs services grâce aux enregistrements SRV.

4. Quelle est la différence entre une forêt et un arbre ?

Un arbre regroupe des domaines hiérarchiquement liés. Une forêt regroupe un ou plusieurs arbres partageant un schéma et une configuration commune.

5. Que contient le dossier SYSVOL ?

Il contient les scripts de connexion et les fichiers des stratégies de groupe (GPO), synchronisés entre contrôleurs de domaine. Son emplacement est C:\Windows\SYSVOL.

6. Quel service gère les connexions et l’authentification ?

AD DS s’appuie notamment sur Kerberos pour l’authentification et LDAP pour accéder aux objets de l’annuaire.

7. Que fait le mot de passe DSRM ?

Il permet d’accéder au mode de restauration des services d’annuaire afin de réparer Active Directory. Il est distinct du mot de passe administrateur du domaine.

8. Quelle commande ouvre Active Directory Users and Computers ?

Start-Process dsa.msc. Cette console permet de gérer les utilisateurs, groupes, ordinateurs et unités d’organisation.

2.1 – Configuration initiale
hostname
ipconfig /all

<img width="2000" height="1500" alt="1" src="https://github.com/user-attachments/assets/fb9f6f99-0544-4e65-aefe-24b3580db14e" />

Figure 1 – Configuration initiale


Le nom initial affiché est SRVID. La commande ipconfig /all présente les interfaces réseau. L’interface virtuelle interne possède une adresse automatique 169.254.73.139 ; la barre de connexion distante affiche 10.7.237.216. Cette photo ne confirme pas à elle seule une configuration IP statique.

2.2 – Renommage du serveur

Rename-Computer -NewName "SRV300157606" -Restart
hostname

<img width="2000" height="1500" alt="2" src="https://github.com/user-attachments/assets/1f45a125-1199-4f47-8333-0d3aa0b7a363" />

Figure 2 – Renommage du serveur


Après le renommage et la reconnexion, hostname affiche SRV300157606. Le nom correspond au matricule demandé.

2.3 – Installation du rôle AD DS

Install-WindowsFeature AD-Domain-Services -IncludeManagementTools

<img width="2000" height="1500" alt="3" src="https://github.com/user-attachments/assets/0e0feacb-531b-4ed9-93d6-cbf916e24b9e" />

Figure 3 – Installation du rôle AD DS

La tentative répétée de renommage est refusée car le nom est déjà correct. L’installation AD DS affiche Success=True, Restart Needed=No et Exit Code=Success : le rôle et les outils de gestion sont installés.

2.4 – Création de la forêt et du domaine

Install-ADDSForest -DomainName "DC300157606.local" -DomainNetbiosName "DC300157606" -InstallDns:$true -SafeModeAdministratorPassword (Read-Host -AsSecureString "DSRM") -Force

<img width="2000" height="1500" alt="4" src="https://github.com/user-attachments/assets/062da425-7957-46bd-a43c-350f5302e3c1" />

Figure 4 – Création de la forêt et du domaine

La première tentative a échoué car -Force était placé au début. La commande corrigée crée la forêt et prévoit DNS intégré. L’avertissement jaune concerne les anciens algorithmes de chiffrement. La réussite est confirmée par les vérifications suivantes. La commande ci-dessus utilise une saisie protégée du mot de passe DSRM plutôt que de le reproduire en clair.

2.5 – Vérification des services

Get-Service ADWS,NTDS,DNS


<img width="2000" height="1500" alt="5" src="https://github.com/user-attachments/assets/d7bb5ad8-44d8-40dd-a439-d5c9450dd6ce" />

Figure 5 – Vérification des services

Les trois services affichent Running : ADWS (services Web AD), DNS et NTDS (services de domaine). Ils sont démarrés.

2.6 – Vérification du domaine

Get-ADDomain


<img width="2000" height="1500" alt="6" src="https://github.com/user-attachments/assets/086a5dd0-c63b-4a9c-829a-e2e608eef7c9" />

Figure 6 – Vérification du domaine

DNSRoot et Forest affichent DC300157606.local ; NetBIOSName affiche DC300157606. Le niveau fonctionnel Windows2016Domain est normal sous Windows Server 2022.



2.7 – Vérification de la forêt

Get-ADForest


<img width="2000" height="1500" alt="7" src="https://github.com/user-attachments/assets/96c1bd8b-0379-4657-839a-ea3000fabf31" />

Figure 7 – Vérification de la forêt

Name et RootDomain correspondent à DC300157606.local. ForestMode indique Windows2016Forest et le serveur SRV300157606 apparaît comme catalogue global.

2.8 – Vérification du contrôleur de domaine

Get-ADDomainController


<img width="2000" height="1500" alt="8" src="https://github.com/user-attachments/assets/8a2a7e8e-4b19-47b0-adb3-56cb8b037d7c" />

Figure 8 – Vérification du contrôleur de domaine

Le serveur est activé (Enabled=True), catalogue global (IsGlobalCatalog=True) et accessible en écriture (IsReadOnly=False). Son adresse IPv4 est 10.7.237.216 et son port LDAP est 389.

2.9 – Vérification du DNS

Get-Service DNS
nslookup DC300157606.local


<img width="2000" height="1500" alt="9" src="https://github.com/user-attachments/assets/98e3a98d-ee82-43c0-ac55-24b9966e83a1" />

Figure 9 – Vérification du DNS

Le service DNS est Running et le domaine est résolu vers 10.7.237.216. Server: Unknown indique généralement une absence de résolution inverse du nom du serveur DNS local ; cela ne bloque pas cette résolution directe.

2.10 – Vérification des enregistrements SRV

Resolve-DnsName -Name "_ldap._tcp.dc._msdcs.DC300157606.local" -Type SRV


<img width="2000" height="1500" alt="10" src="https://github.com/user-attachments/assets/99dfc2ba-27fb-4d07-a3eb-c198245314a1" />

Figure 10 – Vérification des enregistrements SRV

L’enregistrement SRV pointe vers srv300157606.dc300157606.local sur le port LDAP 389. L’adresse IPv4 associée est 10.7.237.216. Le DNS permet donc de localiser le contrôleur.

2.11 – Vérification de SYSVOL et NETLOGON

Get-ChildItem C:\Windows\SYSVOL
net share



<img width="2000" height="1500" alt="11" src="https://github.com/user-attachments/assets/854f3159-fde4-4125-bb5d-445209e6682d" />

Figure 11 – Vérification de SYSVOL et NETLOGON

Les dossiers domain, staging, staging areas et sysvol sont présents. Les partages SYSVOL et NETLOGON sont affichés et la commande se termine avec succès.

2.12 – Ouverture de la console Active Directory

Start-Process dsa.msc


<img width="2000" height="1500" alt="12" src="https://github.com/user-attachments/assets/92e266ab-0ed9-4590-9397-80ddda76a837" />

Figure 12 – Ouverture de la console Active Directory

La console Active Directory Users and Computers s’ouvre et affiche le domaine DC300157606.local. Cela confirme l’accès à l’outil graphique de gestion.

2.13 – Affichage de la structure du domaine

Développer DC300157606.local dans la console.



<img width="2000" height="1500" alt="13" src="https://github.com/user-attachments/assets/a74f42e4-e278-444a-a867-832b68d5ec97" />

Figure 13 – Affichage de la structure du domaine

Les conteneurs Builtin, Computers, ForeignSecurityPrincipals, Managed Service Accounts et Users ainsi que l’unité d’organisation Domain Controllers sont visibles. La structure initiale du domaine est accessible.


3. Conclusion
	Le laboratoire a permis de configurer le serveur SRV300157606 comme contrôleur du domaine DC300157606.local. Les vérifications du domaine, de la forêt, des services, du DNS et des partages SYSVOL et NETLOGON ainsi que l’ouverture de la console AD confirment la réussite des manipulations demandées.
