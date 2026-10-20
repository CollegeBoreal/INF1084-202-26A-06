TP – Active Directory : Partage de ressources et GPO
Amadou BARRY
ID 300147891
1. Objectif du laboratoire

L’objectif de ce travail est de créer un dossier partagé sur Windows Server 2022, de gérer les autorisations d’accès avec Active Directory et de configurer une stratégie de groupe (GPO) permettant aux étudiants d’accéder au dossier partagé.

2. Création du dossier partagé

J’ai créé un dossier nommé SharedResources sur le serveur Windows Server 2022.

Chemin du dossier :
C:\SharedResources

Commande de vérification : Get-SmbShare -Name 'SharedResources'
<img width="994" height="160" alt="image" src="https://github.com/user-attachments/assets/d6be0e9a-7a48-4e8f-a702-2a2f56028203" />

Configuration des autorisations

J’ai configuré les autorisations du groupe Students afin de permettre aux étudiants d’accéder aux ressources partagées.

Commande : Get-SmbShareAccess -Name 'SharedResources'
Résultat le group students possède l'autorisation change, j'ai également configuré les permissions NTFS avec la commande :
icacls C:\SharedResources /grant "DC300147891\Students:(OI)(CI)M"
<img width="1074" height="881" alt="image" src="https://github.com/user-attachments/assets/8557b000-94c3-4c64-9500-1c3356423d42" />

4 Création de la stratégie de groupe
Avec la commande : New-GPO -Name 'MapsSharedFolder' j'ai créé le groupe. Ensuite j'ai lié cette GPO à l'unité organisationnelle Students avec la commande 
New-GPLink -Name "MapSharedFolder" -Target "OU=Students,DC=DC300147891,DC=local"

<img width="985" height="671" alt="image" src="https://github.com/user-attachments/assets/fff1b6a2-ca5b-4497-891d-4f0732323b98" />

5 Configuration du lecteur réseau Z:
J'ai suivi les étapes dans Group policy Management
<img width="2048" height="1152" alt="image" src="https://github.com/user-attachments/assets/c8a3fcd5-e1f1-434d-818e-09efdf48547e" />
<img width="1259" height="875" alt="image" src="https://github.com/user-attachments/assets/cbc018e0-b557-406f-a62a-cb0c35e661ae" />

6 




