# Laboratoire — Création d’un utilisateur administrateur

## Windows Server 2022 Datacenter

### 1. Objectif du laboratoire

L’objectif de ce laboratoire est de créer un utilisateur local nommé `300159203` sur Windows Server 2022 Datacenter, puis de lui attribuer les droits d’administration en l’ajoutant au groupe local `Administrators`.

Les opérations sont réalisées à l’aide de PowerShell.

### 2. Ouverture de PowerShell

Ouvrir Windows PowerShell avec les privilèges d’administrateur afin de pouvoir créer un compte local et modifier les membres du groupe Administrators.

### 3. Création de l’utilisateur local

Pour créer l’utilisateur, un mot de passe sécurisé est d’abord demandé. La commande `New-LocalUser` permet ensuite de créer le compte avec son nom complet et sa description.

```powershell
$Password = Read-Host -Prompt "Entrer le mot de passe pour 300159203" -AsSecureString

New-LocalUser -Name "300159203" `
    -Password $Password `
    -FullName "Riadh Sahraoui (ID 300159203)" `
    -Description "Compte admin pour Windows Server 2022 (Rack 2, U13)" `
    -PasswordNeverExpires:$true `
    -UserMayNotChangePassword:$true
```

**Explication des paramètres :**

* `-Name` : définit le nom du compte local.
* `-Password` : attribue le mot de passe saisi.
* `-FullName` : indique le nom complet de l’utilisateur.
* `-Description` : ajoute une description au compte.
* `-PasswordNeverExpires:$true` : configure le mot de passe pour qu’il n’expire pas.
* `-UserMayNotChangePassword:$true` : empêche l’utilisateur de modifier son mot de passe.

<img width="1536" height="2048" alt="image" src="https://github.com/user-attachments/assets/22812d60-e2fe-43a7-9398-1cbd8c08556a" />

### 4. Ajout au groupe Administrators

Une fois le compte créé, la commande suivante permet de l’ajouter au groupe local `Administrators` :

```powershell
Add-LocalGroupMember -Group "Administrators" -Member "300159203"
```

L’ajout au groupe Administrators accorde au compte les privilèges administratifs locaux sur le serveur.

### 5. Vérification de l’appartenance au groupe

Pour vérifier que l’utilisateur a bien été ajouté au groupe Administrators, exécuter :

```powershell
Get-LocalGroupMember -Group "Administrators"
```

Cette commande affiche les membres du groupe. Il faut vérifier que le compte `300159203` figure dans la liste.

<img width="2048" height="1536" alt="image" src="https://github.com/user-attachments/assets/ccf2eac7-a1d7-4219-8968-7d97ea448eb6" />

### 6. Conclusion

Ce laboratoire a permis de pratiquer la création d’un utilisateur local avec PowerShell, la configuration de ses propriétés et son ajout au groupe Administrators. La dernière commande permet de vérifier l’appartenance du compte au groupe d’administration.



