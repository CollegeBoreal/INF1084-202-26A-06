LABORATOIRE 5 – OBJETS ACTIVE DIRECTORY, PARTAGE ET RDP

Nom et prénom : Mekaouche Mazigh
Numéro d'étudiant : 300159693
Système d'exploitation : Windows Server 2022
Domaine Active Directory : DC300159693.local
Groupe Active Directory : Students
Unité d'organisation : Students
Dossier partagé : SharedResources
GPO : MapSharedFolder
Lecteur réseau : Z:
Date : 10 novembre 2026
1. Objectif du laboratoire
L'objectif de ce laboratoire est de manipuler les différents objets d'Active Directory à l'aide de PowerShell et de mettre en place un environnement permettant la gestion centralisée des utilisateurs, des groupes et des ressources réseau.
Les opérations réalisées durant ce laboratoire sont les suivantes :
Créer une unité d'organisation (OU) nommée Students.
Créer un groupe Active Directory nommé Students.
Créer deux comptes utilisateurs et les ajouter au groupe.
Créer un dossier partagé nommé SharedResources.
Configurer les permissions NTFS et SMB.
Créer une stratégie de groupe (GPO) nommée MapSharedFolder.
Configurer le mappage automatique du lecteur réseau Z:.
Activer le Bureau à distance (RDP).
Autoriser le groupe Students à utiliser le Bureau à distance.
Effectuer des tests pour vérifier le fonctionnement des configurations.
 Préparation de l'environnement
Le laboratoire a été réalisé sur un serveur Windows Server 2022 avec le rôle Active Directory Domain Services (AD DS) installé et configuré.

Le domaine utilisé est :

DC300159693.local

Les modules PowerShell utilisés sont :

ActiveDirectory

GroupPolicy
<img width="1536" height="2048" alt="9185908c-2cc7-492d-86a3-2831986750bd" src="https://github.com/user-attachments/assets/fa7931e8-f0cd-4b01-acda-ac78bc091c06" />

3. Création des utilisateurs et du groupe Active Directory

Une unité d'organisation nommée Students a été utilisée pour organiser les comptes étudiants.

Un groupe de sécurité global nommé Students a été créé afin de gérer les autorisations d'accès aux ressources partagées et au Bureau à distance.

Deux comptes utilisateurs ont été créés et ajoutés à ce groupe.

3.1 Informations des comptes utilisateurs
Paramètre
Étudiant 1
Étudiant 2
Nom du compte
Etudiant1
Etudiant2
Identifiant de connexion
DC300159693\Etudiant1
DC300159693\Etudiant2
Groupe
Students
Students
Mot de passe initial
Pass123!
Pass123!
État du compte
Activé
Activé

