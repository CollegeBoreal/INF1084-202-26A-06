Vérification des services Active Directory :


Exécution du script services1.ps1 dans PowerShell. Le résultat affiche les principaux services Active Directory comme NTDS, ADWS, DFSR, KDC, Netlogon et IsmServ avec leur état Running.


<img width="1347" height="915" alt="image" src="https://github.com/user-attachments/assets/72f22b5c-76e1-4dcb-86f7-75782c47af99" />


Création du script services1.ps1 :


Création du fichier services1.ps1 dans Bloc-notes. Ce script permet de lister les services liés à Active Directory et de vérifier l’état des services NTDS, ADWS et DFSR.


<img width="1636" height="1058" alt="image" src="https://github.com/user-attachments/assets/91c5e63e-2158-4746-b6c0-40dd890bb641" />


Création du script services2.ps1 :


Création du fichier services2.ps1. Le script permet d’afficher les derniers événements du journal Directory Service, les événements Netlogon et les informations détaillées des journaux Active Directory.


<img width="1787" height="1051" alt="image" src="https://github.com/user-attachments/assets/382dc7a5-f0e8-44e9-a268-9ac99b5436f5" />


Consultation des événements Active Directory :


Exécution du script services2.ps1 dans PowerShell. Les événements Active Directory sont affichés avec la date, l’identifiant de l’événement, le niveau d’information et le message associé.


<img width="1626" height="1070" alt="image" src="https://github.com/user-attachments/assets/9ed58cc3-d300-488a-83a0-44afffce42bd" />


Création du script services3.ps1 :


Création du fichier services3.ps1. Ce script récupère les 50 derniers événements du journal Directory Service et les exporte dans le fichier ADLogs.csv.


<img width="1759" height="1080" alt="image" src="https://github.com/user-attachments/assets/fb3f21d7-2d3c-4e97-80ab-c1bd5ed84669" />


Exportation des journaux dans un fichier CSV :


Exécution du script services3.ps1 et vérification du dossier C:\Logs. Le fichier ADLogs.csv a été créé correctement avec les événements Active Directory exportés.


<img width="1569" height="1053" alt="image" src="https://github.com/user-attachments/assets/85f277b0-c856-494b-8398-957c22c893b4" />


Création du script services4.ps1 :


Création du fichier services4.ps1. Ce script arrête temporairement le service DFSR, vérifie son état, puis redémarre le service.


<img width="1817" height="1064" alt="image" src="https://github.com/user-attachments/assets/6e37fc96-108b-4a2f-b595-332a2881f534" />


Arrêt et redémarrage du service DFSR :

Exécution du script services4.ps1. Le service DFSR passe d’abord à l’état Stopped, puis il est redémarré. La commande Get-Service -Name DFSR confirme que son état final est Running.


<img width="1215" height="1048" alt="image" src="https://github.com/user-attachments/assets/c0cc164c-da25-4fdb-add8-7a9cfcca2e0e" />

