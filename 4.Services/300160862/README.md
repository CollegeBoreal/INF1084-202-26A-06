# Laboratoire — Les services Windows et AD DS

**Nom :** Yamna Cherif  
**Matricule :** 300160862  
**Cours :** INF1084 — Administration Windows  
**Serveur :** DC300160862

## Objectifs

- Lister les services Active Directory et vérifier leur état.
- Consulter les événements liés à Active Directory.
- Exporter les événements dans un fichier CSV.
- Arrêter puis démarrer le service DFSR.

## Environnement

Les manipulations ont été réalisées sur le serveur de laboratoire
DC300160862 avec Windows PowerShell exécuté en tant qu’administrateur.

## 1. Afficher les services Active Directory

**Script :** [services1.ps1](services1.ps1)

Ce script recherche les services liés à Active Directory, les trie par
nom d’affichage et vérifie les services NTDS, ADWS et DFSR.

| Service | Fonction | État observé |
|---|---|---|
| NTDS | Fournit les services d’annuaire Active Directory | Running |
| ADWS | Permet l’accès à AD par les outils utilisant les services Web AD | Running |
| DFSR | Assure notamment la réplication de SYSVOL entre contrôleurs de domaine | Running |
| Kdc | Fournit les tickets d’authentification Kerberos | Running |
| Netlogon | Participe à l’authentification et à la localisation des contrôleurs de domaine | Running |
| IsmServ | Fournit le service de messagerie intersites | Running |

**Résultat :** les six services affichés étaient en cours d’exécution.

## 2. Consulter les événements Active Directory

**Script :** [services2.ps1](services2.ps1)

Ce script effectue trois opérations :

1. Afficher les 20 derniers événements du journal `Directory Service`.
2. Rechercher les événements Netlogon parmi les 20 derniers événements du journal `System`.
3. Afficher les 20 derniers événements de `Directory Service` avec
   `Get-WinEvent`, sous forme de tableau.

**Résultat :** les événements ont été affichés avec leur date, leur
identifiant, leur niveau et leur message.

Le filtre Netlogon peut ne produire aucun résultat si aucun événement
correspondant ne figure parmi les 20 derniers événements système.

## 3. Exporter les événements dans un fichier CSV

**Script :** [services3.ps1](services3.ps1)

Ce script crée le dossier `C:\Logs`, puis exporte les 50 derniers
événements du journal `Directory Service` dans le fichier :

`C:\Logs\ADLogs.csv`

Il vérifie ensuite la présence du fichier et compte les événements exportés.

**Résultat :** le fichier `ADLogs.csv` a été créé et la vérification
a retourné `Count : 50`.

## 4. Arrêter puis démarrer DFSR

**Script :** [services4.ps1](services4.ps1)

Ce script arrête le service DFSR, affiche son état, puis le démarre
et affiche de nouveau son état.

**Résultat observé :**

```text
Stopped
Running
```

Une vérification finale avec `Get-Service -Name DFSR` a confirmé
que le service était en cours d’exécution.

## Exécution des scripts

Dans Windows PowerShell ouvert en tant qu’administrateur :

```powershell
Set-Location C:\TP_Services
.\services1.ps1
.\services2.ps1
.\services3.ps1
.\services4.ps1
```

Le script `services4.ps1` a été exécuté sur le serveur de laboratoire.
L’arrêt de DFSR interrompt temporairement la réplication assurée
par ce service.

## Conclusion

Ce laboratoire m’a permis de vérifier les services Active Directory,
de consulter leurs événements et d’exporter les journaux.
J’ai également arrêté puis démarré DFSR et confirmé son état final
`Running`.
