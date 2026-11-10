
Active Directory – Windows Server 2022

Étudiant : Youcef Laziz

Matricule : 300160424

Cours : Administration Windows

1. Objectif
   
Le but de ce laboratoire est de créer un utilisateur dans Active Directory à l’aide de PowerShell, de lui attribuer les droits d’administration et de vérifier que la configuration fonctionne.

2. Environnement de travail

Système : Windows Server 2022 Datacenter
Adresse IP du serveur : 10.7.237.229
Nom du serveur : SRV300160424
Domaine: DC300160424.local
Outil utilisé: Windows PowerShell

3. Vérification du domaine

J’ai vérifié les informations du domaine Active Directory avec la commande suivante :
Get-ADDomain
Le résultat indique que le domaine DC300160424.local existe et que le serveur SRV300160424 est son contrôleur de domaine.

 <img width="855" height="772" alt="image" src="https://github.com/user-attachments/assets/1a66e925-f9af-4d66-b96e-e4144befd705" />

Capture 1 – Informations du domaine Active Directory

4. Création de l’utilisateur

J’ai d’abord vérifié que mon matricule n’existait pas déjà dans Active Directory :
Get-ADUser -Filter "SamAccountName -eq '300160424'"
La commande n’a retourné aucun utilisateur. J’ai ensuite saisi un mot de passe de manière sécurisée, sans l’écrire directement dans la commande :
$mdp = Read-Host "Mot de passe de Youcef" -AsSecureString
J’ai créé le compte Youcef dans le conteneur Users du domaine :
New-ADUser -Name "Youcef" -SamAccountName "300160424" -UserPrincipalName "300160424@DC300160424.local" -Path "CN=Users,DC=DC300160424,DC=local" -AccountPassword $mdp -Enabled $true
Pour confirmer la création, j’ai exécuté :
Get-ADUser -Identity "300160424"
Le résultat montre que le compte Youcef existe et que son état Enabled est True.

<img width="855" height="830" alt="image" src="https://github.com/user-attachments/assets/3f5ffa1c-6704-40af-a77b-583fcf494a9c" />

Capture 2 – Utilisateur Youcef créé et activé

5. Attribution des droits d’administration
   
J’ai ajouté le compte 300160424 au groupe Administrators intégré au domaine avec cette commande :
Add-ADGroupMember -Identity "S-1-5-32-544" -Members "300160424"
La première commande de vérification Get-ADGroupMember a affiché une erreur. J’ai donc utilisé une autre commande pour afficher les groupes du compte :
Get-ADPrincipalGroupMembership -Identity "300160424" | Select-Object Name
Le résultat affiche Domain Users et Administrators. Cela confirme l’appartenance au groupe des administrateurs.

 <img width="870" height="492" alt="image" src="https://github.com/user-attachments/assets/0e85f79d-1298-42ab-a225-fb34dd649f07" />

Capture 3 – Vérification des groupes de Youcef

6. Vérification finale

Pour terminer, j’ai vérifié le nom du compte, son matricule, son activation et son appartenance au groupe Administrators :
Get-ADUser -Identity "300160424" -Properties Enabled,MemberOf | Select-Object Name,SamAccountName,Enabled,MemberOf
Le compte est activé et MemberOf indique CN=Administrators,CN=Builtin,DC=DC300160424,DC=local.

 <img width="870" height="404" alt="image" src="https://github.com/user-attachments/assets/fb0f4a87-bd27-493d-97c0-8645eebdcbf4" />

Capture 4 – Vérification finale du compte et des droits

7. Conclusion
   
Dans ce laboratoire, j’ai utilisé PowerShell pour vérifier mon domaine Active Directory et créer mon utilisateur Youcef avec le matricule 300160424. J’ai ensuite ajouté mon compte au groupe Administrators. Les vérifications montrent que le compte est activé et qu’il appartient au bon groupe. J’ai ainsi réalisé l’objectif demandé. Je n’ai pas effectué de test de connexion avec ce nouveau compte.

