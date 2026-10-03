Compte Rendu de Laboratoire : Installation et Configuration d’un Domaine Active Directory (AD DS)
Étudiant : ID 300159203

Système d'exploitation : Windows Server 2022

Nom du serveur : SRV300159203

Nom du domaine (FQDN) : DC300159203.local

Nom NetBIOS : DC300159203  

1. Objectif du Laboratoire
L'objectif de ce laboratoire est de configurer de A à Z un contrôleur de domaine (DC) Active Directory sous Windows Server 2022 en utilisant exclusivement des commandes PowerShell. Les travaux incluent la préparation de l'hôte, l'installation des rôles requis, la promotion en contrôleur de domaine, la vérification des services réseau et la validation des consoles d'administration.

Étape 1 : Vérification du nom d'hôte
<img width="980" height="269" alt="image" src="https://github.com/user-attachments/assets/871fbbc2-5483-4878-808c-a636d2a3e8db" />  
<img width="1222" height="234" alt="image" src="https://github.com/user-attachments/assets/c82586c0-e599-4901-8eaf-bd064df81f7f" />  

Étape 2 : Installation du rôle Active Directory Domain Services
<img width="1167" height="453" alt="image" src="https://github.com/user-attachments/assets/98414fa9-fe0b-4dbc-975b-69d7def1439f" />  
Le rôle AD DS ainsi que les outils d'administration RSAT (dont la console MMC et le module PowerShell Active Directory) ont été installés avec succès sur le serveur  
Étape 3 : Promotion du serveur et création de la forêt Active Directory  
<img width="1233" height="488" alt="image" src="https://github.com/user-attachments/assets/598caaf6-3843-4f18-b000-5ceb0d93e3e8" />  
Résultat : Validation de l'environnement réussie ("All tests completed successfully"), création du domaine racine DC300159203.local et redémarrage automatique du système.  
Analyse : Le serveur est promu au rang de premier contrôleur de domaine de la forêt avec le rôle DNS intégré.  

Étape 4 : Vérification de la configuration du domaine et de la forêt  
<img width="984" height="898" alt="image" src="https://github.com/user-attachments/assets/7b96cee1-e51a-4dab-9108-c7d90beb4dc1" />  
La base de données Active Directory est pleinement opérationnelle et héberge l'ensemble des 5 rôles FSMO.  
Étape 5 : Vérification des partages réseau AD  
<img width="1343" height="417" alt="image" src="https://github.com/user-attachments/assets/c9937a0e-4ce0-44a4-aece-b98729274689" />  
La publication SMB des dossiers de réplication et de scripts de connexion fonctionne correctement  
Étape 6 : Diagnostic du domaine et contrôle du dossier SYSVOL  
<img width="1313" height="428" alt="image" src="https://github.com/user-attachments/assets/d21c02c0-a277-4831-b918-3d246a5e2459" />  
Étape 7 : Ouverture de la console d'administration  
<img width="1375" height="1097" alt="image" src="https://github.com/user-attachments/assets/ae1c1f8c-ce57-4edd-b2df-8f60c0ffe792" />  
Lancement réussi de la console graphique Active Directory Users and Computers (Utilisateurs et ordinateurs Active Directory).  
L'installation et la configuration du domaine Active Directory DC300159203.local sur le serveur SRV300159203 sont 100 % réussies et valides. Les services d'annuaire (AD DS), de résolution de noms (DNS) et de partage d'infrastructure (SYSVOL/NETLOGON) sont parfaitement fonctionnels.