Les deux comptes ont été créés avec un mot de passe initial identique. Le groupe Students permet de gérer leurs autorisations de manière centralisée.
<img width="1536" height="2048" alt="c63a36b2-ccfc-4551-a249-787133534ac3" src="https://github.com/user-attachments/assets/b05b3a5b-caa2-444a-af9c-ad5e1488e2b9" />
<img width="1536" height="2048" alt="55e4d1b5-a968-43b1-b31c-8f2e9d43a1a3" src="https://github.com/user-attachments/assets/364166a2-8643-4c29-9bae-3f8656d41190" />
4. Création du dossier partagé
Un dossier nommé SharedResources a été créé sur le serveur dans le chemin suivant :
C:\SharedResources
Un partage SMB a ensuite été configuré afin de permettre au groupe Students d'accéder aux ressources partagées.
Les permissions NTFS et SMB ont été vérifiées à l'aide des commandes PowerShell.
Création du dossier SharedResources, configuration du partage SMB et attribution des permissions NTFS au groupe Students.
<img width="1536" height="2048" alt="2ec2126f-c4a8-4010-b114-b9046afb7a1a" src="https://github.com/user-attachments/assets/717b82eb-8e9c-4289-8594-17c06e616ff1" />
<img width="1536" height="2048" alt="928d1a71-dd28-4000-8ff2-1ce356106746" src="https://github.com/user-attachments/assets/44337ac4-d0b7-41d9-942d-01b0d22ec603" />
5. Configuration de la stratégie de groupe (GPO)
Une stratégie de groupe nommée MapSharedFolder a été créée dans Active Directory.
Cette GPO permet de configurer le mappage automatique d'un lecteur réseau pour les utilisateurs concernés.
Le lecteur réseau utilisé est Z:, associé au partage :
\\DC300159693.local\SharedResources
Le lecteur Z: a été retrouvé dans l'Explorateur de fichiers Windows lors du test avec le compte étudiant.
<img width="1536" height="2048" alt="f3ccb12e-5a3f-47b9-b6ca-85ddb6027256" src="https://github.com/user-attachments/assets/b166ca31-5416-481a-8a1f-77d2611463b5" />
Gestion des stratégies de groupe (GPO)
<img width="2048" height="1536" alt="c076bd95-45dc-4410-8291-6df237d964c8" src="https://github.com/user-attachments/assets/6cc25ed0-90e6-46b2-8261-5e9b2c9294dc" />
Configuration du lecteur réseau Z:
<img width="1536" height="2048" alt="c59890fe-7f28-4d74-81a5-9544c4e48fe6" src="https://github.com/user-attachments/assets/01e31a82-fc5a-4c1f-93fa-cb4f7c0a084b" />
6. Activation du Bureau à distance (RDP)
Le Bureau à distance a été activé sur le serveur Windows Server 2022.
Les règles correspondantes du pare-feu Windows ont également été activées.
Le groupe Students a été ajouté au groupe intégré Remote Desktop Users dans Active Directory.
Le droit d'ouverture de session par les Services Bureau à distance a ensuite été vérifié avec la commande secedit.
La commande gpupdate /force a permis d'actualiser les stratégies.
<img width="1536" height="2048" alt="b7f0f160-4ef7-48f3-a879-1fddd43c70ed" src="https://github.com/user-attachments/assets/68bc70e1-ffd9-43e2-95f7-cfe318821694" />
<img width="1536" height="2048" alt="55e4d1b5-a968-43b1-b31c-8f2e9d43a1a3" src="https://github.com/user-attachments/assets/66048c02-5089-428a-bffd-f0394112bb27" />
<img width="1536" height="2048" alt="da261b5d-b3c5-46c6-9d51-d8cf3783a27a" src="https://github.com/user-attachments/assets/9d097711-0e21-4b76-87c8-716b28ff2387" />
<img width="1536" height="2048" alt="8851dac7-8f44-4814-9236-6041e52f17d5" src="https://github.com/user-attachments/assets/171cb914-ae3f-4c7c-a109-48fd7e43e260" />
7.1 Tableau récapitulatif des tests
N°	Test effectué	Résultat attendu	Résultat obtenu
1	Vérification du groupe Students	Etudiant1 et Etudiant2 sont présents	Réussi
2	Vérification du partage SMB	Le partage SharedResources est accessible au groupe Students	Réussi
3	Vérification des permissions NTFS	Le groupe Students possède les permissions nécessaires	Réussi
4	Vérification de la GPO MapSharedFolder	La GPO est créée et configurée	Réussi
5	Vérification du lecteur réseau Z:	Le lecteur Z: pointe vers SharedResources	À confirmer
6	Activation du Bureau à distance	Le service RDP est activé	Réussi
7	Vérification des autorisations RDP	Le groupe Students est autorisé à utiliser RDP	Réussi
8	Connexion RDP avec Etudiant1	L'utilisateur peut ouvrir une session à distance	Réussi
8. Conclusion
Ce laboratoire m'a permis de mettre en pratique la gestion des objets Active Directory à l'aide de PowerShell. J'ai appris à créer et organiser des utilisateurs et des groupes, à configurer un dossier partagé avec les permissions nécessaires et à mettre en place une GPO pour automatiser le mappage d'un lecteur réseau.
J'ai également appris à activer le Bureau à distance et à attribuer les autorisations nécessaires à un groupe d'utilisateurs. Après plusieurs vérifications et corrections, j'ai réussi à établir une connexion RDP avec le compte Etudiant1.
Ce travail m'a permis de mieux comprendre l'administration centralisée d'un domaine Windows Server 2022 et l'importance des groupes, des permissions et des stratégies de groupe dans un environnement informatique.




