

INF1084 – Administration Windows

TP04 – Les services Windows et AD DS

Nom et prénom : Bouzidi Ouahiba

Matricule : 300157606

Date : 24 novembre 2026

Serveur : SRV300157606

Domaine : DC300157606.local


INTRODUCTION

	Dans ce travail pratique, j’utilise Windows PowerShell en mode administrateur pour identifier les services Active Directory, consulter et exporter les journaux d’événements, vérifier les dépendances et effectuer un arrêt suivi d’un redémarrage du service DFSR.

PARTIE 1 – Préparation et identification des services

Capture 1 – Préparation du serveur

<img width="2000" height="1500" alt="1" src="https://github.com/user-attachments/assets/33cae675-be9f-45fe-9bcb-d2163c1d903b" />

Je vérifie le nom du serveur avec hostname et l’état du service NTDS avec Get-Service -Name NTDS. Le service est Running. Je crée ensuite le dossier C:\TP04 avec mkdir C:\TP04 et je m’y déplace avec cd C:\TP04.



Capture 2 – Création du premier script

<img width="2000" height="1500" alt="2" src="https://github.com/user-attachments/assets/17daeeed-4307-4421-95d9-a0b316ef69fd" />

J’ouvre le Bloc-notes avec notepad services1.ps1 pour préparer le script de vérification des services.


Capture 3 – Contenu du script services1.ps1

<img width="2000" height="1500" alt="3" src="https://github.com/user-attachments/assets/e45abc3d-b4b9-47ae-a0a5-b596d568941c" />

Je vérifie le contenu du script avec cat .\services1.ps1.

Get-Service | Where-Object {
    $_.DisplayName -like "*Directory*" -or $_.Name -match "NTDS|ADWS|DFSR|kdc|Netlogon|IsmServ"
} | Sort-Object DisplayName
Get-Service -Name NTDS, ADWS, DFSR

Ce script filtre les services liés à Active Directory, les trie et vérifie trois services particuliers.


Capture 4 – Exécution du premier script

<img width="2000" height="1500" alt="4" src="https://github.com/user-attachments/assets/2d550443-40a8-4be6-925c-f2d6d4a0e9ef" />

J’exécute .\services1.ps1. Les six services NTDS, ADWS, DFSR, IsmServ, KDC et Netlogon sont en cours d’exécution (Running). Les trois services vérifiés séparément apparaissent une deuxième fois.


PARTIE 2 – Consultation des journaux

Capture 5 – Création du deuxième script

<img width="2000" height="1500" alt="5" src="https://github.com/user-attachments/assets/0d6f6751-48e4-4b33-b4df-57ba7f3f14ac" />


J’utilise notepad services2.ps1 pour préparer le script de consultation des événements.

Capture 6 – Contenu du script services2.ps1

<img width="2000" height="1500" alt="6" src="https://github.com/user-attachments/assets/2a52b986-0f5f-455e-bbac-32e38858db1f" />

Je vérifie le script avec cat .\services2.ps1.

Get-EventLog -LogName "Directory Service" -Newest 20
Get-EventLog -LogName "System" -Newest 20 | Where-Object {$_.Source -eq "Netlogon"}
Get-WinEvent -LogName "Directory Service" -MaxEvents 20 | Format-Table TimeCreated, Id, LevelDisplayName, Message -AutoSize

Ces commandes consultent les événements récents de l’annuaire, filtrent les 20 derniers événements système pour Netlogon et présentent les événements de l’annuaire sous forme de tableau.


Capture 7 – Exécution du deuxième script

<img width="2000" height="1500" alt="7" src="https://github.com/user-attachments/assets/3874d5a8-db62-4cae-929d-e9712715def3" />


J’exécute .\services2.ps1. Les résultats montrent des événements Information et Warning, notamment des opérations de maintenance de la base Active Directory et des avertissements de sécurité. Ces avertissements méritent une analyse complémentaire. Aucun résultat Netlogon distinct n’est visible sur cette photo.


PARTIE 3 – Exportation des journaux

Capture 8 – Préparation du troisième script

<img width="2000" height="1500" alt="8" src="https://github.com/user-attachments/assets/3cbc5aa9-0c3f-4297-9506-e8a47f2e2c11" />

