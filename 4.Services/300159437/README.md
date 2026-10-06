## Résumé du laboratoire

Dans ce laboratoire, j’ai utilisé **PowerShell sur Windows Server 2022** afin de surveiller et gérer différents services liés à **Active Directory**. J’ai créé plusieurs scripts PowerShell, chacun ayant une fonction spécifique.

### `services1.ps1` – Vérification des services Active Directory

Ce premier script permet d’identifier et de vérifier l’état des principaux services associés à Active Directory, notamment :

- `NTDS` – Active Directory Domain Services
- `ADWS` – Active Directory Web Services
- `DFSR` – DFS Replication
- `KDC` – Kerberos Key Distribution Center
- `Netlogon` – Service d’authentification du domaine

La commande `Get-Service` permet de déterminer si ces services sont en cours d’exécution (`Running`) ou arrêtés (`Stopped`).

### `services2.ps1` – Consultation des journaux d’événements

Le deuxième script permet de consulter les événements associés à **Active Directory et Netlogon**.

J’ai utilisé principalement `Get-WinEvent` et `Get-EventLog` pour récupérer les événements récents.

Cela permet d’obtenir des informations comme :

- la date et l’heure de l’événement ;
- l’identifiant de l’événement (`Event ID`) ;
- son niveau (`Information`, `Warning`, `Error`) ;
- la source ;
- le message associé.

Ces informations sont utiles pour diagnostiquer les problèmes d’Active Directory.

### `services3.ps1` – Exportation des événements AD

Le troisième script permet de récupérer les **50 derniers événements Active Directory** et de les exporter dans un fichier CSV.

Les événements sont enregistrés dans :

`C:\Logs\ADLogs.csv`

Le script vérifie également si le dossier `C:\Logs` existe. S’il n’existe pas, il est créé automatiquement avant l’exportation.

Cette méthode permet de conserver les journaux pour les consulter ou les analyser plus tard.

### `services4.ps1` – Gestion du service DFSR

Le quatrième script permet de manipuler le service **DFSR (DFS Replication)**.

Le script effectue les opérations suivantes :

1. Vérifier l’état initial du service DFSR.
2. Arrêter le service avec `Stop-Service`.
3. Vérifier que son état est devenu `Stopped`.
4. Redémarrer le service avec `Start-Service`.
5. Vérifier que son état final est `Running`.

DFSR est notamment important dans un environnement Active Directory puisqu’il participe à la réplication de **SYSVOL entre les contrôleurs de domaine**.

## Conclusion

Ce laboratoire m’a permis de mieux comprendre comment utiliser **PowerShell pour administrer et surveiller Active Directory sous Windows Server 2022**.

J’ai appris à vérifier l’état des services, consulter les journaux d’événements, exporter les logs dans un fichier CSV et gérer le démarrage et l’arrêt d’un service Windows.

Ces commandes sont particulièrement utiles pour l’administration, la surveillance et le dépannage d’un environnement Active Directory.
