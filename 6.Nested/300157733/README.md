Rapport de laboratoire 6 - Architecture simplifiée Hyper‑V et Active Directory

Nom : Mouhamad Al Bachir Konate
 Cours : INF1084
 Laboratoire : 6.Nested - Architecture simplifiée (1 étudiant = 1 forêt = 1 sous-réseau)

Objectif

L'objectif de ce laboratoire était de créer une infrastructure Active Directory isolée à l'aide d'Hyper‑V comprenant :

un réseau privé NAT;
un contrôleur de domaine Active Directory;
un client Windows;
un domaine Active Directory fonctionnel;
un utilisateur du domaine capable de se connecter au client.
Configuration du serveur hôte
Serveur parent
Élément	Valeur
Nom du serveur	SRV300157733
Adresse IP	10.7.237.218
Hyper‑V	Activé
Configuration du réseau privé
NAT Hyper‑V
Élément	Valeur
Réseau privé	172.16.18.0/24
Passerelle NAT	172.16.18.1
Nom NAT	LABNAT

Commandes utilisées :

PowerShell
New-NetIPAddress -IPAddress 172.16.18.1 -PrefixLength 24 -InterfaceAlias "vEthernet (Internal)"
PowerShell
New-NetNat -Name LABNAT -InternalIPInterfaceAddressPrefix 172.16.18.0/24
Création des machines virtuelles
Contrôleur de domaine
Paramètre	Valeur
Nom	DC300157733
Mémoire	4 Go
Disque	60 Go
Client
Paramètre	Valeur
Nom	CLIENT01
Mémoire	4 Go
Disque	60 Go
Configuration du contrôleur de domaine
Paramètres réseau
Paramètre	Valeur
Adresse IP	172.16.18.10
Masque	255.255.255.0
Passerelle	172.16.18.1
DNS	172.16.18.10
Installation Active Directory

Installation du rôle Active Directory :

PowerShell
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools

Création de la forêt :

PowerShell
Install-ADDSForest -DomainName DC300157733.local
Vérification du domaine

Commande :

PowerShell
Get-ADDomain

Résultat :

Plain Text
DC300157733.local

Commande :

PowerShell
Get-ADForest

Résultat :

Plain Text
RootDomain : DC300157733.local
Configuration du client
Paramètres réseau
Paramètre	Valeur
Nom	CLIENT01
Adresse IP	172.16.18.20
Masque	255.255.255.0
Passerelle	172.16.18.1
DNS	172.16.18.10
Ajout du client au domaine

Commande utilisée :

PowerShell
Add-Computer -DomainName DC300157733.local -Credential DC300157733LAB\Administrator -Restart

Résultat :

CLIENT01 a rejoint le domaine.
Le redémarrage s'est effectué avec succès.
Création d'un utilisateur Active Directory

Création du compte utilisateur :

PowerShell
New-ADUser -Name "Mouhamad Konate" -SamAccountName mkonate -UserPrincipalName mkonate@DC300157733.local -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) -Enabled $true

Informations du compte :

Paramètre	Valeur
Nom	Mouhamad Konate
SamAccountName	mkonate
UPN	mkonate@DC300157733.local
État	Activé
Test d'authentification

Connexion réussie sur CLIENT01 avec :

Plain Text
Utilisateur : mkonate
Mot de passe : Pass123!

Vérification :

PowerShell
whoami

Résultat :

Plain Text
dc300157733lab\mkonate

Vérification du domaine :

PowerShell
systeminfo | findstr /I "Domain"

Résultat :

Plain Text
Domain : DC300157733.local
Conclusion

Le laboratoire a été réalisé avec succès. Une forêt Active Directory, un domaine, un serveur DNS, un réseau NAT Hyper‑V, un contrôleur de domaine et un client membre du domaine ont été configurés. L'utilisateur Active Directory créé a pu s'authentifier correctement sur le poste client, démontrant le bon fonctionnement de l'infrastructure Active Directory.



<img width="1536" height="2048" alt="image" src="https://github.com/user-attachments/assets/521f267d-e5df-47fa-8bd8-269639430175" />

<img width="1536" height="2048" alt="image" src="https://github.com/user-attachments/assets/5c48d98c-68a0-4365-b385-89fbb2457665" />

<img width="1536" height="2048" alt="image" src="https://github.com/user-attachments/assets/beff0da0-f9d6-4ac8-b666-16912e4023d5" />

<img width="1536" height="2048" alt="image" src="https://github.com/user-attachments/assets/d2bf65d2-0100-4839-9290-65c5aa6c3833" />


<img width="1536" height="2048" alt="image" src="https://github.com/user-attachments/assets/8c38488a-9dce-4e0b-980a-c9ca4af62ef9" />

<img width="737" height="677" alt="image" src="https://github.com/user-attachments/assets/9ee3d56a-9dc5-4bf7-a477-a87e0e7d8580" />
<img width="753" height="710" alt="image" src="https://github.com/user-attachments/assets/cc86b83f-916f-4f26-842c-a1f19a2bb494" />

<img width="750" height="623" alt="image" src="https://github.com/user-attachments/assets/461d899b-06bc-45db-b17a-231cc73de9f4" />


