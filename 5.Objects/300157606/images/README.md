
TP05 – Automatisation de la gestion des utilisateurs et des ressources partagées


Nom : Bouzidi Ouahiba


Matricule : 300157606


Date : 24 novembre 2026



Introduction

	Ce travail pratique consiste à administrer un environnement Active Directory avec PowerShell. L’objectif est de créer des comptes étudiants, de gérer leur appartenance à un groupe, de partager un dossier et de configurer une stratégie de groupe (GPO) pour rendre accessible un lecteur réseau Z: à la connexion. Les tests réalisés avec les deux comptes permettent de vérifier l’accès à distance et les opérations sur les fichiers partagés.



Environnement : serveur SRV300157606, domaine DC300157606.local, adresse IP 10.7.237.216, dossier de travail C:, groupe et unité d’organisation Students, partage SharedResources.


Déroulement et preuves visuelles


Préparation du serveur et des scripts



Capture 01 – Connexion au serveur

<img width="2000" height="1500" alt="1" src="https://github.com/user-attachments/assets/0157cfa4-262b-4b1a-ba8b-44eb9899f300" />

La fenêtre Bureau à distance permet de préparer la connexion au serveur Windows.



Capture 02 – Informations du domaine

<img width="2000" height="1500" alt="2" src="https://github.com/user-attachments/assets/3256da61-f1fe-48a5-9d60-58ae7c596040" />


PowerShell affiche les propriétés du domaine Active Directory, utiles pour identifier l’environnement de travail.



Capture 03 – Préparation du répertoire

<img width="2000" height="1500" alt="3" src="https://github.com/user-attachments/assets/54525785-9698-4ada-81da-f4619f519207" />


Création et organisation du dossier C: et du sous-dossier images.



Capture 04 – Préparation des fichiers

<img width="2000" height="1500" alt="4" src="https://github.com/user-attachments/assets/a07dab61-64e8-4850-8e93-56f122812aac" />


Les commandes PowerShell permettent de préparer les fichiers nécessaires au travail et à sa documentation.



Capture 05 – Édition du script bootstrap

<img width="2000" height="1500" alt="5" src="https://github.com/user-attachments/assets/811da737-e85a-43de-b290-3c7231c5b379" />

Ouverture du Bloc-notes pour préparer bootstrap.ps1.



Capture 06 – Authentification

<img width="2000" height="1500" alt="6" src="https://github.com/user-attachments/assets/e42e77e6-6eed-4ec4-80b8-70f94de2d1f6" />


La fenêtre de demande d’identifiants permet de saisir les informations d’authentification de l’administrateur.



Capture 07 – Vérification des variables

<img width="2000" height="1500" alt="7" src="https://github.com/user-attachments/assets/7bb75067-a31e-4b24-ad39-32f92d5cc337" />


Affichage des informations du domaine après préparation du script bootstrap.ps1.



Capture 08 – Édition du script utilisateurs1

<img width="2000" height="1500" alt="8" src="https://github.com/user-attachments/assets/c7a001e5-3545-41ac-b0b8-ec43c2678290" />

Ouverture du Bloc-notes pour préparer le script de création des ressources et des utilisateurs.



Création des ressources et des comptes


Capture 09 – Création des ressources

<img width="2000" height="1500" alt="9" src="https://github.com/user-attachments/assets/c2eff616-aa8a-48ae-9233-1af639431f45" />

PowerShell affiche les résultats de la création du dossier SharedResources et des objets Active Directory.



Capture 10 – Groupe Students

<img width="2000" height="1500" alt="10" src="https://github.com/user-attachments/assets/9a570feb-ff78-4552-a88d-8d777b4e85e7" />

Get-ADGroup et Get-ADGroupMember permettent de contrôler le groupe et ses membres Etudiant1 et Etudiant2.



Capture 11 – Permissions du partage

<img width="2000" height="1500" alt="11" src="https://github.com/user-attachments/assets/a04c3186-92b3-44db-b8ff-c9ec08de12f8" />


