# Laboratoire 4 - Gestion des services Active Directory

**Nom :** Touadjni Islem  
**ID :** 300159195  

## Objectif

Ce laboratoire a pour objectif d’explorer et de gérer les principaux services liés à **Active Directory Domain Services (AD DS)** sur Windows Server 2022 à l’aide de PowerShell.

Les tâches réalisées sont :

- lister les services Active Directory et vérifier leur état ;
- consulter les événements liés à Active Directory ;
- exporter les événements dans un fichier CSV ;
- arrêter puis redémarrer le service DFS Replication et vérifier son état.

Le travail a été réalisé sur le contrôleur de domaine configuré précédemment.

---

## 1. Lister les services Active Directory

Un premier script PowerShell nommé `services1.ps1` a été créé dans le dossier :

```text
C:\ServicesLab
```

### Script `services1.ps1`

```powershell
# Lister tous les services liés à AD
Get-Service | Where-Object {
    $PSItem.DisplayName -like "*Directory*" -or $PSItem.Name -match "NTDS|ADWS|DFSR|kdc|Netlogon|IsmServ"
} | Sort-Object DisplayName

# Vérifier l'état de services spécifiques
Get-Service -Name NTDS, ADWS, DFSR
```

> `$PSItem` est équivalent à `$_` dans PowerShell.

Le script a ensuite été exécuté avec :

```powershell
.\services1.ps1
```

<img width="1152" height="1536" alt="image" src="https://github.com/user-attachments/assets/0cb473b9-05db-49ca-a17f-5178102b2023" />

### Résultat

Les principaux services Active Directory sont détectés et fonctionnent :

- `NTDS` : Active Directory Domain Services
- `ADWS` : Active Directory Web Services
- `DFSR` : DFS Replication
- `IsmServ` : Intersite Messaging
- `Kdc` : Kerberos Key Distribution Center
- `Netlogon` : Netlogon

Les services vérifiés sont en état **Running**.

---

## 2. Consulter les événements Active Directory

Le deuxième script, `services2.ps1`, permet de consulter les événements du journal **Directory Service** ainsi que les événements liés à Netlogon.

### Script `services2.ps1`

```powershell
# Afficher les 20 derniers événements liés à NTDS
Get-EventLog -LogName "Directory Service" -Newest 20

# Afficher les logs du système liés à Netlogon
Get-EventLog -LogName "System" -Newest 20 | Where-Object {
    $PSItem.Source -eq "Netlogon"
}

# Afficher les logs via le journal moderne
Get-WinEvent -LogName "Directory Service" -MaxEvents 20 |
Format-Table TimeCreated, Id, LevelDisplayName, Message -AutoSize
```

Le script a été lancé avec :

```powershell
.\services2.ps1
```

<img width="1536" height="1152" alt="image" src="https://github.com/user-attachments/assets/cc5d6280-a8da-4848-83a7-b4a351f8ea90" />

### Résultat

PowerShell affiche les événements récents du service Active Directory avec plusieurs informations utiles :

- date et heure ;
- identifiant de l’événement ;
- niveau de l’événement ;
- source ;
- message associé.

Cette vérification permet de surveiller le fonctionnement du contrôleur de domaine et d’identifier d’éventuels avertissements ou erreurs.

---

## 3. Exporter les événements Active Directory en CSV

Un dossier destiné aux journaux a d’abord été créé :

```powershell
mkdir C:\Logs
```

Le script `services3.ps1` a ensuite été créé.

### Script `services3.ps1`

```powershell
Get-WinEvent -LogName "Directory Service" -MaxEvents 50 |
Export-Csv -Path "C:\Logs\ADLogs.csv" -NoTypeInformation
```

Le script a été exécuté avec :

```powershell
.\services3.ps1
```

Pour vérifier la création du fichier :

```powershell
dir C:\Logs
```

<img width="1536" height="1152" alt="image" src="https://github.com/user-attachments/assets/71f8ce40-df62-4227-8954-882c9147c466" />

### Résultat

Le fichier suivant a été créé avec succès :

```text
C:\Logs\ADLogs.csv
```

Il contient les 50 derniers événements du journal **Directory Service**.

Le fichier a également été ouvert afin de vérifier son contenu.

<img width="1536" height="1152" alt="image" src="https://github.com/user-attachments/assets/658919c7-e61b-4770-a95c-c00c3586b979" />

Le fichier contient notamment les champs suivants :

```text
Message
Id
Level
ProviderName
LogName
TimeCreated
```

Cela permet de conserver les événements Active Directory dans un format exploitable pour une analyse ultérieure.

---

## 4. Arrêter et redémarrer le service DFS Replication

Le dernier script, `services4.ps1`, permet de tester l’arrêt et le redémarrage du service **DFSR**.

### Script `services4.ps1`

```powershell
Stop-Service -Name DFSR
(Get-Service -Name DFSR).Status
Start-Service -Name DFSR
```

Le script a été exécuté avec :

```powershell
.\services4.ps1
```

Pendant l’exécution, l’état suivant est apparu :

```text
Stopped
```

Après le redémarrage du service, une vérification supplémentaire a été effectuée :

```powershell
Get-Service -Name DFSR
```

<img width="1536" height="1152" alt="image" src="https://github.com/user-attachments/assets/930a0c44-f8d2-4025-bcfc-8565a6648ca6" />

### Résultat

Le service DFS Replication a été arrêté temporairement puis redémarré correctement.

État final :

```text
Status   Name   DisplayName
------   ----   -----------
Running  DFSR   DFS Replication
```

Le service est donc revenu à son état normal après le test.

---

## 5. Scripts réalisés

Les quatre scripts utilisés dans le laboratoire sont :

```text
services1.ps1
services2.ps1
services3.ps1
services4.ps1
```

Ils permettent respectivement de :

1. lister et vérifier les services Active Directory ;
2. consulter les journaux d’événements ;
3. exporter les événements dans un fichier CSV ;
4. arrêter, vérifier et redémarrer DFS Replication.

---

## Structure du travail sur GitHub

Le travail est organisé dans le dossier personnel suivant :

```text
4.Services/
└── 300159195/
    ├── README.md
    ├── services1.ps1
    ├── services2.ps1
    ├── services3.ps1
    ├── services4.ps1
    └── images/
        ├── 01_services_ad_etat.jpg
        ├── 02_logs_services_ad.jpg
        ├── 03_export_logs_csv.jpg
        ├── 04_contenu_adlogs_csv.jpg
        └── 05_dfsr_stop_start.jpg
```

---

## Conclusion

Ce laboratoire m’a permis de manipuler les principaux services d’Active Directory avec PowerShell.

J’ai vérifié l’état des services essentiels du contrôleur de domaine, consulté les journaux d’événements, exporté les logs Active Directory vers un fichier CSV et testé l’arrêt puis le redémarrage du service DFS Replication.

Les vérifications finales confirment que les services Active Directory fonctionnent correctement après les différentes manipulations.
