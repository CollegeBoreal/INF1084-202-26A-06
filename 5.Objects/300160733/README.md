# INF1084 — Laboratoire 5 : Objects

**Collège Boréal — Technique des systèmes informatiques**  
**Numéro étudiant :** 300160733  
**Serveur :** SRV300160733  
**Domaine :** DC300160733.local  
**Environnement :** Windows Server 2022, Active Directory, PowerShell et stratégies de groupe (GPO)

## Introduction

Dans ce laboratoire, j'ai configuré des utilisateurs et un groupe dans Active Directory. J'ai aussi préparé un dossier partagé et deux GPO pour le lecteur réseau Z: et le Bureau à distance. Les images ci-dessous sont des captures de mes vérifications et des résultats obtenus.

## 1. Domaine Active Directory, utilisateurs et groupe Students

J'ai vérifié le domaine `DC300160733.local`, le groupe **Students** et les comptes **Etudiant1** et **Etudiant2**. Les commandes `Get-ADGroupMember` et `Get-ADObject` permettent de voir les objets présents dans l'OU Students.

![Vérification du domaine et des GPO](images/01_domaine_et_groupe.png)
*Capture 1 — Vérification PowerShell des objets et de la configuration du domaine.*

![Vérification des membres du groupe Students](images/02_partage_et_groupe.png)
*Capture 2 — Le groupe Students contient Etudiant1 et Etudiant2; le partage SharedResources est aussi visible.*

![Objets de l'OU Students](images/03_objets_ou_students.png)
*Capture 3 — Vérification des utilisateurs et du groupe dans l'OU Students.*

## 2. Dossier partagé et autorisations

Le dossier `C:\SharedResources` a été créé sur le serveur et partagé sous le nom **SharedResources**. J'ai vérifié les autorisations SMB et NTFS à l'aide de PowerShell. Le groupe Students possède les droits configurés pour accéder au partage.

![Autorisations de partage](images/04_permissions_smb.png)
*Capture 4 — Résultat de la vérification des autorisations du partage réseau.*

![Autorisations NTFS](images/05_permissions_ntfs.png)
*Capture 5 — Vérification des droits NTFS sur le dossier partagé.*

![Vérification du compte et du serveur](images/06_verification_compte_serveur.png)
*Capture 6 — Contrôles supplémentaires effectués avec PowerShell.*

## 3. GPO MapSharedFolder et lecteur Z:

J'ai configuré la GPO **MapSharedFolder** pour lancer la connexion du lecteur réseau `Z:` à l'ouverture de session. Le chemin utilisé est `\\SRV300160733\SharedResources`. J'ai ensuite consulté le rapport HTML et vérifié que la GPO était liée à l'OU Students.

![Rapport MapSharedFolder](images/07_rapport_gpo_map.png)
*Capture 7 — Rapport HTML de la stratégie MapSharedFolder.*

![Paramètres du lecteur réseau](images/08_configuration_lecteur_z.png)
*Capture 8 — Détails de la configuration du lecteur réseau.*

![Liens GPO](images/09_gpo_et_liens_ou.png)
*Capture 9 — Vérification des GPO et des liens avec l'OU Students.*

## 4. GPO Allow-RDP-Students

La GPO **Allow-RDP-Students** a été créée pour préparer l'accès Bureau à distance. Le rapport montre la règle **Autoriser RDP TCP**, utilisant le protocole TCP et le port **3389**. Le groupe **Students** est aussi ajouté au groupe local **Remote Desktop Users** dans les préférences de stratégie.

![Règle RDP](images/10_gpo_rdp_regle.png)
*Capture 10 — Rapport de la GPO Allow-RDP-Students.*

![Paramètres RDP](images/11_gpo_rdp_parametres.png)
*Capture 11 — Détails de la règle de pare-feu pour RDP.*

![Groupe Remote Desktop Users](images/12_gpo_rdp_groupe.png)
*Capture 12 — Ajout du groupe Students aux utilisateurs autorisés pour le Bureau à distance.*

## 5. Essais sur le poste client

J'ai utilisé un poste Windows 10 pour vérifier la connexion réseau et essayer de joindre le domaine. Le test `ping` vers le serveur a répondu. J'ai aussi testé la résolution du nom de domaine. La jonction au domaine a toutefois rencontré un problème d'identifiants, et je n'ai pas confirmé de test final réussi du lecteur `Z:` ni de connexion RDP depuis ce client.

![Ping du client](images/13_client_ping.png)
*Capture 13 — Réponses au ping depuis le poste client.*

![Résolution DNS](images/14_client_dns.png)
*Capture 14 — Tests de résolution du nom du domaine.*

![Erreur de jonction au domaine](images/15_client_jointure_erreur.png)
*Capture 15 — Difficulté rencontrée pendant la tentative de jonction au domaine.*

## 6. Scripts PowerShell

J'ai préparé les scripts **`utilisateurs1.ps1`** et **`utilisateurs2.ps1`** et conservé `bootstrap.ps1`. Le premier sert à préparer ou vérifier le groupe Students et le partage. Le second vérifie la GPO MapSharedFolder et génère un rapport HTML. Je n'ai pas relancé les scripts de création sur les objets déjà configurés.

![Script utilisateurs1](images/16_script_1.png)
*Capture 16 — Contenu et vérification du script utilisateurs1.ps1.*

![Script utilisateurs2](images/17_script_2.png)
*Capture 17 — Contenu et vérification du script utilisateurs2.ps1.*

## 7. Vérification des fichiers et envoi sur GitHub

J'ai enregistré mon travail dans le dossier `5.Objects/300160733`. L'envoi a demandé plusieurs vérifications à cause de chemins incompatibles avec Windows dans le dépôt partagé. J'ai finalement créé un commit contenant uniquement les fichiers de mon laboratoire et réussi à l'envoyer sur GitHub.

![Fichiers du laboratoire](images/18_fichiers_laboratoire.png)
*Capture 18 — Vérification des fichiers conservés dans le laboratoire.*

![Contrôle du commit](images/19_commit_neuf_fichiers.png)
*Capture 19 — Vérification des fichiers du commit Git.*

![Envoi GitHub](images/20_push_github_reussi.png)
*Capture 20 — Résultat du git push réussi vers le dépôt du cours.*

## 8. Difficultés rencontrées

J'ai eu des difficultés avec la connexion du poste Windows 10 au domaine, certains paramètres réseau et les identifiants de connexion. J'ai aussi rencontré des erreurs Git pendant la récupération du dépôt, car certains noms de fichiers du dépôt partagé ne sont pas compatibles avec Windows. Avec les commandes de vérification, j'ai pu conserver mes fichiers et réussir l'envoi de mon travail.

## Conclusion

Ce laboratoire m'a permis de mieux comprendre Active Directory, les utilisateurs, les groupes, les permissions de partage et les GPO. J'ai appris à vérifier les résultats dans PowerShell et à présenter mes preuves avec des captures d'écran. Les configurations principales sont faites et mon travail est publié sur GitHub. Les tests finaux du lecteur Z: et du Bureau à distance sur un client restent à confirmer.

## Rapports et scripts

- [GPO MapSharedFolder](GPO_MapSharedFolder.html)
- [GPO Allow-RDP-Students](GPO_Allow-RDP-Students.html)
- [Rapport de vérification MapSharedFolder](Verification_MapSharedFolder.html)
- [Rapport de vérification RDP](Verification_RDP.html)
- [Script utilisateurs1.ps1](utilisateurs1.ps1)
- [Script utilisateurs2.ps1](utilisateurs2.ps1)