Consultation des droits du partage SMB et des autorisations du dossier.



Capture 12 – Permissions NTFS

<img width="2000" height="1500" alt="12" src="https://github.com/user-attachments/assets/00f0fb9f-8271-4cc7-827c-09c99ef9d4bd" />

Utilisation de icacls pour configurer et vérifier les autorisations sur SharedResources.



Capture 13 – Unité d’organisation

<img width="2000" height="1500" alt="13" src="https://github.com/user-attachments/assets/3c5dce50-b418-42cf-b35e-a4f41d33dcec" />


Création ou consultation de l’unité d’organisation Students dans le domaine.



Capture 14 – Déplacement des utilisateurs

<img width="2000" height="1500" alt="14" src="https://github.com/user-attachments/assets/02d4429c-bb8a-4242-b5a6-ca672f4dd69a" />


Les propriétés des deux comptes permettent de vérifier leur emplacement dans Active Directory après déplacement.




Configuration de la stratégie de groupe


Capture 15 – Édition du script utilisateurs2

<img width="2000" height="1500" alt="15" src="https://github.com/user-attachments/assets/b3286766-a2f2-4c26-995c-714fac5da34f" />


Ouverture du fichier utilisateurs2.ps1 dans le Bloc-notes pour préparer la GPO.



Capture 16 – Création de la GPO

<img width="2000" height="1500" alt="16" src="https://github.com/user-attachments/assets/d6b33992-6801-49a7-acff-64ad71a8ebf6" />


Les résultats PowerShell présentent la stratégie MapSharedFolder et sa liaison à l’unité d’organisation.



Capture 17 – Vérification de la GPO


<img width="2000" height="1500" alt="17" src="https://github.com/user-attachments/assets/d583bd6f-f7c4-409c-97a5-fa9f3dcfd437" />


Get-GPO et Get-GPInheritance permettent de consulter la stratégie et son héritage.



Capture 18 – Contrôle des autorisations


<img width="2000" height="1500" alt="18" src="https://github.com/user-attachments/assets/0308a31a-3c2a-418e-8d0e-8c1fe6125ca3" />


Consultation des droits d’accès au partage SharedResources et vérification de son existence.



Capture 19 – Script de connexion

<img width="2000" height="1500" alt="19" src="https://github.com/user-attachments/assets/76c790db-a57e-4e67-b7ff-6148e4049c79" />


Préparation des variables du lecteur Z: et du chemin réseau, puis du script de connexion dans NETLOGON.



Capture 20 – Paramétrage de la GPO

<img width="2000" height="1500" alt="20" src="https://github.com/user-attachments/assets/5a8ad0e6-367a-467a-bfb7-83f3e1a5c682" />


Configuration du lancement du script par une valeur de registre utilisateur, puis actualisation des stratégies.




Configuration des droits de connexion à distance


Capture 21 – Préparation de la sécurité RDP


<img width="2000" height="1500" alt="21" src="https://github.com/user-attachments/assets/acae5849-d3ea-43ca-8228-9c4e171e6b2c" />


Consultation des paramètres et objets nécessaires à l’autorisation de connexion à distance.



Capture 22 – Exportation de la sécurité

<img width="2000" height="1500" alt="22" src="https://github.com/user-attachments/assets/e8a207cd-a90b-4515-97dc-a4bb6178ad90" />


Utilisation de secedit pour exporter les paramètres de sécurité et rechercher les droits de connexion.



Capture 23 – Vérification de la configuration

<img width="2000" height="1500" alt="23" src="https://github.com/user-attachments/assets/c743342f-ac88-4158-af3c-bba93ae703e0" />


Consultation des résultats des commandes de sécurité dans PowerShell.



Capture 24 – Contrôle du groupe

<img width="2000" height="1500" alt="24" src="https://github.com/user-attachments/assets/ef3dcb52-2889-4044-a053-7aaf659e5ff0" />


