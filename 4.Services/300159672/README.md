# Les services Windows et AD DS

**Nom :** Amadou Sow
**Numéro étudiant :** 300159672
**Environnement :** Windows Server 2022, machine virtuelle 10.7.237.225 (serveur SRV300159672, contrôleur du domaine DC300159672.local), accessible depuis mon Mac avec Windows App.

Les quatre scripts sont créés avec Notepad dans `C:\Users\Administrator`, puis affichés avec `cat` et exécutés dans PowerShell.

## 1. Lister les services AD et leur état

Contenu de `services1.ps1` :

```powershell
# Lister tous les services liés à AD
Get-Service | Where-Object {
    $_.DisplayName -like "*Directory*" -or $_.Name -match "NTDS|ADWS|DFSR|kdc|Netlogon|IsmServ"
} | Sort-Object DisplayName

# Vérifier l’état d’un service spécifique
Get-Service -Name NTDS, ADWS, DFSR
```

Vérification et exécution :

```powershell
cat .\services1.ps1
.\services1.ps1
```
<img width="2048" height="1214" alt="01-services-ad" src="https://github.com/user-attachments/assets/1a7f0442-f340-496f-a858-4c8caeaf1f24" />


NTDS, ADWS et DFSR apparaissent deux fois, car le script contient deux commandes : la première liste les services AD, la seconde vérifie ces trois services séparément. [À compléter : l'état affiché pour NTDS, ADWS, DFSR, IsmServ, Kdc et Netlogon.]

## 2. Afficher les événements d'un service AD

Contenu de `services2.ps1` :

```powershell
# Afficher les 20 derniers événements liés à NTDS
Get-EventLog -LogName "Directory Service" -Newest 20

# Afficher les logs du système
Get-EventLog -LogName "System" -Newest 20 | Where-Object {$_.Source -eq "Netlogon"}

# Afficher les logs via le journal moderne (Event Viewer v2)
Get-WinEvent -LogName "Directory Service" -MaxEvents 20 | Format-Table TimeCreated, Id, LevelDisplayName, Message -AutoSize
```

Vérification et exécution :

```powershell
cat .\services2.ps1
.\services2.ps1
```

<img width="2048" height="1214" alt="02-evenements-export" src="https://github.com/user-attachments/assets/04f712bf-6599-4a09-b945-08f3fc5ead8f" />


[À compléter : le niveau des événements affichés, et si le filtre Netlogon a renvoyé un résultat ou rien.]

## 3. Capturer les événements dans un fichier

Contenu de `services3.ps1` :

```powershell
Get-WinEvent -LogName "Directory Service" -MaxEvents 50 | Export-Csv -Path "C:\Logs\ADLogs.csv" -NoTypeInformation
```

Le dossier `C:\Logs` doit exister avant l'exécution, car le script ne le crée pas. [Si tu l'as créé, ajoute ici la commande `mkdir C:\Logs`.]

Vérification et exécution :

```powershell
cat .\services3.ps1
.\services3.ps1
```

<img width="2048" height="1214" alt="02-evenements-export" src="https://github.com/user-attachments/assets/60d4cd33-1389-4642-b66f-7807aabca615" />


Le script n'affiche rien quand il réussit. La commande `Get-Item C:\Logs\ADLogs.csv` confirme que le fichier `ADLogs.csv` a été créé (environ 33 Ko).

## 4. Arrêter et redémarrer un service

Contenu de `services4.ps1` :

```powershell
Stop-Service -Name DFSR
(Get-Service -name DFSR).status
Start-Service -Name DFSR
```

Vérification et exécution :

```powershell
cat .\services4.ps1
.\services4.ps1
```

<img width="2048" height="1214" alt="03-dfsr-verification" src="https://github.com/user-attachments/assets/43d4e734-1e34-42df-abf9-24faf96d01da" />


Le script affiche `Stopped` après l'arrêt de DFSR, puis relance le service. La commande `Get-Service -Name DFSR` affiche ensuite `Running`.

## Résultats du laboratoire

| Objectif | Résultat |
|---|---|
| Lister les services AD et leur état | Script `services1.ps1` exécuté |
| Afficher les événements d'un service AD | Script `services2.ps1` exécuté |
| Capturer les événements dans un fichier | `C:\Logs\ADLogs.csv` créé |
| Arrêter et redémarrer un service | DFSR arrêté (`Stopped`), puis relancé (`Running`) |
| Nom des scripts | `services1.ps1` à `services4.ps1` |
