Rapport de laboratoire sur les services Windows et AD DS

Présentation du laboratoire
Ce laboratoire porte sur la gestion des services Active Directory dans Windows PowerShell exécuté en administrateur. J’ai créé et exécuté quatre scripts pour consulter les services, afficher leurs événements, exporter un journal et arrêter puis redémarrer DFSR. Les captures présentées dans ce rapport montrent les résultats obtenus.

Résultats obtenus
•	Les six services vérifiés étaient en cours d’exécution.
•	Les événements du journal Directory Service ont été affichés.
•	Le fichier ADLogs.csv a été créé dans C:\Logs.
•	DFSR a été arrêté puis redémarré avec succès.

Fichiers du laboratoire
services1.ps1, services2.ps1, services3.ps1 et services4.ps1 sont enregistrés dans C:\Users\Administrator. Le fichier exporté se trouve dans C:\Logs\ADLogs.csv.

 Partie 1 Vérification des services AD
Le script liste les services AD et vérifie ensuite NTDS, ADWS et DFSR. La capture montre que les six services ADWS, DFSR, IsmServ, KDC, Netlogon et NTDS sont dans l’état Running.

Script services1.ps1
Get-Service | Where-Object {
    $_.DisplayName -like "*Directory*" -or
    $_.Name -match "NTDS|ADWS|DFSR|kdc|Netlogon|IsmServ"
} | Sort-Object DisplayName
Get-Service -Name NTDS, ADWS, DFSR
Exécution : .\services1.ps1
 <img width="787" height="855" alt="image" src="https://github.com/user-attachments/assets/58042df7-cbae-4a63-b02c-69e14b6367e2" />

Capture du résultat obtenu dans Windows PowerShell

 Partie 2 Consultation des événements AD
Les événements AD sont affichés avec leur date, leur identifiant, leur niveau et leur message. Des événements Information et Avertissement sont visibles. Le filtre Netlogon cherche uniquement parmi les 20 derniers événements du système.

Script services2.ps1
Get-EventLog -LogName "Directory Service" -Newest 20
Get-EventLog -LogName "System" -Newest 20 |
    Where-Object {$_.Source -eq "Netlogon"}
Get-WinEvent -LogName "Directory Service" -MaxEvents 20 |
    Format-Table TimeCreated, Id, LevelDisplayName, Message -AutoSize
Exécution : .\services2.ps1
 <img width="754" height="855" alt="image" src="https://github.com/user-attachments/assets/a374ea9c-6292-4a0a-87d4-3dbc4916c34c" />

Capture du résultat obtenu dans Windows PowerShell

 Partie 3 Exportation des événements AD
Le dossier C:\Logs est créé au besoin. Le script exporte les 50 derniers événements AD. La commande Get-Item C:\Logs\ADLogs.csv confirme la présence du fichier et une taille de 42 498 octets.

Script services3.ps1
New-Item -Path "C:\Logs" -ItemType Directory -Force
Get-WinEvent -LogName "Directory Service" -MaxEvents 50 |
    Export-Csv -Path "C:\Logs\ADLogs.csv" -NoTypeInformation -Encoding UTF8
Exécution : .\services3.ps1
 <img width="771" height="855" alt="image" src="https://github.com/user-attachments/assets/145292c0-d266-4ed3-8b2f-dfffd1498cd6" />

Capture du résultat obtenu dans Windows PowerShell

 Partie 4 Arrêt et redémarrage de DFSR
La capture montre Stopped après l’arrêt de DFSR, puis Running après son démarrage. Le service est donc en cours d’exécution à la fin du test.

Script services4.ps1
Stop-Service -Name DFSR
(Get-Service -Name DFSR).Status
Start-Service -Name DFSR
(Get-Service -Name DFSR).Status
Exécution : .\services4.ps1
 <img width="758" height="855" alt="image" src="https://github.com/user-attachments/assets/e7faaf7f-21b8-44f3-a1cb-e8cf4ad45abf" />

Capture du résultat obtenu dans Windows PowerShell

Conclusion : les quatre scripts ont permis de réaliser les objectifs du laboratoire. J’ai consulté les services et les journaux AD, créé un export CSV et vérifié l’arrêt puis le redémarrage de DFSR.

