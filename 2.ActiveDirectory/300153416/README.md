
Documentation du Travail Pratique : Déploiement d'Active Directory et Gestion des Utilisateurs
1. Objectif du laboratoire :
L'objectif de ce TP est de déployer les services de domaine Active Directory (AD DS) sur un serveur Windows Server 2022, de le promouvoir en tant que contrôleur de domaine pour une nouvelle forêt, et de créer un compte utilisateur administrateur via PowerShell.

2. Paramètres de configuration :

Adresse IP du serveur : 10.7.237.210

Nom du domaine : boreal.local

Compte utilisateur créé : User300153416 (User300153416@boreal.local)

Groupe de sécurité attribué : Domain Admins

3. Étapes de réalisation (Commandes PowerShell) :

Étape 1 : Installation du rôle AD DS et promotion du contrôleur de domaine

PowerShell
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
Install-ADDSForest -DomainName "boreal.local" -InstallDNS:$true -Force
Étape 2 : Création du compte utilisateur et attribution des privilèges d'administrateur

PowerShell
$Password = ConvertTo-SecureString "Infra@2024" -AsPlainText -Force
New-ADUser -Name "User300153416" -SamAccountName "User300153416" -UserPrincipalName "User300153416@boreal.local" -AccountPassword $Password -Enabled $true -PasswordNeverExpires $true
Add-ADGroupMember -Identity "Domain Admins" -Members "User300153416"
Étape 3 : Vérification de l'appartenance aux groupes

PowerShell
Get-ADPrincipalGroupMembership "User300153416" | Select-Object Name
4. Résultat et validation :
La commande de vérification confirme que le compte User300153416 a été créé avec succès dans le domaine boreal.local et qu'il est bien membre des groupes Domain Users et Domain Admins.
<img width="2040" height="1536" alt="eagle 1" src="https://github.com/user-attachments/assets/70fef8a8-557d-4aeb-8782-595593fd9553" />
<img width="2040" height="1536" alt="eagle 2" src="https://github.com/user-attachments/assets/1c38c6c7-513c-4c27-90b1-ab8a3f96f977" />

