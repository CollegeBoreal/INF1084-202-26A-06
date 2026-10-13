Laboratoire 4 – Gestion des services

Cours : INF1084 – Administration Windows Server
ID étudiant : 300147891
Système : Windows Server 2022 Datacenter
Adresse IP : 10.7.237.204

Objectif

L’objectif de ce laboratoire est d’utiliser PowerShell pour gérer et surveiller les services Active Directory sous Windows Server 2022.

1. Afficher les services Active Directory

J’ai créé le script services1.ps1 pour afficher les principaux services Active Directory et vérifier leur état.

Résultat : Les services NTDS, ADWS, DFSR, IsmServ, Kdc et Netlogon sont en état Running.

📸 Capture 1 : <img width="530" height="555" alt="image" src="https://github.com/user-attachments/assets/88d3710a-8488-4ff5-9e7b-f23b2ba7ec5e" />


2. Afficher les événements Active Directory

J’ai créé le script services2.ps1 pour consulter les 20 derniers événements du journal Directory Service.

Résultat : Les événements ont été affichés avec leur date, leur identifiant, leur niveau et leur message.

📸 Capture 2 : <img width="550" height="805" alt="image" src="https://github.com/user-attachments/assets/f809d995-9041-4cda-8fb3-e47ec9b8b645" />


3. Exporter les événements dans un fichier CSV

J’ai créé le script services3.ps1 pour exporter les 50 derniers événements Active Directory dans un fichier CSV.

Le fichier a été enregistré dans :

C:\Logs\ADLogs.csv

Résultat : Le fichier a été créé avec succès. Sa taille est de 39 660 octets.

📸 Capture 3 : <img width="748" height="623" alt="image" src="https://github.com/user-attachments/assets/64b66959-ebc3-46b7-bfbd-f17f7e0f8303" />


4. Arrêter et redémarrer le service DFSR

J’ai créé le script services4.ps1 pour arrêter et redémarrer le service DFSR.

Résultat :

* Après l’arrêt : Stopped
* Après le redémarrage : Running

Le service DFSR a été arrêté puis redémarré correctement.

📸 Capture 4 : Arrêt et redémarrage du service DFSR.

Conclusion

Ce laboratoire m’a permis d’apprendre à utiliser PowerShell pour administrer les services Active Directory sous Windows Server 2022.

J’ai réussi à afficher les services, consulter les événements, exporter les journaux dans un fichier CSV et gérer le service DFSR.

Les quatre scripts ont été exécutés avec succès.
