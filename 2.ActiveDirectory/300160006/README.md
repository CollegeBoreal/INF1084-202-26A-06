# 300160006

  # Laboratoire 2 – Services : Active Directory

## Objectif

L’objectif de ce laboratoire était de créer ou de gérer un utilisateur ayant des droits d’administration sur Windows Server 2022 en utilisant PowerShell, puis de documenter les étapes réalisées.

## Description du travail réalisé

Dans ce laboratoire, j’ai utilisé PowerShell pour travailler avec Active Directory sur un serveur Windows Server 2022 Datacenter. J’ai commencé par vérifier la configuration du serveur et rechercher mon compte étudiant dans Active Directory. J’ai ensuite vérifié les groupes auxquels les utilisateurs appartiennent afin de comprendre comment les droits d’administration sont attribués. j’ai travaillé sur la création et la gestion du compte utilisateur 300160006 avec Windows PowerShell. J’ai saisi le mot de passe de manière sécurisée avec Read-Host -AsSecureString, puis créé le compte avec New-LocalUser en indiquant le nom complet et la description « Compte pour le laboratoire ».

J’ai ensuite essayé d’ajouter le compte au groupe Administrators avec Add-LocalGroupMember. Cette commande a échoué, car le groupe n’était pas trouvé. J’ai donc vérifié les groupes disponibles et recherché le compte dans Active Directory avec Get-ADUser. Le résultat a confirmé que le compte 300160006 existait dans le domaine et qu’il était activé.

Pour poursuivre dans Active Directory, la commande d’ajout au groupe Administrators est Add-ADGroupMember, avec l’identifiant S-1-5-32-544. La vérification finale consiste à afficher les membres avec Get-ADGroupMember et à confirmer que 300160006 apparaît dans la liste. Cette étape permet de valider l’ajout et de conserver une capture comme preuve du travail.

Après avoir effectué la configuration nécessaire, j’ai vérifié les droits attribués à mon compte pour m’assurer que le résultat correspondait à l’objectif du laboratoire.

## Résultat et apprentissage

Ce laboratoire m’a permis de mieux comprendre le fonctionnement d’Active Directory, la gestion des utilisateurs et des groupes, ainsi que l’attribution des droits d’administration dans un environnement Windows Server 2022. J’ai également appris à utiliser PowerShell pour vérifier les comptes et les autorisations.

## Preuves

Les captures d’écran des commandes PowerShell et de leurs résultats servent à démontrer les étapes réalisées et à confirmer la configuration finale.

![images alt](https://github.com/CollegeBoreal/INF1084-202-26A-06/blob/423b67dd1040cb829eac01b7e40c0cc38e449a37/2.ActiveDirectory/300160006/images/WhatsApp%20Image%202026-10-15%20at%2010.48.00.jpeg)
![images alt](https://github.com/CollegeBoreal/INF1084-202-26A-06/blob/40f420b9ede75e8b95e00601cc2f22ca6249139d/2.ActiveDirectory/300160006/images/WhatsApp%20Image%202026-10-15%20at%2010.48.01.jpeg)

