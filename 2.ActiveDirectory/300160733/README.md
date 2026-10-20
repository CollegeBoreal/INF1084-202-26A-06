Vérification du serveur et du domaine :

Vérification de l’utilisateur connecté, du nom du serveur et des informations du domaine Active Directory avec les commandes whoami, hostname et Get-ADDomain.

<img width="1188" height="1016" alt="image" src="https://github.com/user-attachments/assets/c0c94e54-a667-4565-80c2-a4b4afb2a8b2" />

Création de l’utilisateur :

Création de l’utilisateur B300160733 dans Active Directory avec PowerShell, puis vérification que le compte est bien créé et activé.

<img width="1076" height="1011" alt="image" src="https://github.com/user-attachments/assets/23638cfa-a81d-4224-8261-8e3893384138" />

Ajout des droits administrateur :

Ajout de l’utilisateur B300160733 au groupe Domain Admins, puis vérification de son appartenance au groupe.

<img width="1036" height="1024" alt="image" src="https://github.com/user-attachments/assets/b903245d-8f43-45b0-b87e-4b668c4a0c4a" />

Vérification finale :

Vérification finale de l’utilisateur B300160733. Le compte est actif avec Enabled = True et possède les droits administrateur grâce au groupe Domain Admins.

<img width="1040" height="987" alt="image" src="https://github.com/user-attachments/assets/72909a98-7407-441a-9221-3a6612d34d69" />