Affichage des propriétés du groupe Students et de ses membres pour vérifier les comptes concernés.



Capture 25 – Contrôle des droits RDP


<img width="2000" height="1500" alt="25" src="https://github.com/user-attachments/assets/069aaed9-f34a-4d84-865d-64fc8d64505b" />

Recherche des paramètres de connexion à distance dans la configuration de sécurité exportée.



Capture 26 – Stratégie de sécurité locale


<img width="2000" height="1500" alt="26" src="https://github.com/user-attachments/assets/4469314d-c1bc-4a29-b02d-0a458dc00fb6" />


Ouverture de la console de sécurité locale pour accéder aux stratégies d’attribution des droits utilisateur.



Capture 27 – Droit de connexion RDP

<img width="2000" height="1500" alt="27" src="https://github.com/user-attachments/assets/649cffa7-c7e7-41bb-b8ca-cbcf164f0866" />

Ouverture des propriétés du droit Allow log on through Remote Desktop Services.



Capture 28 – Ajout du groupe Students


<img width="2000" height="1500" alt="28" src="https://github.com/user-attachments/assets/0ec60cf9-a135-461f-80f7-2dab2ff7743d" />


La boîte de sélection permet d’ajouter le groupe Students au droit de connexion à distance.



Capture 29 – Actualisation des stratégies


<img width="2000" height="1500" alt="29" src="https://github.com/user-attachments/assets/715acfed-cd94-4a61-9464-08756e4e38dc" />


La commande gpupdate affiche la réussite de l’actualisation des stratégies utilisateur et ordinateur.



Capture 30 – Vérification du droit RDP


<img width="2000" height="1500" alt="30" src="https://github.com/user-attachments/assets/708be339-2685-4f18-8302-c542fc7c08b2" />

L’exportation finale de sécurité et la recherche de SeRemoteInteractiveLogonRight permettent de contrôler le droit configuré.




Tests préliminaires et rapport GPO


Capture 31 – Contrôle de l’environnement

<img width="2000" height="1500" alt="31" src="https://github.com/user-attachments/assets/227deafc-1008-4ba4-b937-ead4355e531b" />


Affichage des fichiers de C: et des informations de session Windows.



Capture 32 – Test sous un compte étudiant

<img width="2000" height="1500" alt="32" src="https://github.com/user-attachments/assets/c7b4d64d-c415-48f8-8a4d-555f1e3f30b5" />

Ouverture d’une nouvelle fenêtre PowerShell avec runas pour effectuer des tests sous un autre compte.



Capture 33 – Montage du lecteur réseau

<img width="2000" height="1500" alt="33" src="https://github.com/user-attachments/assets/3fb09b7a-b816-4653-bd8e-d0cacdc24707" />


Exécution du script de connexion et vérification avec net use et Test-Path Z: ; le lecteur est accessible.



Capture 34 – Test de fichier Etudiant1


<img width="2000" height="1500" alt="34" src="https://github.com/user-attachments/assets/238a6d6e-96ef-47bc-95c6-577b0dceb7d5" />


Création, écriture et lecture du fichier test-Etudiant1.txt sur le lecteur Z:, puis affichage du dossier.



Capture 35 – Rapport de stratégie


<img width="2000" height="1500" alt="35" src="https://github.com/user-attachments/assets/92f383a0-5d96-4be5-bc06-0bc753aa7a87" />


Get-SmbSession affiche une session SMB et Get-GPOReport génère le rapport HTML de MapSharedFolder.



Capture 36 – Consultation du rapport HTML


<img width="2000" height="1500" alt="36" src="https://github.com/user-attachments/assets/a8b0b6ab-1b4b-4689-870d-bab1f0cb93a7" />


Ouverture du rapport de la GPO dans le navigateur pour consulter ses propriétés et ses liaisons.



Capture 37 – Détails du rapport HTML


<img width="2000" height="1500" alt="37" src="https://github.com/user-attachments/assets/c178dbee-8551-44be-9a6c-95322367e72a" />


