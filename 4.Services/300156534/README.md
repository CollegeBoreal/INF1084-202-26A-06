LABORATOIRE 4
Gestion des services Windows
et Active Directory


Windows Server 2022 • PowerShell • Active Directory Domain Services

 1. Objectif du laboratoire
L’objectif de ce laboratoire est d’explorer les principaux services Windows liés à Active Directory Domain Services (AD DS), de vérifier leur état, de consulter les événements du service Active Directory, d’exporter les journaux dans un fichier CSV et de tester l’arrêt puis le redémarrage du service DFSR.
2. Environnement de travail
•	Système d’exploitation : Windows Server 2022
•	Rôle du serveur : contrôleur de domaine Active Directory
•	Outil : Windows PowerShell exécuté en tant qu’administrateur
•	Dossier des scripts sur le serveur : C:\Users\Administrator
•	Dossier d’exportation : C:\Logs
•	Fichier d’exportation : C:\Logs\ADLogs.csv
3. Services Active Directory vérifiés
4. Réalisation du laboratoire
4.1 — services1.ps1 : vérification des services
Le premier script liste les services associés à Active Directory et vérifie leur état.
Commande exécutée :
.\services1.ps1
Résultat observé : les six services NTDS, ADWS, DFSR, KDC, Netlogon et IsmServ apparaissent en état Running dans la capture.
 
Capture 1 — Vérification des services Active Directory
<img width="930" height="977" alt="image" src="https://github.com/user-attachments/assets/1caf8922-30a8-483e-816a-9b0870b46b82" />

4.2 — services2.ps1 : consultation des journaux
Le deuxième script consulte le journal Directory Service, recherche les événements Netlogon dans le journal System et affiche des événements récents associés à NTDS.
Commande exécutée :
.\services2.ps1
Résultat observé : PowerShell affiche les événements avec leur date, leur identifiant, leur niveau et leur message. La capture montre notamment des événements NTDS de type Information ainsi que des événements de niveau Warning.
 
Capture 2 — Consultation des journaux Windows
<img width="930" height="978" alt="image" src="https://github.com/user-attachments/assets/0838354c-cbc1-4f7b-bc3f-978c3868b028" />

4.3 — services3.ps1 : exportation vers un fichier CSV
Le troisième script vérifie l’existence du dossier C:\Logs et le crée si nécessaire. Il exporte ensuite les 50 derniers événements du journal Directory Service vers C:\Logs\ADLogs.csv.
Commande exécutée :
.\services3.ps1
Commandes de vérification :
Get-Item C:\Logs\ADLogs.csv
Import-Csv C:\Logs\ADLogs.csv | Select-Object -First 5
Résultat observé : le fichier ADLogs.csv a été créé dans C:\Logs. La capture montre une taille de 10 781 octets au moment de la vérification.
 
Capture 3 — Exportation des événements au format CSV
<img width="930" height="983" alt="image" src="https://github.com/user-attachments/assets/4dbb3e1d-cd11-488e-ad6e-da7c471e2137" />

4.4 — services4.ps1 : arrêt et redémarrage de DFSR
Le quatrième script arrête temporairement le service DFSR, vérifie son état, le redémarre puis effectue une dernière vérification.
Commande exécutée :
.\services4.ps1
Résultats observés pendant le test : état initial Running, état après l’arrêt Stopped et état après le redémarrage Running. La capture confirme que le service fonctionne de nouveau.
 
Capture 4 — Arrêt et redémarrage du service DFSR
<img width="930" height="984" alt="image" src="https://github.com/user-attachments/assets/5b414fc2-b4b4-4071-b014-2693b69bd3ca" />

5. Vérification des fichiers créés
Les quatre scripts PowerShell sont présents dans C:\Users\Administrator.
Get-ChildItem C:\Users\Administrator\services*.ps1
 
Capture 5 — Présence des quatre scripts PowerShell
<img width="930" height="1045" alt="image" src="https://github.com/user-attachments/assets/d750fe94-3d66-4c47-9a0c-d017838c9e97" />

Une vérification supplémentaire confirme que DFSR est en état Running après son redémarrage.
Get-Service -Name DFSR
 
Capture 6 — Vérification finale du service DFSR
<img width="930" height="1076" alt="image" src="https://github.com/user-attachments/assets/47b0c707-1635-437d-b9f5-a7632c43ac62" />

6. Fichiers du laboratoire
Le dossier du laboratoire contient le rapport README.md, les quatre scripts PowerShell et le dossier images avec les captures d’écran utilisées dans ce rapport. Le fichier ADLogs.csv est généré sur le serveur dans C:\Logs.
•	services1.ps1
•	services2.ps1
•	services3.ps1
•	services4.ps1
•	README.md
•	images/ (six captures d’écran)
7. Résultats
Les quatre parties du laboratoire ont été réalisées sur le serveur de laboratoire : les services Active Directory ont été vérifiés, les journaux ont été consultés, les événements ont été exportés au format CSV et le service DFSR a été arrêté puis redémarré. La vérification finale indique que DFSR est de nouveau en état Running.
8. Conclusion
Ce laboratoire m’a permis de mieux comprendre les services Windows associés à Active Directory Domain Services. J’ai appris à vérifier l’état des services AD, à consulter les journaux d’événements avec PowerShell, à exporter des événements dans un fichier CSV et à gérer le service DFSR. Les captures d’écran montrent les principales étapes et les résultats observés sur le serveur.

 
 
