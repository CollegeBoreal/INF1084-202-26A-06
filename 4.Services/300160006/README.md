# 300160006
  # Laboratoire : Services Windows et AD DS

## Introduction

Dans ce laboratoire, j’ai utilisé PowerShell pour gérer et vérifier les services liés à Active Directory Domain Services (AD DS). Le travail consistait à afficher les services et leur état, consulter les événements du système, exporter les journaux dans un fichier CSV et arrêter puis redémarrer un service Windows.

### 1. Lister les services AD et leur état

J’ai créé le fichier `services1.ps1` avec Notepad. J’y ai écrit les commandes PowerShell permettant de rechercher les services liés à Active Directory et de vérifier l’état des services NTDS, ADWS et DFSR.

**Contenu du fichier `services1.ps1` :**

```powershell
# Lister tous les services liés à AD
Get-Service | Where-Object {
    $_.DisplayName -like "*Directory*" -or $_.Name -match "NTDS|ADWS|DFSR|kdc|Netlogon|IsmServ"
} | Sort-Object DisplayName

# Vérifier l’état de certains services
Get-Service -Name NTDS, ADWS, DFSR
```

**Vérification et exécution :**
![images alt](https://github.com/CollegeBoreal/INF1084-202-26A-06/blob/8cde807b6454d01132b21caa625720cda5add0f7/4.Services/300160006/images/Screenshot%202026-10-06%20121920.png)

Le résultat montre les services liés à Active Directory ainsi que leur état. Les six services affichés, soit NTDS, ADWS, DFSR, IsmServ, Kdc et Netlogon, sont à l’état `Running`, ce qui signifie qu’ils sont en cours d’exécution.

Certains services apparaissent deux fois, car le script contient une commande pour afficher la liste des services et une autre pour vérifier séparément NTDS, ADWS et DFSR.

### 2. Afficher les événements d’un service AD

J’ai créé le fichier `services2.ps1` pour consulter les événements enregistrés dans les journaux Windows. Le script affiche les 20 derniers événements du journal Directory Service, recherche les événements provenant de Netlogon dans le journal System et utilise également `Get-WinEvent` pour afficher les informations des événements.

**Contenu du fichier `services2.ps1` :**

```powershell
# Afficher les 20 derniers événements liés à AD
Get-EventLog -LogName "Directory Service" -Newest 20

# Rechercher les événements Netlogon dans le journal System
Get-EventLog -LogName "System" -Newest 20 |
Where-Object {$_.Source -eq "Netlogon"}

# Afficher les événements avec leurs détails
Get-WinEvent -LogName "Directory Service" -MaxEvents 20 |
Format-Table TimeCreated, Id, LevelDisplayName, Message -AutoSize
```

**Vérification et exécution :**

![images alt](https://github.com/CollegeBoreal/INF1084-202-26A-06/blob/e69a44bba16f9230a142548687d6a739c5ff562b/4.Services/300160006/images/Screenshot%202026-10-06%20121939.png)


Les résultats permettent de consulter les événements du journal Directory Service, notamment leur date, leur identifiant, leur niveau et leur message. Les événements affichés sont de niveau Information. La recherche des événements Netlogon n’a retourné aucun résultat parmi les 20 derniers événements du journal System.

### 3. Exporter les événements dans un fichier CSV

Pour conserver les événements dans un fichier, j’ai d’abord créé le dossier `C:\Logs`. Ensuite, j’ai créé le script `services3.ps1` pour exporter les 50 événements les plus récents du journal Directory Service au format CSV.

**Création du dossier :**

```powershell
New-Item -Path "C:\Logs" -ItemType Directory -Force
```

**Contenu du fichier `services3.ps1` :**

```powershell
Get-WinEvent -LogName "Directory Service" -MaxEvents 50 |
Export-Csv -Path "C:\Logs\ADLogs.csv" -NoTypeInformation
```

**Vérification et exécution :**

![images alt](https://github.com/CollegeBoreal/INF1084-202-26A-06/blob/b1f07120817f360757b59d2f8b0570c73afcf62b/4.Services/300160006/images/Screenshot%202026-10-06%20121959.png)

L’exécution du script a permis de créer le fichier `ADLogs.csv` dans le dossier `C:\Logs`. La commande de vérification confirme que le fichier existe et que sa taille est de 38 080 octets. L’exportation permet de conserver les événements et de les consulter ultérieurement.

### 4. Arrêter et redémarrer le service DFSR

J’ai créé le fichier `services4.ps1` pour arrêter le service DFSR, vérifier son état, puis le démarrer à nouveau. Cette manipulation permet de comprendre comment gérer un service Windows à l’aide de PowerShell.

**Contenu du fichier `services4.ps1` :**

```powershell
Stop-Service -Name DFSR
(Get-Service -Name DFSR).Status
Start-Service -Name DFSR
```

**Vérification et exécution :**

![images alt](https://github.com/CollegeBoreal/INF1084-202-26A-06/blob/4a15a701d188c6959ce01b0313c3171d7df85947/4.Services/300160006/images/Screenshot%202026-10-06%20122016.png)


Le résultat montre que le service DFSR passe à l’état `Stopped` après son arrêt, puis revient à l’état `Running` après son démarrage. La dernière commande permet de confirmer qu’il fonctionne de nouveau.

J’ai également vérifié la présence des quatre scripts avec la commande suivante :

```powershell
Get-ChildItem .\services[1-4].ps1
```

Le résultat confirme que les fichiers `services1.ps1`, `services2.ps1`, `services3.ps1` et `services4.ps1` sont présents dans le répertoire `C:\Users\Administrator`.

### 5. 
![images alt}(https://github.com/CollegeBoreal/INF1084-202-26A-06/blob/951a79e6611948e786c4c9f7da9a9fae3d8eab53/4.Services/300160006/images/Screenshot%202026-10-06%20115257.png)

### 6. Résultats du laboratoire

| Objectif | Résultat obtenu |
|---|---|
| Lister les services AD et leur état | Les six services affichés sont à l’état `Running`. |
| Afficher les événements d’un service AD | Les événements du journal Directory Service ont été consultés. |
| Exporter les événements dans un fichier | Le fichier `C:\Logs\ADLogs.csv` a été créé. |
| Arrêter et redémarrer un service | DFSR a été arrêté, puis démarré à nouveau. |
| Vérifier les scripts | Les quatre scripts ont été retrouvés dans le répertoire de travail. |

### Conclusion

Ce laboratoire m’a permis de pratiquer l’utilisation de PowerShell pour gérer les services Windows liés à Active Directory. J’ai appris à vérifier l’état des services, à consulter les journaux d’événements, à exporter des données dans un fichier CSV et à arrêter puis redémarrer un service. Ces manipulations m’ont aidé à mieux comprendre certaines tâches de base de l’administration d’un serveur Windows.
