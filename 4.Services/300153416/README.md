Rapport de Laboratoire : Gestion et Surveillance des Services Active Directory (TP 4)   
1. Objectif du laboratoire   
L'objectif de ce TP est d'explorer, surveiller, consigner et gérer les services critiques d'Active Directory (NTDS, ADWS, DFSR, kdc, Netlogon, IsmServ) sous Windows Server 2022 à l'aide de scripts PowerShell.   

2. Environnement de travail   
Contrôleur de domaine : SRV300153416.boreal.local (10.7.237.210)   

Dossier des scripts :    C:\Scripts

Dossier des journaux : C:\Logs

3. Réalisation et Scripts PowerShell
Script 1 (services1.ps1) : Liste et état des services AD
Permet d'identifier et d'afficher l'état de tous les services liés à Active Directory.

PowerShell
Get-Service | Where-Object { $_.DisplayName -like "*Directory*" -or $_.Name -match "NTDS|ADWS|DFSR|kdc|Netlogon|IsmServ" } | Sort-Object DisplayName
Get-Service -Name NTDS, ADWS, DFSR
Script 2 (services2.ps1) : Consultation des journaux d'événements (Event Logs)   
Affiche les derniers événements des journaux Directory Service et System (liés à Netlogon et NTDS).   

PowerShell
Get-EventLog -LogName "Directory Service" -Newest 20
Get-EventLog -LogName "System" -Newest 20 | Where-Object {$_.Source -eq "Netlogon"}
Get-WinEvent -LogName "Directory Service" -MaxEvents 20 | Format-Table TimeCreated, Id, LevelDisplayName, Message -AutoSize
Script 3 (services3.ps1) : Exportation des logs vers un fichier CSV
Capture et sauvegarde les 50 derniers événements du service d'annuaire dans un fichier CSV pour analyse.

PowerShell
Get-WinEvent -LogName "Directory Service" -MaxEvents 50 | Export-Csv -Path "C:\Logs\ADLogs.csv" -NoTypeInformation
Script 4 (services4.ps1) : Arrêt et redémarrage d'un service critique (DFSR)
Teste l'arrêt, la vérification de l'état, puis le redémarrage de la réplication SYSVOL.

PowerShell
Stop-Service -Name DFSR
(Get-Service -name DFSR).status
Start-Service -Name DFSR
4. Conclusion   
Tous les scripts ont été exécutés avec succès. La surveillance de l'état des services et l'analyse des journaux d'événements confirment que l'infrastructure Active Directory sur le domaine boreal.local est stable et opérationnelle.  
<img width="2040" height="1536" alt="hu1" src="https://github.com/user-attachments/assets/c356a59a-f218-49d0-a5ee-77db84f79490" />
<img width="2040" height="1536" alt="hu2" src="https://github.com/user-attachments/assets/139d4922-8681-4f6f-bb76-d73771f4f079" />
<img width="1536" height="2040" alt="hu3" src="https://github.com/user-attachments/assets/d80a0576-f599-4a9d-aecc-79edc150ac92" />
<img width="1536" height="2040" alt="hu4" src="https://github.com/user-attachments/assets/0b96130f-8e8c-49ea-83a5-51cea0e4cb7d" />
<img width="2040" height="1536" alt="hu5" src="https://github.com/user-attachments/assets/6479c500-2411-4ff3-8692-6276ce690b08" />






