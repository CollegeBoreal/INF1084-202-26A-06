Rapport explicatif – Installation et configuration d'un domaine Active Directory
Cours : Administration Windows
Identifiant étudiant : 300147253
Système d'exploitation : Windows Server 2022
Introduction
Dans le cadre de ce laboratoire, j'ai réalisé l'installation et la configuration d'un domaine Active Directory sur Windows Server 2022. L'objectif principal était de mettre en place un contrôleur de domaine permettant de centraliser la gestion des utilisateurs, des ordinateurs et des ressources d'un réseau informatique.
1. Renommage du serveur
La première étape consistait à renommer le serveur en utilisant la commande PowerShell Rename-Computer. J'ai attribué au serveur le nom SRV300147253, conformément aux consignes du professeur. Après le redémarrage, j'ai utilisé la commande hostname pour vérifier que le nouveau nom avait été appliqué correctement.
2. Installation du rôle Active Directory
Ensuite, j'ai vérifié l'installation du rôle Active Directory Domain Services (AD DS) avec la commande Get-WindowsFeature AD-Domain-Services. Le résultat indiquait Installed, ce qui confirmait que le rôle était déjà installé sur le serveur.
Ce service permet de gérer les utilisateurs, les groupes, les ordinateurs et les autorisations d'accès au sein d'un domaine Windows.
3. Création du domaine Active Directory
J'ai ensuite configuré une nouvelle forêt Active Directory avec le domaine DC300147253.local, en utilisant la commande Install-ADDSForest.
Cette opération a permis de promouvoir le serveur en contrôleur de domaine. J'ai également configuré un mot de passe DSRM, nécessaire pour accéder au mode de restauration des services d'annuaire.
Après l'installation, le serveur a redémarré afin d'appliquer les changements.
4. Installation du service DNS
Le service DNS est indispensable au bon fonctionnement d'Active Directory, car il permet aux ordinateurs de localiser les contrôleurs de domaine et les services d'authentification.
J'ai vérifié l'installation du rôle DNS avec la commande Get-WindowsFeature DNS. Le résultat affichait Installed, confirmant que le rôle DNS était correctement installé sur le serveur.
5. Vérification du domaine et de la forêt
Pour vérifier la configuration, j'ai exécuté les deux commandes PowerShell demandées par le professeur :
•	Get-ADDomain : permet d'afficher les informations du domaine Active Directory.
•	Get-ADForest : permet de vérifier les informations de la forêt Active Directory.
Les résultats ont confirmé que le domaine DC300147253.local avait été créé et que le serveur SRV300147253.DC300147253.local était reconnu comme contrôleur de domaine.
Le niveau fonctionnel du domaine et de la forêt était Windows Server 2016, ce qui est compatible avec Windows Server 2022.
Conclusion
Ce laboratoire m'a permis de comprendre les principales étapes de l'installation et de la configuration d'un domaine Active Directory sur Windows Server 2022.
J'ai réussi à renommer le serveur, à vérifier l'installation du rôle AD DS, à créer un domaine et une forêt Active Directory, ainsi qu'à confirmer l'installation du service DNS.
Les commandes de vérification ont fonctionné correctement et ont confirmé la création du domaine. Ce travail m'a permis de développer mes compétences en administration de serveurs Windows et de mieux comprendre le rôle d'Active Directory dans la gestion centralisée d'un réseau informatique.


