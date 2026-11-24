Laboratoire – Création d’un administrateur local

Étudiant : Youcef Laziz

Matricule : 300160424

Cours : INF1084 – Administration Windows

1. Objectif

Le but de ce laboratoire est de créer un utilisateur local avec PowerShell, de lui donner les droits d’administration locale et de vérifier son appartenance au groupe Administrators.

2. Environnement de travail
   
Serveur hôte : SRV300160424 (10.7.237.229)
Machine virtuelle Hyper-V : SRV01
Nom Windows : TEMPLATE_VM
Système : Windows Server 2022 Standard Evaluation
Outil : Windows PowerShell ISE en tant qu’administrateur
Mon serveur principal est déjà un contrôleur de domaine. J’ai utilisé SRV01 pour créer un compte local sans modifier Active Directory.

3. Vérification de la machine
   
hostname
(Get-CimInstance Win32_ComputerSystem).DomainRole
(Get-CimInstance Win32_OperatingSystem).Caption
Le résultat 2 indique que la machine est un serveur autonome.

<img width="1123" height="514" alt="image" src="https://github.com/user-attachments/assets/ac82f2b5-f70c-494e-a75e-d5e26b595227" />

Capture 1 – Vérification du système et du rôle du serveur.

 4. Vérification des utilisateurs locaux

Get-LocalUser
Mon matricule ne figure pas encore dans la liste des utilisateurs locaux.

 <img width="1125" height="547" alt="image" src="https://github.com/user-attachments/assets/235e99e9-abc4-4d1c-aca0-37e2ff49200d" />

Capture 2 – Liste des utilisateurs locaux avant la création.

5. Création de l’utilisateur local

J’ai saisi un mot de passe sécurisé et créé mon compte avec mon matricule.
$Password = Read-Host "Entrer le mot de passe pour 300160424" -AsSecureString
New-LocalUser -Name "300160424" -Password $Password -FullName "Youcef Laziz" -Description "Compte administrateur local"
Get-LocalUser -Name "300160424"
Le résultat True confirme que le compte est activé.

 <img width="1142" height="547" alt="image" src="https://github.com/user-attachments/assets/4e2c2984-a62f-4dc1-9559-aa3803306b12" />
 
Capture 3 – Création et vérification du compte local.

6. Attribution des droits d’administration locale
   
J’ai ajouté mon compte au groupe Administrators et vérifié les membres du groupe.
Add-LocalGroupMember -Group "Administrators" -Member "300160424"
Get-LocalGroupMember -Group "Administrators"
Le compte TEMPLATE_VM\300160424 apparaît dans le groupe avec la source Local.

 <img width="1129" height="547" alt="image" src="https://github.com/user-attachments/assets/23eee075-425e-447d-8b1c-f74f185641f5" />
 
Capture 4 – Vérification de l’appartenance au groupe Administrators.

7. Vérification finale

Get-LocalUser -Name "300160424" | Format-List Name,FullName,Enabled,PrincipalSource
Le résultat affiche mon nom, Enabled : True et PrincipalSource : Local. Le compte est bien local.

  <img width="1102" height="547" alt="image" src="https://github.com/user-attachments/assets/f6c423bf-5f0e-4346-bafa-260b8aa1325c" />

Capture 5 – Confirmation du type de compte Local.

8. Conclusion
   
Dans ce laboratoire, j’ai utilisé PowerShell pour créer mon utilisateur local 300160424 et l’ajouter au groupe Administrators. Les vérifications montrent que le compte est activé et possède les droits d’administration locale. Je n’ai pas effectué de test de connexion avec ce nouveau compte.

