# Laboratoire — Création d’un utilisateur administrateur
### Windows Server 2022 Datacenter
**Objectif :**
Créer un utilisateur local avec l’ID **300159693** et lui attribuer les droits administrateur à l’aide de PowerShell.
### 1. Ouvrir PowerShell
Ouvrir **PowerShell en tant qu’administrateur** afin de pouvoir créer le compte et modifier les groupes locaux.
### 2. Créer l’utilisateur
Entrer les commandes suivantes :
```powershell
$Password = Read-Host -Prompt "Entrer le mot de passe pour 300159693" -AsSecureString
New-LocalUser -Name "300159693" `
-Password $Password `
-FullName "Mekaouche Mazigh (ID 300159693)" `
-Description "Compte administrateur pour Windows Server 2022 (Rack 2, U13)" `
-PasswordNeverExpires:$true `
-UserMayNotChangePassword:$true
```
Le compte local **300159693** est ainsi créé avec un mot de passe sécurisé.
### 3. Ajouter l’utilisateur aux administrateurs
```powershell
Add-LocalGroupMember -Group "Administrators" -Member "300159693"
```
Cette commande ajoute l’utilisateur au groupe **Administrators**, lui donnant les droits administratifs sur le serveur.
### 4. Vérifier l’ajout

```powershell
Get-LocalGroupMember -Group "Administrators"
```
La liste doit afficher **300159693**. Cela confirme que l’utilisateur a bien été ajouté au groupe des administrateurs.
### Conclusion

Le compte **300159693** a été créé avec succès et possède maintenant les droits administrateur sur **Windows Server 2022 Datacenter**
<img width="2048" height="1536" alt="e923befb-03bd-4935-a634-8ec3c4505845" src="https://github.com/user-attachments/assets/0faa79ca-1ca6-4f06-aaf5-2e81ad0d361b" />
<img width="2048" height="1536" alt="1fe3aba9-282d-4fb6-a650-fab06a379d1a" src="https://github.com/user-attachments/assets/1d7838a7-e7c5-4c30-8893-935a742e55bd" />

 
