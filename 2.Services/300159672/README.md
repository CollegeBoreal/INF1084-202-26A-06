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
New-LocalUser -Name "AdminAmadou" -Password $MotDePasse -FullName "Amadou Sow"
Set-LocalUser -Name "AdminAmadou" -Description "Compte administrateur - Laboratoire"
```
<img width="1512" height="982" alt="Capture d’écran 2026-10-05 à 13 05 39" src="https://github.com/user-attachments/assets/0ca68f90-e2df-4b6f-9798-0daeaa462347" />


**2. Ajout au groupe Administrators**
```powershell
Add-LocalGroupMember -Group "Administrators" -Member "AdminAmadou"
```
<img width="847" height="656" alt="Capture d’écran 2026-10-05 à 13 10 46" src="https://github.com/user-attachments/assets/ed346236-b87a-4fc5-aa12-d9e838ea264f" />


**3. Renommage du compte avec le numéro étudiant**
```powershell
Rename-LocalUser -Name "AdminAmadou" -NewName "300159672"
```
<img width="1512" height="982" alt="Capture d’écran 2026-10-05 à 13 17 55" src="https://github.com/user-attachments/assets/f9f02c5a-9364-4df0-8d04-5bdb4e1b538e" />


**4. Vérification de l'utilisateur**
```powershell
Get-LocalUser -Name "300159672"
```
<img width="847" height="656" alt="Capture d’écran 2026-10-05 à 13 10 46" src="https://github.com/user-attachments/assets/cc51e624-dfba-45f3-b54e-bded2c746deb" />


**5. Vérification de l'appartenance au groupe**
```powershell
Get-LocalGroupMember -Group "Administrators"
```
<img width="847" height="656" alt="Capture d’écran 2026-10-05 à 13 10 46" src="https://github.com/user-attachments/assets/1ab640d0-e471-49d7-9115-155582bf5595" />


### Preuves d'exécution

**Compte utilisateur**

<img width="1512" height="982" alt="Capture d’écran 2026-10-05 à 13 30 56" src="https://github.com/user-attachments/assets/a058e3ce-09cc-4269-9286-ff3c51faa5cb" />


### Résultat
- Le compte `300159672` est créé, activé, avec la description « Compte administrateur - Laboratoire ».
- Il apparaît dans la liste des membres du groupe `Administrators`, ce qui lui donne les droits d'administration sur le serveur.

### Notes techniques
- Le mot de passe est saisi via `Read-Host -AsSecureString` : il n'apparaît ni dans l'historique des commandes ni dans la documentation.
- `Administrators` est un groupe intégré Windows : il n'est pas nécessaire de le créer.
- `Rename-LocalUser` conserve le mot de passe, la description et les appartenances aux groupes.
- La liste complète du groupe contient les comptes d'autres étudiants : elle n'est pas reproduite ici.
