
Laboratoire : Partage de ressources et accès RDP via PowerShell
 Nom : Mouhamad Al Bachir Konate
 Numéro étudiant : 300157733

 Laboratoire : Partage de ressources et RDP via PowerShell
Introduction

Ce laboratoire avait pour objectif d'utiliser PowerShell pour administrer un environnement Active Directory. Les principales tâches consistaient à créer un groupe et des utilisateurs, configurer un partage réseau SMB, déployer une stratégie de groupe (GPO) et préparer l'accès à distance par Bureau à distance (RDP).

Réalisation

J'ai d'abord vérifié que les modules ActiveDirectory et GroupPolicy étaient disponibles sur le contrôleur de domaine. Ensuite, j'ai créé mon dossier étudiant 300157733 afin d'y enregistrer les scripts du laboratoire.

À l'aide du script utilisateurs1.ps1, j'ai créé le groupe Students, les comptes Etudiant1 et Etudiant2, puis je les ai ajoutés au groupe. J'ai également créé et partagé le dossier SharedResources pour permettre l'accès aux ressources du réseau.

Par la suite, j'ai configuré une stratégie de groupe nommée GPO-Students-Drive. Cette GPO a été liée à l'unité organisationnelle Students afin de permettre le mappage automatique d'un lecteur réseau vers le partage SharedResources.

Finalement, différentes vérifications ont été effectuées afin de confirmer la création des utilisateurs, les permissions du partage SMB, les droits d'accès du groupe Students et la bonne création de la GPO.

Conclusion

Ce laboratoire m'a permis de pratiquer l'administration d'Active Directory avec PowerShell. J'ai appris à créer des groupes et des utilisateurs, configurer un partage réseau, attribuer des permissions et déployer une stratégie de groupe. Cette approche permet d'automatiser et de simplifier l'administration d'un environnement Windows Server.

1. Vérification des prérequis

<img width="1200" height="1600" alt="image" src="https://github.com/user-attachments/assets/6af92ac6-f129-472a-91e8-cd18a193c361" />

2. Création du répertoire étudiant
<img width="1200" height="1600" alt="image" src="https://github.com/user-attachments/assets/6af92ac6-f129-472a-91e8-cd18a193c361" />

Le dossier portant mon identifiant étudiant 300157733 a été créé pour contenir les scripts du laboratoire.

3. Création du script utilisateurs1.ps1

<img width="1200" height="1600" alt="image" src="https://github.com/user-attachments/assets/a603827f-cebe-4503-9aed-cd0464d900d0" />
 - Édition du script utilisateurs1.ps1 permettant la création des utilisateurs, du groupe Students et du partage SMB.

4. Exécution du script utilisateurs1.ps1

<img width="1200" height="1600" alt="image" src="https://github.com/user-attachments/assets/53cd2ef2-977a-4408-ac53-a24eb13fdbf0" />


   - Exécution du script utilisateurs1.ps1 et création du groupe Students ainsi que du partage SharedResources.

5. Vérification des utilisateurs et permissions
<img width="1200" height="1600" alt="image" src="https://github.com/user-attachments/assets/a6835e9d-c5ca-455c-af00-5b59a0c74a52" />
- Vérification des membres du groupe Students et des permissions du partage SharedResources.

6. Création de la GPO
   <img width="1200" height="1600" alt="image" src="https://github.com/user-attachments/assets/be666acc-b114-4b33-a667-1c3864352814" />

 Création de la stratégie de groupe GPO-Students-Drive et liaison à l'unité organisationnelle Students.

7. Configuration du script de connexion
<img width="1200" height="1600" alt="image" src="https://github.com/user-attachments/assets/88c4c53a-ed45-4af9-b067-1e723ae06211" />

 Déploiement du script de connexion pour le mappage automatique du lecteur réseau.

8. Rapport de la GPO


<img width="1200" height="1600" alt="image" src="https://github.com/user-attachments/assets/5c307ea2-7ab8-4c4d-84a3-af89d786c281" />

Rapport de la stratégie de groupe démontrant la création de la GPO et son association à l'OU Students.

9. Détails du rapport GPO

<img width="1200" height="1600" alt="image" src="https://github.com/user-attachments/assets/319ece74-8bd8-4963-940c-f84296a2d066" />


    
   
   
