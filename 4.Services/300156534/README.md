1. Objectif du laboratoire

L’objectif de ce laboratoire est d’explorer les principaux services Windows liés à Active Directory Domain Services (AD DS), de vérifier leur état, de consulter les événements du service Active Directory, d’exporter les journaux dans un fichier CSV et de tester l’arrêt puis le redémarrage du service DFSR.
<img width="684" height="715" alt="image" src="https://github.com/user-attachments/assets/fcab0ba2-8bd3-4341-815b-024624ed01ba" />

2. Environnement de travail

Les manipulations ont été réalisées sur un serveur Windows Server avec le rôle Active Directory Domain Services installé. Les commandes ont été exécutées dans Windows PowerShell avec les droits d’administrateur.

3. Services Active Directory vérifiés

NTDS — Active Directory Domain Services

Service principal d’Active Directory. Il gère la base de données et les objets du domaine.

ADWS — Active Directory Web Services

Permet aux outils d’administration de communiquer avec Active Directory.

DFSR — DFS Replication

Assure notamment la réplication de SYSVOL entre les contrôleurs de domaine.

KDC — Kerberos Key Distribution Center

Fournit les tickets Kerberos nécessaires à l’authentification.

Netlogon

Participe à l’authentification et à la localisation des contrôleurs de domaine.

IsmServ — Intersite Messaging

Participe à la communication et à la réplication entre les sites Active Directory.

4. Réalisation du laboratoire

4.1 — services1.ps1

Le premier script permet de lister les services liés à Active Directory et de vérifier leur état. Les services NTDS, ADWS, DFSR, IsmServ, KDC et Netlogon sont présents et fonctionnent tous avec l’état « Running ».

La capture montre l’exécution du script et la présence des six services AD principaux.

4.2 — services2.ps1

Le deuxième script permet de consulter les événements du journal « Directory Service ». Les événements affichent notamment la date, l’identifiant, le niveau et le message. Les informations provenant de NTDS permettent de vérifier l’activité du service Active Directory.

La capture montre les événements NTDS obtenus avec PowerShell.

4.3 — services3.ps1

Le troisième script récupère les 50 derniers événements du journal « Directory Service » et les exporte dans le fichier C:\Logs\ADLogs.csv. Le dossier C:\Logs a été créé avant l’exportation.

La capture confirme que le fichier ADLogs.csv a été créé avec succès dans C:\Logs.

4.4 — services4.ps1

Le quatrième script arrête temporairement le service DFSR, vérifie son état, puis le redémarre. La sortie montre « Stopped » pendant le test et la vérification finale confirme que DFSR est de nouveau « Running ».

La capture confirme que DFSR fonctionne de nouveau après le redémarrage.

5. Captures d’écran

Capture 1 — Vérification initiale
<img width="699" height="725" alt="image" src="https://github.com/user-attachments/assets/7ca6b1fa-f525-42e7-a805-7be57787ed89" />

Cette première capture montre les premières commandes utilisées pour vérifier les services AD. Une faute de frappe dans le nom DFSR est ensuite corrigée.



Capture 2 — Services AD vérifiés
<img width="698" height="728" alt="image" src="https://github.com/user-attachments/assets/518da23a-398b-4025-895b-cbbca10d3a38" />

Après correction, les services AD demandés sont correctement identifiés sur le serveur.



Capture 3 — Création de services1.ps1
<img width="684" height="698" alt="image" src="https://github.com/user-attachments/assets/0463c7bf-becd-47c1-ade2-84b920d1f9ec" />

Le fichier services1.ps1 est créé dans C:\Users\Administrator et son contenu est vérifié.



Capture 4 — Exécution de services1.ps1
<img width="717" height="736" alt="image" src="https://github.com/user-attachments/assets/feec032a-8679-48c2-8297-f6c0dcfa7bbc" />

Le script affiche les six services AD et confirme leur fonctionnement.



Capture 5 — Exécution de services2.ps1
<img width="698" height="724" alt="image" src="https://github.com/user-attachments/assets/1607fc14-dfbd-4184-a9d7-c329cf241112" />

Les derniers événements du journal Directory Service sont affichés avec leurs informations.



Capture 6 — Exécution de services3.ps1
<img width="675" height="708" alt="image" src="https://github.com/user-attachments/assets/09031013-d7cf-4f24-ba93-a0f295739034" />

Le fichier ADLogs.csv est créé dans C:\Logs. La taille affichée est de 33 180 octets.



Capture 7 — Exécution de services4.ps1
<img width="695" height="737" alt="image" src="https://github.com/user-attachments/assets/29663432-3795-4f41-b18b-313a755f8d4f" />

DFSR est arrêté, puis redémarré. La vérification finale indique Running.



Capture 8 — Vérification finale
<img width="684" height="715" alt="image" src="https://github.com/user-attachments/assets/f10590d6-0da3-40ed-af58-9a1a41721a32" />

La commande Get-ChildItem .\services*.ps1 confirme la présence de services1.ps1, services2.ps1, services3.ps1 et services4.ps1.



6. Fichiers créés

Les quatre scripts PowerShell ont été créés dans C:\Users\Administrator :

services1.ps1

services2.ps1

services3.ps1

services4.ps1

Le fichier de journal exporté se trouve dans C:\Logs\ADLogs.csv.

7. Résultats

Les quatre parties du laboratoire ont été réalisées avec succès. Les services AD principaux ont été vérifiés, les événements Active Directory ont été consultés, les journaux ont été exportés dans un fichier CSV et le service DFSR a été arrêté puis redémarré. La vérification finale confirme que DFSR fonctionne correctement.

8. Conclusion

Ce laboratoire m’a permis de mieux comprendre les services Windows associés à Active Directory Domain Services. J’ai appris à vérifier l’état des services AD, à consulter les journaux d’événements avec PowerShell, à exporter des événements dans un fichier CSV et à gérer le service DFSR. Les résultats obtenus confirment que les services et les scripts fonctionnent correcte