Consultation du filtrage de sécurité, de la délégation et de la configuration utilisateur de la stratégie.




Vérification des objets et documentation


Capture 38 – Vérification globale Active Directory


<img width="2000" height="1500" alt="38" src="https://github.com/user-attachments/assets/f49b1cdc-0c87-46d9-903c-0c6a318907b7" />


Get-ADUser confirme que les deux comptes sont activés. Get-ADGroupMember confirme leur appartenance à Students et Get-GPInheritance confirme la liaison de MapSharedFolder.



Capture 39 – Contenu des scripts bootstrap et utilisateurs1

<img width="2000" height="1500" alt="39" src="https://github.com/user-attachments/assets/a31bf46d-f70c-49a2-a1f9-e49ada5030ea" />



Get-Content affiche les variables du domaine, la demande d’identifiants, la création du dossier, du groupe, des utilisateurs et du partage SMB.



Capture 40 – Première version de utilisateurs2.ps1


<img width="2000" height="1500" alt="40" src="https://github.com/user-attachments/assets/27954a60-e3dc-49d9-a6b4-57ea094a9453" />


Affichage du script dans PowerShell et le Bloc-notes : importation de GroupPolicy, création de MapSharedFolder et liaison à Students.



Capture 41 – Version complétée de utilisateurs2.ps1

<img width="2000" height="1500" alt="41" src="https://github.com/user-attachments/assets/5e45d7d6-80e4-49dd-8592-d3b54e460d24" />

Le script définit Z:, crée MapDrive-Z.bat dans NETLOGON et configure la valeur MapDriveZ dans HKCU. Il inclut les commandes de vérification de la GPO.



Capture 42 – Contenu de bootstrap.ps1


<img width="2000" height="1500" alt="42" src="https://github.com/user-attachments/assets/2dc61eaf-18c6-4749-a245-298b01afd3f2" />

Le script contient le matricule, les informations DNS et NetBIOS du domaine et une demande d’identifiants avec Get-Credential.



Capture 43 – Création du README


<img width="2000" height="1500" alt="43" src="https://github.com/user-attachments/assets/e142d63e-f31d-4f50-bb5d-43e40e9c95b0" />

Ouverture de C:.md dans le Bloc-notes pour rédiger la documentation.



Capture 44 – Vérification du README


<img width="2000" height="1500" alt="44" src="https://github.com/user-attachments/assets/d45bf82c-4577-4f63-84d5-fffec7256eb1" />


Get-Item confirme l’existence du README.md (3663 octets). Get-ChildItem affiche le chemin du dossier images, sans liste de fichiers visible sur cette capture.



Capture 45 – Ouverture de CMD


<img width="2000" height="1500" alt="45" src="https://github.com/user-attachments/assets/0ece02be-93c9-490c-90f5-f5e2627dff5a" />


L’invite de commandes de l’administrateur est ouverte avant les tests de connexion.




Validation avec Etudiant1


Capture 46 – Identification Etudiant1


<img width="2000" height="1500" alt="46" src="https://github.com/user-attachments/assets/6af78254-4f32-4aae-a658-7061fbd38397" />


Saisie du compte DC300157606 dans la fenêtre de connexion RDP.



Capture 47 – Avertissement de certificat

<img width="1500" height="2000" alt="47" src="https://github.com/user-attachments/assets/9f5e5c91-7c12-464d-bbc8-7e016d1b42c8" />


Le client RDP affiche un avertissement de confiance du certificat du serveur. Cette capture documente l’avertissement, pas sa résolution.



Capture 48 – Bureau distant


<img width="2000" height="1500" alt="48" src="https://github.com/user-attachments/assets/58d372b2-a3a4-40d0-b047-5a249efeeb15" />


Affichage du bureau Windows après la tentative de connexion ; l’identité est confirmée par la capture suivante.



Capture 49 – Identité et lecteur Z: d’Etudiant1

