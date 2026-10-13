Le serveur utilisé est un G6 avec le numéro de série MXQ00309PP et l’adresse IP 10.7.237.7. Il fonctionne sous Windows Server 2022 Datacenter et possède 64 Go de RAM, 16 CPU, un disque de 273,4 Go et un espace de stockage NVMe supplémentaire de 1 To. Le compte à créer porte le nom 300157727.J’ai lancé Windows PowerShell avec les droits d’administrateur afin de pouvoir créer le compte utilisateur et gérer ses autorisations sur le serveur.<img width="890" height="605" alt="Capture d&#39;écran 2026-09-29 114012" src="https://github.com/user-attachments/assets/390079cc-ab7b-4214-9c65-d24adacdc26d" />
J’ai exécuté la commande suivante pour créer mon compte utilisateur local
New-LocalUser -Name "300157727" -FullName "300157727" -Description "Compte administrateur" -Password (Read-Host "Mot de passe" -AsSecureString)
Cette commande permet de créer un compte portant mon identifiant étudiant 300157727 et de configurer son mot de passe de façon sécurisée.<img width="814" height="589" alt="Capture d&#39;écran 2026-09-29 120428" src="https://github.com/user-attachments/assets/a798e0b9-cccf-4937-8e04-9465b8312581" />
J’ai utilisé la commande suivante pour ajouter mon compte au groupe des administrateurs :
Add-LocalGroupMember -Group "Administrators" -Member "300157727"
Cette commande permet d’accorder au compte 300157727 les autorisations nécessaires pour effectuer des opérations d’administration sur le serveur.
Pour confirmer que mon compte a bien été créé, j’ai exécuté la commande suivante :
Get-LocalUser -Name "300157727"
Cette commande affiche les informations du compte afin de vérifier qu’il existe bien sur le serveur.<img width="712" height="394" alt="Capture d&#39;écran 2026-09-29 120440" src="https://github.com/user-attachments/assets/18bac1c4-4e23-4cb3-98f9-6b46b7965b06" />
Pour vérifier les autorisations de mon compte, j’ai exécuté la commande suivante :
Get-LocalGroupMember -Group "Administrators"
Cette commande affiche les utilisateurs qui font partie du groupe Administrators. J’ai ainsi pu vérifier si mon compte 300157727 figure dans la liste des administrateurs du serveur.<img width="790" height="599" alt="Capture d&#39;écran 2026-09-29 120625" src="https://github.com/user-attachments/assets/aecf6cbc-99d2-4154-b0bd-7e8227cd5c94" />
Le compte utilisateur 300157727 a été créé sur le serveur Windows Server 2022 Datacenter. Il a ensuite été ajouté au groupe Administrators afin de lui permettre d’effectuer les tâches qui nécessitent des droits d’administrateur.



