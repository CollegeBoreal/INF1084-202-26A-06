
## Laboratoire — Création d'un utilisateur administrateur (Windows Server 2022)

### Objectif
Créer un utilisateur ayant les droits d'administration sur Windows Server 2022 via PowerShell.

### Environnement
- **Serveur** : Windows Server 2022 Datacenter
- **Host IP** : 10.7.237.7
- **Rack** : 2 — U13 — Serveur A/G7
- **Connexion** : RDP via Windows App (Administrator)

### Étapes réalisées

**1. Création de l'utilisateur local (saisie sécurisée du mot de passe)**
```powershell
$MotDePasse = Read-Host -AsSecureString -Prompt "Entrez le mot de passe pour AdminAmadou"
New-LocalUser -Name "AdminAmadou" -Password $MotDePasse -FullName "Amadou Sow" -Description "Compte administrateur - Laboratoire"
```

**2. Ajout au groupe Administrators**
```powershell
Add-LocalGroupMember -Group "Administrators" -Member "AdminAmadou"
```

**3. Vérification de la création**
```powershell
Get-LocalUser -Name "AdminAmadou"
```

**4. Vérification de l'appartenance au groupe**
```powershell
Get-LocalGroupMember -Group "Administrators"
```

### Résultat
Le compte `AdminAmadou` a été créé avec succès et intégré au groupe `Administrators`, lui donnant les droits d'administration complets sur le serveur.

### Notes techniques
- Le mot de passe est saisi via `Read-Host -AsSecureString` plutôt qu'écrit en texte brut, afin d'éviter qu'il apparaisse dans l'historique des commandes ou dans la documentation.
- Le groupe `Administrators` est un groupe intégré Windows (Built-in) — il n'est pas nécessaire de le créer.
- L'appartenance à ce groupe donne un contrôle total sur le système (installation de logiciels, modification des paramètres système, gestion des autres comptes).
