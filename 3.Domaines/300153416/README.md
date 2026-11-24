Rapport de Laboratoire : Configuration et Vérification d'un Contrôleur de Domaine Active Directory (AD DS)
1. Objectif du laboratoire
L'objectif de ce travail pratique est de valider le déploiement et le bon fonctionnement d'un contrôleur de domaine Active Directory sous Windows Server 2022, de vérifier l'état de la forêt et du domaine via PowerShell, et d'accéder à la console de gestion graphique.

2. Paramètres de l'infrastructure
Nom du serveur (Contrôleur de domaine) : SRV300153416.boreal.local

Adresse IP du serveur : 10.7.237.210

Nom DNS du domaine / de la forêt : boreal.local

Nom NetBIOS : BOREAL

Compte administrateur créé : User300153416 (membre de Domain Admins)

3. Étapes de vérification et commandes exécutées
Étape 1 : Vérification de la configuration du domaine et de la forêt
Exécution des cmdlets PowerShell permettant d'afficher les propriétés du domaine actif, les rôles FSMO ainsi que la structure de la forêt :

PowerShell
Get-ADDomain
Get-ADForest
Observation : Le serveur SRV300153416.boreal.local détient l'ensemble des rôles FSMO (PDCEmulator, RIDMaster, InfrastructureMaster, SchemaMaster, DomainNamingMaster) et le niveau fonctionnel est configuré sur Windows2016Domain / Windows2016Forest.

Étape 2 : Ouverture de la console d'administration graphique
Lancement de l'outil Active Directory Users and Computers depuis PowerShell :

PowerShell
Start-Process dsa.msc
Observation : La console graphique s'ouvre correctement et affiche l'arborescence complète du domaine boreal.local.

4. Preuves d'exécution (Captures d'écran)
Figure 1 : Résultat des commandes Get-ADDomain et Get-ADForest dans PowerShell. (Insérez ici votre capture d'écran PowerShell)

Figure 2 : Console graphique Active Directory Users and Computers (dsa.msc) affichant le domaine boreal.local. (Insérez ici votre capture d'écran de la console dsa.msc)

5. Conclusion
Le contrôleur de domaine SRV300153416.boreal.local est pleinement opérationnel. Les services AD DS et DNS fonctionnent comme prévu et l'administration des objets du domaine est accessible aussi bien en ligne de commande (PowerShell) que via l'interface graphique.
<img width="2040" height="1536" alt="GO1" src="https://github.com/user-attachments/assets/06f1a621-2c7e-44c0-99fa-417447f17dee" />
<img width="2040" height="1536" alt="GO2" src="https://github.com/user-attachments/assets/46bbe917-2a32-4cf6-bf62-b43ad12aaf04" />
<img width="2040" height="1536" alt="GO3" src="https://github.com/user-attachments/assets/3c9ed251-fe90-4893-9cd5-fd402f495329" />




