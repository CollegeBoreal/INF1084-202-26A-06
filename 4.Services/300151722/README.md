# Laboratoire 4 - Gestion des services

**Nom : Oustani Islam**  
**ID : 300151722**  
**Système : Windows Server 2022 Datacenter**

## Objectif

L'objectif de ce laboratoire est d'utiliser **PowerShell** pour gérer et surveiller les services liés à Active Directory sous Windows Server 2022.

Les principales opérations réalisées sont :

- afficher les services Active Directory ;
- vérifier l'état des services ;
- consulter les événements Active Directory ;
- exporter les événements dans un fichier CSV ;
- arrêter et démarrer un service.

---

## 1. Afficher les services Active Directory

Le premier script permet d'afficher les principaux services liés à Active Directory ainsi que leur état.

### Script `services1.ps1`

```powershell
Get-Service | Where-Object {
    $_.DisplayName -like "*Directory*" -or $_.Name -match "NTDS|ADWS|DFSR|kdc|Netlogon|IsmServ"
} | Sort-Object DisplayName

Get-Service -Name NTDS, ADWS, DFSR
```

Le script est exécuté avec :

```powershell
.\services1.ps1
```

Les services principaux affichés sont :

- `NTDS` : Active Directory Domain Services
- `ADWS` : Active Directory Web Services
- `DFSR` : DFS Replication
- `IsmServ` : Intersite Messaging
- `Kdc` : Kerberos Key Distribution Center
- `Netlogon` : Netlogon

### Preuve

<img width="593" height="535" alt="L1" src="https://github.com/user-attachments/assets/d824d022-73f3-4f6e-a2df-bc6debe403fd" />


Le résultat montre que les principaux services Active Directory sont en état `Running`.

---

## 2. Afficher les événements Active Directory

Le deuxième script permet d'afficher les événements récents du journal **Directory Service**.

### Script `services2.ps1`

```powershell
Get-WinEvent -LogName "Directory Service" -MaxEvents 20 |
    Format-Table TimeCreated, Id, LevelDisplayName, Message -AutoSize
```

Le script est exécuté avec :

```powershell
.\services2.ps1
```

Les informations affichées comprennent :

- la date et l'heure de l'événement ;
- l'identifiant de l'événement ;
- le niveau de l'événement ;
- le message associé.

### Preuve

<img width="1600" height="499" alt="L2" src="https://github.com/user-attachments/assets/8dfafaa0-f82e-4cd9-8fcf-9d2840db5048" />


Cette commande permet de consulter rapidement les événements enregistrés par Active Directory.

---

## 3. Exporter les événements dans un fichier CSV

Le troisième script permet d'enregistrer les événements Active Directory dans un fichier CSV.

### Script `services3.ps1`

```powershell
New-Item -Path "C:\Logs" -ItemType Directory -Force

Get-WinEvent -LogName "Directory Service" -MaxEvents 50 |
    Export-Csv -Path "C:\Logs\ADLogs.csv" -NoTypeInformation
```

Le script est exécuté avec :

```powershell
.\services3.ps1
```

Le dossier utilisé pour enregistrer les journaux est :

```text
C:\Logs
```

Le fichier créé est :

```text
C:\Logs\ADLogs.csv
```

La présence du fichier peut être vérifiée avec :

```powershell
dir C:\Logs
```

### Preuve

<img width="615" height="485" alt="L3" src="https://github.com/user-attachments/assets/bc1d56b9-4593-490d-a19d-b71437fbfc85" />


Le fichier `ADLogs.csv` a été créé avec succès dans le dossier `C:\Logs`.

---

## 4. Arrêter et démarrer le service DFSR

Le dernier script permet de tester la gestion d'un service avec PowerShell.

Le service utilisé est :

```text
DFSR - DFS Replication
```

### Script `services4.ps1`

```powershell
Stop-Service -Name DFSR

(Get-Service -Name DFSR).Status

Start-Service -Name DFSR

Get-Service -Name DFSR
```

Le script est exécuté avec :

```powershell
.\services4.ps1
```

Après la commande :

```powershell
Stop-Service -Name DFSR
```

le service passe à l'état :

```text
Stopped
```

Ensuite, la commande :

```powershell
Start-Service -Name DFSR
```

permet de remettre le service en fonctionnement.

Le résultat final est :

```text
Running
```

### Preuve

<img width="793" height="671" alt="L4" src="https://github.com/user-attachments/assets/29f38f0e-5140-4acb-8249-6c54bd4df679" />


Le résultat confirme que le service DFSR a été arrêté puis redémarré correctement.

---

## Résultat

Les quatre scripts PowerShell ont permis de réaliser les opérations suivantes :

| Script | Fonction |
|---|---|
| `services1.ps1` | Afficher les services Active Directory |
| `services2.ps1` | Afficher les événements Active Directory |
| `services3.ps1` | Exporter les événements dans un fichier CSV |
| `services4.ps1` | Arrêter et démarrer le service DFSR |

Le fichier de journal exporté est disponible dans :

```text
C:\Logs\ADLogs.csv
```

---

## Conclusion

Ce laboratoire a permis d'utiliser PowerShell pour gérer les services de Windows Server 2022 et surveiller les événements Active Directory.

Les commandes utilisées permettent de vérifier l'état des services, consulter les journaux, exporter les événements et contrôler le démarrage ou l'arrêt d'un service.