<img width="2000" height="1500" alt="49" src="https://github.com/user-attachments/assets/cb85a8d2-d340-43f3-8ad1-b964cedba71a" />


whoami confirme Etudiant1. net use affiche Z: avec le statut OK et Test-Path Z: retourne True.



Capture 50 – GPO appliquée à Etudiant1


<img width="2000" height="1500" alt="50" src="https://github.com/user-attachments/assets/6533365e-8ddd-42b6-8cdf-eae64735315f" />


gpresult /r /scope user affiche MapSharedFolder parmi les stratégies appliquées à Etudiant1.



Capture 51 – Création et lecture d’un fichier

<img width="2000" height="1500" alt="51" src="https://github.com/user-attachments/assets/99c410f4-f0d2-4464-a66a-39f7facd484f" />

New-Item crée verification.txt, Set-Content écrit Validation TP05 et Get-Content restitue ce texte. Get-ChildItem affiche le fichier sur Z:.



Capture 52 – Suppression du fichier


<img width="2000" height="1500" alt="52" src="https://github.com/user-attachments/assets/5830bbf8-3153-4769-9373-b97cc5ef427d" />


Remove-Item supprime verification.txt et Test-Path retourne False, confirmant sa disparition.



Validation avec Etudiant2

Capture 53 – Identification Etudiant2


<img width="2000" height="1500" alt="53" src="https://github.com/user-attachments/assets/b6cca923-ecdf-46e1-9bc8-f71b1acc2288" />

Saisie du compte DC300157606 pour la deuxième connexion RDP.



Capture 54 – Bureau distant

<img width="2000" height="1500" alt="54" src="https://github.com/user-attachments/assets/42e7f02d-f8ab-42d8-983c-eaeb3f3879ff" />

Affichage du bureau Windows après la connexion ; la capture suivante confirme l’identité de l’utilisateur.



Capture 55 – Identité et lecteur Z: d’Etudiant2


<img width="2000" height="1500" alt="55" src="https://github.com/user-attachments/assets/feb103c5-65f1-4075-bd27-8875faa3bf30" />

whoami confirme Etudiant2. net use indique le statut OK du lecteur Z: et Test-Path Z: retourne True.



Capture 56 – GPO appliquée à Etudiant2


<img width="2000" height="1500" alt="56" src="https://github.com/user-attachments/assets/19cfe4c9-642d-493b-8287-b4ec0eb3d556" />

gpresult /r /scope user confirme que MapSharedFolder figure parmi les stratégies appliquées au deuxième compte.



Capture 57 – Test complet Etudiant2

<img width="2000" height="1500" alt="57" src="https://github.com/user-attachments/assets/2b7bb1f5-3b0d-4f6e-addf-7e42a1beb99a" />

Création de test-Etudiant2.txt, écriture et lecture de Validation Etudiant2, puis suppression. Test-Path retourne False après suppression.


Résultats des vérifications

-   Comptes Etudiant1 et Etudiant2 : activés et membres de Students.
-   GPO MapSharedFolder : liée à Students et appliquée aux deux comptes.
-   Connexions RDP : réussies pour les deux comptes.
-   Lecteur Z: : accessible pour les deux comptes, statut OK et Test-Path True.
-   Création, écriture, lecture et suppression de fichiers : réussies pour les deux comptes.
-   README.md : existence confirmée ; contenu complet et publication non vérifiés par les captures finales.


Conclusion


	Ce TP m’a permis de mettre en pratique l’administration des utilisateurs Active Directory, la gestion des permissions, l’automatisation avec PowerShell et la configuration d’une stratégie de groupe. Les vérifications effectuées avec Etudiant1 et Etudiant2 démontrent que les deux utilisateurs peuvent ouvrir une session à distance, accéder au lecteur réseau Z: et effectuer les opérations de création, d’écriture, de lecture et de suppression de fichiers. La stratégie MapSharedFolder apparaît dans les résultats de stratégie des deux comptes. Ces résultats valident les fonctionnalités testées dans l’environnement du laboratoire.

