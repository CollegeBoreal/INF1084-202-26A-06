

<img width="2048" height="1153" alt="001" src="https://github.com/user-attachments/assets/10be1122-9de9-4adb-87fe-93818934eceb" />



Capture 1 — Exécution de services1.ps1
Cette capture montre la création du dossier C:\LabServices et l’exécution du script services1.ps1. Le résultat affiche les principaux services Active Directory, notamment NTDS, ADWS, DFSR, IsmServ, KDC et Netlogon, avec l’état Running. Cela confirme que les services essentiels d’AD DS fonctionnent correctement sur le contrôleur de domaine.




<img width="2048" height="1153" alt="002" src="https://github.com/user-attachments/assets/af2a4bfd-2695-4aaf-9373-072c636569ef" />




Capture 2 — Exécution de services2.ps1
Cette capture montre le contenu et l’exécution du script services2.ps1. Le script consulte les journaux d’événements Active Directory et affiche les événements récents provenant notamment de NTDS General et NTDS ISAM. Cela permet de surveiller l’activité et de repérer d’éventuels avertissements ou problèmes liés à AD DS.






<img width="2048" height="1153" alt="003" src="https://github.com/user-attachments/assets/2137f87f-6dbf-456a-9d7c-489c2fc45c41" />





Capture 3 — Exécution de services3.ps1 et création du CSV
Cette capture montre la création du dossier C:\Logs, puis l’exécution du script services3.ps1. Les événements du journal Directory Service sont exportés dans le fichier C:\Logs\ADLogs.csv. La commande Get-Item confirme que le fichier ADLogs.csv a bien été créé.





<img width="2048" height="1153" alt="004" src="https://github.com/user-attachments/assets/c5f34732-cdb7-44f8-b56e-7f6dee5bd611" />





Capture 4 — Vérification du CSV et exécution de services4.ps1
Cette capture montre d’abord la lecture du fichier ADLogs.csv, confirmant que les événements Active Directory ont bien été enregistrés. Ensuite, le script services4.ps1 est exécuté : le service DFSR est arrêté puis redémarré. La vérification finale avec Get-Service -Name DFSR montre l’état Running, ce qui confirme que DFS Replication fonctionne de nouveau.





<img width="2048" height="1153" alt="005" src="https://github.com/user-attachments/assets/5ed40405-eb3a-4387-864a-e57cf364dd97" />






Capture 5 — Vérification des scripts et services AD
Cette capture montre la présence des quatre fichiers services1.ps1, services2.ps1, services3.ps1 et services4.ps1 dans le dossier C:\LabServices. Elle montre également la vérification de plusieurs services Active Directory, notamment ADWS, DFSR, IsmServ, KDC et Netlogon, qui sont tous à l’état Running.






<img width="2048" height="1153" alt="006" src="https://github.com/user-attachments/assets/cc6c1d4c-9622-42cf-a25d-9b7701f98396" />







Capture 6 — Vérification finale de NTDS et du fichier de logs
Cette dernière capture complète la vérification du laboratoire. Le service NTDS (Active Directory Domain Services) apparaît à l’état Running, ce qui confirme le fonctionnement du service principal d’Active Directory. La valeur True affichée à la fin confirme également que le fichier C:\Logs\ADLogs.csv existe bien.
