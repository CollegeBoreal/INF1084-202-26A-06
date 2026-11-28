

TP02 – Active Directory : administrateur local

Nom et prénom : Bouzidi Ouahiba

Matricule : 300157606


INTRODUCTION

	L’objectif de ce travail pratique est de créer un utilisateur local portant mon matricule et de lui attribuer les droits d’administration locale à l’aide de PowerShell. En raison du problème d’accès à mon serveur Windows Server 2022, j’ai effectué les manipulations sur mon ordinateur Windows 11 Professionnel. Cette solution de remplacement reste à faire valider par le professeur.



CAPTURE 1 – Vérification du système

<img width="2000" height="1500" alt="1" src="https://github.com/user-attachments/assets/da47828c-0bab-4293-a9c0-a30c6b680da2" />


Commandes :
hostname
whoami
Get-LocalUser
Get-CimInstance Win32_OperatingSystem | Select-Object Caption


Explication : J’ai ouvert PowerShell en tant qu’administrateur. La commande hostname affiche DESKTOP-Q40N5PE. La commande whoami identifie mon compte DELL. Get-LocalUser affiche les comptes locaux existants. La dernière commande confirme que le système utilisé est Microsoft Windows 11 Professionnel.



CAPTURE 2 – Création de l’utilisateur local

<img width="2000" height="1500" alt="2" src="https://github.com/user-attachments/assets/2e8040de-fdf9-4322-92da-3effb34dfc7c" />


Commandes :
$Password = Read-Host "Entrer le mot de passe" -AsSecureString
New-LocalUser -Name "300157606" -Password $Password -FullName "Bouzidi Ouahiba" -Description "TP02 Administrateur local"


Explication : J’ai saisi un mot de passe confidentiel avec Read-Host et AsSecureString. Ensuite, j’ai créé un compte local portant mon matricule. Le résultat Enabled = True confirme que le compte était activé lors de sa création.



CAPTURE 3 – Vérification et attribution des droits

<img width="2000" height="1500" alt="3" src="https://github.com/user-attachments/assets/952254c8-5790-4db8-826e-c73c6e806413" />



		 				Vérification de l’utilisateur

Get-LocalUser -Name "300157606"

Cette commande confirme que le compte local existe et qu’il était activé au moment de la vérification.



	    			Attribution des droits d’administration

Add-LocalGroupMember -Group "Administrateurs" -Member "300157606"

J’ai ajouté le compte au groupe Administrateurs local. Le nom du groupe est en français, car mon système est en français. La commande s’est exécutée sans erreur.



	   				 Vérification du groupe Administrateurs

Get-LocalGroupMember -Group "Administrateurs"

Le résultat affiche DESKTOP-Q40N5PE\300157606 parmi les membres du groupe. La colonne PrincipalSource indique Local. Cela confirme que le compte dispose des droits d’administration locale et qu’il ne s’agit pas d’un compte Active Directory.




CONCLUSION

	Ce travail m’a permis de créer un utilisateur local, de lui attribuer les droits d’administration et de vérifier son appartenance au groupe Administrateurs à l’aide de PowerShell. Les captures démontrent la réussite des manipulations sur Windows 11 Professionnel. La réalisation sur Windows Server 2022 et la connexion RDP n’ont pas pu être vérifiées en raison du problème d’accès au serveur.