Le dossier C:\Logs est présent. J’ouvre le Bloc-notes avec notepad services3.ps1.


Capture 9 – Contenu du script services3.ps1

<img width="2000" height="1500" alt="9" src="https://github.com/user-attachments/assets/ea9b40b8-3b9b-4ff9-874d-00403cc8c2c2" />

Je vérifie le script avec cat .\services3.ps1.

Get-WinEvent -LogName "Directory Service" -MaxEvents 50 | Export-Csv -Path "C:\Logs\ADLogs.csv" -NoTypeInformation

Cette commande exporte jusqu’à 50 événements récents dans un fichier CSV.


Capture 10 – Vérification du fichier CSV

<img width="2000" height="1500" alt="10" src="https://github.com/user-attachments/assets/f884f2d3-6e25-4d90-9d9e-5a08067b9d65" />

J’exécute .\services3.ps1 puis dir C:\Logs. Le fichier ADLogs.csv apparaît avec une taille de 39941 octets, ce qui confirme sa création.


Capture 11 – Consultation du fichier CSV

<img width="2000" height="1500" alt="11" src="https://github.com/user-attachments/assets/407dad65-5f08-4bd7-9f91-e7f5f6935616" />


J’ouvre le fichier avec notepad C:\Logs\ADLogs.csv. Je constate qu’il contient les messages, identifiants et autres propriétés des événements Active Directory.

PARTIE 4 – Dépendances et gestion du service DFSR

Capture 12 – Vérification des dépendances

<img width="2000" height="1500" alt="12" src="https://github.com/user-attachments/assets/0c652431-2d25-4e31-8926-40206e10695b" />


Get-Service -Name DFSR -DependentServices
Get-Service -Name DFSR -RequiredServices

La première commande ne retourne aucun service dépendant visible.
La seconde affiche EventSystem, RpcSs et NTDS, tous à l’état Running. Ces services sont nécessaires à DFSR.

Capture 13 – Création du quatrième script

<img width="2000" height="1500" alt="13" src="https://github.com/user-attachments/assets/2f462444-c299-4d39-9f6d-cd172aa42efa" />

J’ouvre notepad services4.ps1 pour préparer un arrêt et un redémarrage contrôlés de DFSR dans le cadre du laboratoire.

Capture 14 – Contenu du script services4.ps1

<img width="2000" height="1500" alt="14" src="https://github.com/user-attachments/assets/8953de05-3745-4d9b-b60f-c4968dbb0a97" />


Je vérifie le script avec cat .\services4.ps1.

Stop-Service -Name DFSR
(Get-Service -name DFSR).status
Start-Service -Name DFSR

Le script arrête DFSR, affiche son état, puis le remet en marche.


Capture 15 – Exécution et vérification du service

<img width="2000" height="1500" alt="15" src="https://github.com/user-attachments/assets/17ff0cfb-eba5-46f4-9e9a-3ba997aac26b" />

J’exécute .\services4.ps1. Le résultat Stopped confirme l’arrêt. Ensuite, Get-Service -Name DFSR affiche Running, ce qui confirme sa remise en marche.


PARTIE 5 – Vérification finale

Capture 16 – Vérification des scripts

<img width="2000" height="1500" alt="16" src="https://github.com/user-attachments/assets/7156aa28-2007-4b93-b74a-917d832881f1" />

Avec dir C:\TP04, je confirme la présence des quatre fichiers services1.ps1, services2.ps1, services3.ps1 et services4.ps1.


Capture 17 – Vérification finale des services

<img width="2000" height="1500" alt="17" src="https://github.com/user-attachments/assets/b7cf6613-3693-451c-8f66-27cd901e4e1c" />

Get-Service -Name NTDS, ADWS, DFSR, KDC, Netlogon, IsmServ
Les six services sont à l’état Running à la fin du TP.


CONCLUSION

	Ce travail pratique m’a permis de mieux comprendre la gestion des services Windows associés à Active Directory avec PowerShell. J’ai créé quatre scripts, consulté les journaux, exporté des événements au format CSV et vérifié les dépendances du service DFSR avant de l’arrêter et de le redémarrer. La vérification finale confirme que les six services contrôlés sont en cours d’exécution. Les avertissements relevés dans les journaux restent à examiner pour évaluer la sécurité du serveur.
