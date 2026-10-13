Étudiant : Hammiche Billal
Identifiant : 300159887
Environnement : Windows Server 2022
Dossier de travail : C:\LabAD
Date : 13 octobre 2026

Laboratoire PowerShell — Services Windows et Active Directory
 
1. Objectif du laboratoire
L’objectif de ce laboratoire est d’utiliser PowerShell pour examiner les services essentiels d’Active Directory, consulter les journaux d’événements, exporter les événements dans un fichier CSV et contrôler l’arrêt puis le redémarrage du service DFS Replication (DFSR).
2. Environnement et organisation
Système	Windows Server 2022
Identifiant étudiant	300159887
Dossier des scripts	C:\LabAD
Fichier d’exportation	C:\Logs\ADLogs.csv
Scripts réalisés	services1.ps1, services2.ps1, services3.ps1, services4.ps1
3. Étape 1 — Lister les services Active Directory
Le script services1.ps1 recherche les services associés à Active Directory à partir de leur nom ou de leur nom d’affichage. Il vérifie ensuite l’état de NTDS, ADWS et DFSR.
Commandes utilisées :
Get-Service | Where-Object {
    $_.DisplayName -like "*Directory*" -or $_.Name -match "NTDS|ADWS|DFSR|kdc|Netlogon|IsmServ"
} | Sort-Object DisplayName
<img width="677" height="487" alt="Capture d’écran 2026-10-13 121107" src="https://github.com/user-attachments/assets/da3de10a-e720-452e-bac6-52f4194a57a4" />


Get-Service -Name NTDS, ADWS, DFSR
Résultat : la capture montre les services NTDS, ADWS, DFSR, IsmServ, KDC et Netlogon à l’état Running. Les commandes ont donc permis d’identifier les services et de vérifier leur état.
 
Figure 1 — Exécution de services1.ps1 et vérification des services AD.
4. Étape 2 — Consulter les journaux d’événements
Le script services2.ps1 consulte le journal Directory Service et recherche également les événements du journal System dont la source est Netlogon. La commande Get-WinEvent affiche ensuite les derniers événements avec leur date, leur identifiant, leur niveau et leur message.
Commandes utilisées :
Get-EventLog -LogName "Directory Service" -Newest 20

Get-EventLog -LogName "System" -Newest 20 |
    Where-Object { $_.Source -eq "Netlogon" }

Get-WinEvent -LogName "Directory Service" -MaxEvents 20 |
    Format-Table TimeCreated, Id, LevelDisplayName, Message -AutoSize
Résultat : les événements du journal Directory Service s’affichent dans PowerShell. La capture montre notamment des événements NTDS General et NTDS ISAM. Un événement de niveau Warning doit être interprété à partir de son message complet; sa présence ne signifie pas automatiquement une panne.
 
Figure 2 — Consultation des événements Active Directory avec services2.ps1.
5. Étape 3 — Exporter les événements dans un fichier CSV
Le script services3.ps1 crée le dossier C:\Logs s’il n’existe pas, puis exporte les 50 derniers événements du journal Directory Service dans le fichier C:\Logs\ADLogs.csv.
Commandes utilisées :
New-Item -Path "C:\Logs" -ItemType Directory -Force
<img width="732" height="482" alt="Capture d’écran 2026-10-13 121400" src="https://github.com/user-attachments/assets/25cf2862-04c6-46c4-960e-8c00fa5845dd" />


Get-WinEvent -LogName "Directory Service" -MaxEvents 50 |
    Export-Csv -Path "C:\Logs\ADLogs.csv" -NoTypeInformation
Résultat : la commande Test-Path retourne True, ce qui confirme que le fichier CSV existe. La commande Import-Csv affiche les premières lignes du fichier et permet de vérifier que les événements ont été enregistrés.
 
Figure 3 — Vérification de l’existence et lecture du fichier ADLogs.csv.
6. Étape 4 — Arrêter et redémarrer DFSR
Le script services4.ps1 arrête le service DFSR, vérifie son état, le redémarre et vérifie une seconde fois son état. Cette opération a été réalisée dans le cadre du laboratoire.
<img width="752" height="456" alt="Capture d’écran 2026-10-13 121744" src="https://github.com/user-attachments/assets/1f1574ab-1e5c-4f5c-852e-899b3881ac4a" />

Commandes utilisées :
Stop-Service -Name DFSR
(Get-Service -Name DFSR).Status
Start-Service -Name DFSR
(Get-Service -Name DFSR).Status
Résultat : PowerShell affiche Stopped après l’arrêt, puis Running après le redémarrage. Le résultat confirme que le service a été arrêté puis remis en fonctionnement. L’arrêt de DFSR peut interrompre temporairement la réplication de SYSVOL; ce type de test doit donc être effectué uniquement dans un environnement de laboratoire autorisé.
<img width="755" height="497" alt="Capture d’écran 2026-10-13 122115" src="https://github.com/user-attachments/assets/53172cd6-55ab-4152-a8ef-4454ad7ef43e" />

 
Figure 4 — États du service DFSR et vérification finale des fichiers.
7. Vérification finale
La commande Get-ChildItem C:\LabAD\services*.ps1 a affiché les quatre scripts attendus. La commande Test-Path C:\Logs\ADLogs.csv a retourné True. Les captures d’écran documentent les résultats obtenus pour chacune des quatre étapes.
8. Conclusion
Ce laboratoire m’a permis de pratiquer l’utilisation de PowerShell pour surveiller les services Windows liés à Active Directory, consulter les journaux d’événements, sauvegarder les événements dans un fichier CSV et gérer le service DFSR. Les quatre scripts ont été créés et exécutés. Les vérifications finales confirment leur présence dans C:\LabAD ainsi que l’existence du fichier C:\Logs\ADLogs.csv. Le service DFSR a également été redémarré avec succès.

