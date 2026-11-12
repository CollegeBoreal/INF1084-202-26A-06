Laboratoire PowerShell Active Directory
Objectif 1 : Lister les services AD et leur état

Dans ce laboratoire, j'ai créé le script services1.ps1 afin d'afficher les services liés à Active Directory. J'ai utilisé la commande Get-Service pour rechercher les services importants comme NTDS, ADWS, DFSR, KDC et Netlogon. Le script permet également de vérifier leur état (Running ou Stopped).

<img width="1536" height="2048" alt="image" src="https://github.com/user-attachments/assets/d49e47ce-52dd-45c3-b97a-df939731173e" />
<img width="1536" height="2048" alt="image" src="https://github.com/user-attachments/assets/30bb1b6a-712a-4b57-a483-9eb5c6e72093" />

Objectif 2 : Afficher les événements d'un service AD

J'ai créé le script services2.ps1 pour consulter les événements enregistrés par Active Directory. À l'aide des commandes Get-EventLog et Get-WinEvent, j'ai affiché les derniers événements du journal Directory Service ainsi que les événements liés au service Netlogon. Cette étape permet de surveiller le fonctionnement des services AD et d'identifier d'éventuels problèmes.

<img width="1536" height="2048" alt="image" src="https://github.com/user-attachments/assets/8a000dd5-71f0-4e1e-b493-fa85ba7a74a3" />
<img width="1536" height="2048" alt="image" src="https://github.com/user-attachments/assets/04774606-68dc-4d6f-b026-c273c4a5a03f" />



Objectif 3 : Capturer les événements dans un fichier

Pour cette partie, j'ai utilisé le script services3.ps1. Les cinquante derniers événements du journal « Directory Service » ont été exportés dans le fichier C:\Logs\ADLogs.csv grâce à la commande Export-Csv. Cette technique permet de conserver une trace des événements et de les analyser ultérieurement.

<img width="1536" height="2048" alt="image" src="https://github.com/user-attachments/assets/c20c5801-cdc4-473d-bba2-c9cd95ac9784" />


Objectif 4 : Arrêter et redémarrer un service

Le script services4.ps1 a servi à arrêter puis à redémarrer le service DFSR (Distributed File System Replication). J'ai utilisé les commandes Stop-Service et Start-Service puis vérifié l'état du service avec Get-Service. Cette étape démontre la capacité à administrer et contrôler les services Active Directory à l'aide de PowerShell.


<img width="1536" height="2048" alt="image" src="https://github.com/user-attachments/assets/03f625fe-3265-419d-9f51-5b6542c44339" />

Conclusion

Ce laboratoire m'a permis de me familiariser avec l'administration d'Active Directory à l'aide de PowerShell. J'ai appris à identifier les principaux services AD, consulter les journaux d'événements, exporter les résultats dans un fichier CSV et gérer le démarrage ou l'arrêt d'un service. Ces compétences sont essentielles pour la surveillance et le dépannage d'un environnement Windows Server.



