# TP — Gestion des services Windows et Active Directory

## 1. Objectif du TP

L'objectif de ce laboratoire est de gérer et de vérifier les services Windows liés à Active Directory sur un serveur Windows Server 2022 à l'aide de PowerShell.

Ce TP permet de :

* Identifier les principaux services liés à Active Directory.
* Consulter les événements enregistrés dans les journaux Windows.
* Exporter les événements dans un fichier CSV.
* Arrêter et redémarrer un service Windows.

## 2. Environnement de travail

* **Système d'exploitation :** Windows Server 2022
* **Outil :** Windows PowerShell
* **Rôle du serveur :** Contrôleur de domaine Active Directory
* **Dossier des scripts :** `C:\TP_Services`
* **Fichier d'exportation :** `C:\Logs\ADLogs.csv`
  <img width="1227" height="468" alt="image" src="https://github.com/user-attachments/assets/0b9b48ec-2191-430a-b11e-2eada6ec3688" />


## 3. Script 1 — Vérification des services Active Directory

**Fichier :** `services1.ps1`

Ce script permet d'identifier les services associés à Active Directory et de vérifier l'état de trois services principaux : NTDS, ADWS et DFSR.

### Commande exécutée

```powershell
& "C:\TP_Services\services1.ps1"
```

### Résultat

Les services suivants ont été identifiés :

| Service  | Fonction                                             | État observé |
| -------- | ---------------------------------------------------- | ------------ |
| NTDS     | Service principal d'Active Directory Domain Services | Running      |
| ADWS     | Service Web Active Directory                         | Running      |
| DFSR     | Réplication du système de fichiers distribué         | Running      |
| Kdc      | Service KDC (Kerberos)                               | Running      |
| Netlogon | Service Netlogon                                     | Running      |
| IsmServ  | Service Intersite Messaging                          | Running      |

**Conclusion :** Les services vérifiés étaient en cours d'exécution au moment du test.  
<img width="2048" height="713" alt="image" src="https://github.com/user-attachments/assets/bcfee041-cb91-490e-836f-6743f409ecfb" />  



## 4. Script 2 — Consultation des journaux d'événements

**Fichier :** `services2.ps1`

Ce script utilise `Get-EventLog` et `Get-WinEvent` pour consulter les événements enregistrés dans les journaux Windows.

Il permet de :

* Afficher les 20 derniers événements de Directory Service.
* Rechercher les événements provenant de Netlogon dans le journal System.
* Afficher les événements récents de Directory Service avec leur date, leur identifiant, leur niveau et leur message.

### Commande exécutée

```powershell
& "C:\TP_Services\services2.ps1"
```

### Résultat

Le script a affiché les événements du journal Directory Service. La recherche des événements Netlogon n'a retourné aucun résultat parmi les 20 derniers événements System examinés.

Certains événements de niveau Warning ont également été affichés. Ils peuvent nécessiter une vérification distincte pour déterminer leur signification.

**Conclusion :** Le script permet de consulter les journaux et de repérer les événements qui pourraient nécessiter une analyse supplémentaire.  
<img width="2048" height="1225" alt="image" src="https://github.com/user-attachments/assets/08a8ed18-b52d-4758-bfbf-ca299f4df1f2" />


## 5. Script 3 — Exportation des événements vers un fichier CSV

**Fichier :** `services3.ps1`

Ce script vérifie si le dossier `C:\Logs` existe. Si nécessaire, il le crée, puis exporte les 50 derniers événements de Directory Service vers un fichier CSV.

### Commande exécutée

```powershell
& "C:\TP_Services\services3.ps1"
```

### Vérification du fichier

```powershell
Get-Item C:\Logs\ADLogs.csv
```

Pour consulter les premières lignes du fichier :

```powershell
Import-Csv C:\Logs\ADLogs.csv | Select-Object -First 5
```

### Résultat

Le fichier `C:\Logs\ADLogs.csv` a été créé avec succès. Sa taille observée était de 33 562 octets. L'importation du fichier dans PowerShell a permis d'afficher les premières entrées.

**Conclusion :** Les événements peuvent être exportés au format CSV pour faciliter leur consultation et leur analyse.  
<img width="2048" height="1225" alt="image" src="https://github.com/user-attachments/assets/977e610f-ea43-4a9d-9517-8a72f327fba3" />  



## 6. Script 4 — Arrêt et redémarrage du service DFSR

**Fichier :** `services4.ps1`

Ce script arrête temporairement le service DFSR, vérifie son état, le redémarre et vérifie une dernière fois son état.

### Commande exécutée

```powershell
& "C:\TP_Services\services4.ps1"
```

### Résultats observés

* Après l'arrêt : `Stopped`
* Après le redémarrage : `Running`

Une vérification supplémentaire a été effectuée avec la commande suivante :

```powershell
Get-Service -Name DFSR
```

Le résultat final indiquait que le service DFSR était en état `Running`.

**Conclusion :** Le script a correctement arrêté puis redémarré le service DFSR dans l'environnement de laboratoire.  
<img width="2048" height="1224" alt="image" src="https://github.com/user-attachments/assets/10300b51-47d0-491d-a7ef-5baad85f5ad7" />


## 7. Conclusion générale

Ce laboratoire m'a permis de pratiquer plusieurs opérations d'administration Windows avec PowerShell. J'ai appris à vérifier les services liés à Active Directory, à consulter les journaux d'événements, à exporter des données vers un fichier CSV et à gérer le cycle de démarrage d'un service Windows.

Les quatre scripts ont été exécutés et les résultats attendus ont été observés lors des vérifications effectuées.
