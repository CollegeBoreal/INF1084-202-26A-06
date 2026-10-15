# Gestion des services Active Directory avec PowerShell
# 300152004

Étape 1 – Créer les 4 scripts et lister les services AD 
<img width="3840" height="2877" alt="225547c6-30d0-4d3c-9def-288f2ce3d170" src="https://github.com/CollegeBoreal/INF1084-202-26A-06/blob/main/4.Services/300152004/images/01-creation-scripts-et-services1.jpeg?raw=true" />
Dans PowerShell (en Administrateur), on se place dans le dossier `Documents` et on crée les 4 fichiers vides :
powershell
cd C:\Users\Administrator\Documents
New-Item services1.ps1 -ItemType File
New-Item services2.ps1 -ItemType File
New-Item services3.ps1 -ItemType File
New-Item services4.ps1 -ItemType File

Étape 2 – Afficher les événements d'un service AD

Contenu de `services1.ps1` :
<img width="3840" height="2877" alt="225547c6-30d0-4d3c-9def-288f2ce3d170" src="https://github.com/CollegeBoreal/INF1084-202-26A-06/blob/main/4.Services/300152004/images/01-creation-scripts-et-services1.jpeg?raw=true" />
powershell
#Lister tous les services liés à AD
Get-Service | Where-Object {
    $_.DisplayName -like "*Directory*" -or $_.Name -match "NTDS|ADWS|DFSR|kdc|Netlogon|IsmServ"
} | Sort-Object DisplayName
#Vérifier l'état d'un service spécifique
Get-Service -Name NTDS, ADWS, DFSR
le premier bloc filtre les services dont le nom d'affichage contient « Directory » ou dont le nom correspond à NTDS, ADWS, DFSR, kdc, Netlogon ou IsmServ, puis les trie par nom d'affichage. Le second bloc affiche l'état de NTDS, ADWS et DFSR.

Contenu de `services2.ps1` :
<img width="3840" height="2877" alt="225547c6-30d0-4d3c-9def-288f2ce3d170" src="https://github.com/CollegeBoreal/INF1084-202-26A-06/blob/main/4.Services/300152004/images/02-evenements-services2.jpeg?raw=true" />
powershell
#Afficher les 20 derniers événements liés à NTDS
Get-EventLog -LogName "Directory Service" -Newest 20
#Afficher les logs du système
Get-EventLog -LogName "System" -Newest 20 | Where-Object {$_.Source -eq "Netlogon"}
#Afficher les logs via le journal moderne (Event Viewer v2)
Get-WinEvent -LogName "Directory Service" -MaxEvents 20 | Format-Table TimeCreated, Id, LevelDisplayName, Message -AutoSize
la commande affiche les 20 derniers événements du journal Directory Service (source NTDS : *General* et *ISAM*), puis les événements système de la source Netlogon. La dernière commande présente les mêmes événements avec `Get-WinEvent`, sous forme de tableau

Contenu de `services3.ps1` :
<img width="3840" height="2877" alt="225547c6-30d0-4d3c-9def-288f2ce3d170" src="https://github.com/CollegeBoreal/INF1084-202-26A-06/blob/main/4.Services/300152004/images/03-export-csv-et-arret-redemarrage.jpeg?raw=true" />
powershell
Get-WinEvent -LogName "Directory Service" -MaxEvents 50 | Export-Csv -Path "C:\Logs\ADLogs.csv" -NoTypeInformation
Test-Path C:\Logs\ADLogs.csv

les 50 derniers événements du journal sont exportés dans `C:\Logs\ADLogs.csv`. Le dossier `C:\Logs` doit exister.
Le résultat est True, donc le fichier a bien été créé.

Contenu de `services4.ps1` :
<img width="3840" height="2877" alt="225547c6-30d0-4d3c-9def-288f2ce3d170" src="https://github.com/CollegeBoreal/INF1084-202-26A-06/blob/main/4.Services/300152004/images/03-export-csv-et-arret-redemarrage.jpeg?raw=true" />
powershell
Stop-Service -Name DFSR
(Get-Service -name DFSR).status
Start-Service -Name DFSR

le service DFSR (DFS Replication) est arrêté. La ligne `Stopped` confirme son état, puis il est redémarré.






