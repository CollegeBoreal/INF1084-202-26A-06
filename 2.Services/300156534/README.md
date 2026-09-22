Documentation – Création d’un compte administrateur
Windows Server 2022
1. Objectif
L’objectif de ce laboratoire est de créer un compte utilisateur local sur un serveur Windows Server 2022 Datacenter et de lui attribuer les droits d’administration.
2. Informations du serveur
Élément	Information
Serveur	G6
Numéro de série	MXQ00309PP
Adresse IP	10.7.237.7
Système d’exploitation	Windows Server 2022 Datacenter
RAM	64 Go
CPU	16
Disque	273,4 Go
NVMe supplémentaire	1 To
Nom du compte	300156534
3. Ouverture de PowerShell
J’ai ouvert Windows PowerShell en tant qu’administrateur afin d’avoir les permissions nécessaires pour créer et modifier les comptes utilisateurs.
4. Création du compte utilisateur
J’ai utilisé la commande suivante :
New-LocalUser -Name "300156534" -FullName "300156534" -Description "Compte administrateur" -Password (Read-Host "Mot de passe" -AsSecureString)
Cette commande permet de créer un compte local nommé 300156534 et de définir son mot de passe de manière sécurisée.
5. Attribution des droits administrateur
J’ai ajouté le compte au groupe des administrateurs avec la commande :
Add-LocalGroupMember -Group "Administrators" -Member "300156534"
Le compte 300156534 possède ainsi les droits nécessaires pour effectuer des tâches d’administration sur le serveur.
6. Vérification du compte
Pour vérifier que le compte a bien été créé, j’ai utilisé :
Get-LocalUser -Name "300156534"
7. Vérification des droits
Enfin, j’ai vérifié l’appartenance au groupe des administrateurs :
Get-LocalGroupMember -Group "Administrators"
Le compte 300156534 apparaît dans la liste des membres du groupe Administrators.
8. Conclusion
La création du compte 300156534 a été effectuée avec succès sur le serveur Windows Server 2022 Datacenter. Le compte a également été ajouté au groupe Administrators, ce qui lui permet d’effectuer les opérations nécessitant des privilèges administratifs.

