# Laboratoire INF1084 - Active Directory

Nom du serveur : SRV300160733
Domaine : DC300160733.local
Numero etudiant : 300160733

## Objectif

Ce laboratoire consiste a configurer des objets
Active Directory, un dossier partage et des GPO.

## Travail realise

1. Verification du domaine Active Directory.
2. Creation du groupe Students.
3. Creation des utilisateurs Etudiant1 et Etudiant2.
4. Creation du dossier C:\SharedResources.
5. Configuration du partage reseau SharedResources.
6. Configuration des permissions du groupe Students.
7. Creation de la GPO MapSharedFolder.
8. Configuration du lecteur reseau Z:.
9. Creation de la GPO Allow-RDP-Students.
10. Configuration des autorisations RDP.

## Verification

Le groupe Students contient Etudiant1 et Etudiant2.

Les permissions SMB et NTFS sont configurees.

Les deux GPO sont creees et liees a OU Students.

Les tests de connexion RDP et du lecteur Z:
sur une machine cliente restent a effectuer.

## Conclusion

Ce laboratoire m'a permis de comprendre comment
gerer les utilisateurs, les groupes, les partages
et les GPO dans Active Directory.