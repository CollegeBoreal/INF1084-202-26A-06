# RAPPORT DE LABORATOIRE
## INF1084 – 5.Objects
### Gestion des utilisateurs, partage de ressources et accès à distance avec Windows Server

**Établissement :** Collège Boréal  
**Cours :** INF1084  
**Étudiant :** 300159887  
**Domaine Active Directory :** 300159887.local  
**Serveur :** Windows Server  
**Adresse IP du serveur :** 10.7.237.227  
**Date :** 10 novembre 2026

---

# Table des matières

1. Introduction
2. Objectifs du laboratoire
3. Environnement de travail
4. Configuration d'Active Directory
5. Création des utilisateurs et du groupe Students
6. Création du dossier partagé
7. Configuration des permissions
8. Configuration de la stratégie de groupe (GPO)
9. Configuration du lecteur réseau Z:
10. Configuration de l'accès Bureau à distance (RDP)
11. Vérifications et résultats
12. Conclusion

---

# 1. Introduction

Dans ce laboratoire du cours INF1084, nous avons réalisé différentes tâches d'administration système avec Windows Server et PowerShell.

L'objectif principal était de mettre en place un environnement Active Directory permettant de gérer les utilisateurs, les groupes de sécurité, les permissions d'accès aux ressources partagées et les connexions à distance.

Nous avons également configuré une stratégie de groupe (GPO) afin de faciliter l'accès des utilisateurs au dossier partagé grâce à un lecteur réseau.

Ce laboratoire permet de mettre en pratique les connaissances en administration Windows Server, en gestion des comptes utilisateurs et en sécurité réseau.

# 2. Objectifs du laboratoire

Les principaux objectifs étaient :

- Configurer un domaine Active Directory.
- Créer une unité organisationnelle (OU).
- Créer des utilisateurs et un groupe de sécurité.
- Configurer un dossier partagé avec SMB.
- Définir les permissions NTFS et SMB.
- Créer une stratégie de groupe (GPO).
- Configurer le lecteur réseau Z: automatiquement.
- Autoriser les utilisateurs à accéder au serveur avec RDP.
- Vérifier les configurations avec PowerShell.

# 3. Environnement de travail

Les outils et technologies utilisés pendant le laboratoire sont :

| Élément | Configuration |
|---|---|
| Système d'exploitation | Windows Server 2022 |
| Domaine | 300159887.local |
| Adresse IP | 10.7.237.227 |
| Outil d'administration | PowerShell |
| Gestion des utilisateurs | Active Directory |
| Partage de fichiers | SMB |
| Gestion des stratégies | Group Policy Management |
| Accès distant | RDP |

# 4. Configuration d'Active Directory
<img width="784" height="591" alt="Capture d’écran 2026-11-03 105126" src="https://github.com/user-attachments/assets/2fb34a2b-026d-45c2-916d-3df674d88e94" />
<img width="553" height="550" alt="Capture d’écran 2026-11-03 113134" src="https://github.com/user-attachments/assets/d9b1f215-c856-44f6-bbc1-497f212c2b5c" />



La première étape consistait à configurer Active Directory Domain Services (AD DS).

Nous avons créé un domaine nommé :

`300159887.local`

Cette configuration permet de centraliser la gestion des utilisateurs, des groupes et des ordinateurs dans un environnement Windows Server.

Après l'installation, nous avons vérifié le domaine avec les commandes suivantes :

```powershell
Get-ADDomain
Get-ADForest
```

Ces commandes permettent de vérifier les informations du domaine et de la forêt Active Directory.

# 5. Création des utilisateurs et du groupe Students

## 5.1 Création de l'unité organisationnelle
<img width="891" height="553" alt="Capture d’écran 2026-11-03 113916" src="https://github.com/user-attachments/assets/bbc3e25d-a43b-4b56-b626-96486bc70a1e" />




Nous avons créé une unité organisationnelle nommée :

`Students`

Son chemin dans Active Directory est :

`OU=Students,DC=300159887,DC=local`

Cette OU permet de regrouper les comptes étudiants et d'appliquer des stratégies de groupe à ces utilisateurs.

## 5.2 Création du groupe de sécurité

Nous avons créé un groupe nommé :

`Students`

Les propriétés du groupe sont :

- Nom : Students
- Type : Security
- Étendue : Global

Ce groupe permet de gérer les autorisations de plusieurs utilisateurs sans devoir configurer individuellement chaque compte.

## 5.3 Création des utilisateurs
<img width="813" height="555" alt="Capture d’écran 2026-11-03 112742" src="https://github.com/user-attachments/assets/0487d6d6-0125-48ab-be07-a3baa0ab93da" />


Deux comptes étudiants ont été ajoutés dans l'OU Students :

- Etudiant1
- Etudiant2

Un autre compte nommé TestUser a également été créé dans le conteneur Users du domaine.

La commande suivante permet de vérifier les membres du groupe :

```powershell
Get-ADGroupMember Students
```

Le résultat obtenu confirme la présence des comptes Etudiant1 et Etudiant2 dans le groupe Students.

# 6. Création du dossier partagé
<img width="1001" height="587" alt="Capture d’écran 2026-11-03 113731" src="https://github.com/user-attachments/assets/5b57c762-9871-4881-a1b7-62dc1b37867f" />


Nous avons créé un dossier nommé SharedResources à la racine du disque C:.

Son chemin est :

`C:\SharedResources`

La commande PowerShell utilisée est :

```powershell
New-Item -Path "C:\SharedResources" -ItemType Directory
```

Ce dossier sert à centraliser les fichiers et les ressources accessibles aux membres du groupe Students.

# 7. Configuration des permissions

## 7.1 Permissions de partage SMB

Nous avons configuré le partage réseau sous le nom :

`SharedResources`

Le groupe Students a reçu les autorisations suivantes :

- Type : Allow
- Permission : Full

Cette configuration permet aux membres du groupe d'accéder au dossier partagé selon les permissions définies.

## 7.2 Permissions NTFS

Nous avons également configuré les permissions NTFS sur le dossier.

Le groupe Students possède une permission Modify (Modification).

La commande suivante permet de vérifier les permissions :

```powershell
icacls "C:\SharedResources"
```

Le résultat obtenu montre notamment les autorisations accordées au groupe Students.

La différence entre les permissions SMB et NTFS est importante : lorsqu'un utilisateur accède au dossier à travers le réseau, les deux niveaux de permissions sont pris en compte.

# 8. Configuration de la stratégie de groupe (GPO)

Nous avons créé une stratégie de groupe appelée :

`MapSharedFolder`

Cette GPO a été liée à l'unité organisationnelle Students.

La commande suivante permet de vérifier les stratégies liées à cette OU :

```powershell
Get-GPInheritance -Target "OU=Students,DC=300159887,DC=local"
```

Le résultat confirme la présence de la GPO MapSharedFolder dans les stratégies appliquées à cette unité organisationnelle.

Cette stratégie permet de centraliser les paramètres et de faciliter la configuration des utilisateurs.

# 9. Configuration du lecteur réseau Z:
<img width="662" height="708" alt="Capture d’écran 2026-11-03 115559" src="https://github.com/user-attachments/assets/4dc484e4-c379-4428-8801-ab39773c446b" />


Dans l'éditeur de gestion des stratégies de groupe, nous avons accédé à :

User Configuration → Preferences → Windows Settings → Drive Maps.

Nous avons commencé la configuration d'un lecteur réseau avec les paramètres suivants :

| Paramètre | Valeur |
|---|---|
| Drive Letter | Z: |
| Action | Update |
| Location | Chemin UNC du partage SMB |
| GPO | MapSharedFolder |

Le but est de permettre aux utilisateurs membres de l'OU Students d'accéder automatiquement au dossier partagé à travers le lecteur Z:.

Le chemin réseau doit correspondre au partage SMB configuré sur le serveur.

Exemple :

`\\10.7.237.227\SharedResources`

La commande suivante permet de forcer l'actualisation des stratégies :

```powershell
gpupdate /force
```

La vérification finale de l'apparition du lecteur Z: doit être effectuée avec une session utilisateur appartenant à l'OU Students.

# 10. Configuration de l'accès Bureau à distance (RDP)

Nous avons également travaillé sur la configuration de l'accès à distance.

L'objectif est de permettre aux utilisateurs autorisés de se connecter au serveur Windows à partir d'une autre machine.

Nous avons vérifié les membres du groupe Remote Desktop Users avec la commande :

```powershell
Get-ADGroupMember -Identity "Remote Desktop Users"
```

Le résultat montre que le groupe Students est membre de Remote Desktop Users.

Cela permet d'autoriser les membres de ce groupe à accéder au serveur par Bureau à distance, sous réserve que le service RDP, les stratégies et le pare-feu soient correctement configurés.

Une fenêtre de connexion RDP a été utilisée pour tester l'authentification avec un compte du domaine.

# 11. Vérifications et résultats

Plusieurs commandes PowerShell ont été utilisées afin de vérifier les configurations réalisées.

| Vérification | Commande | Résultat observé |
|---|---|---|
| Vérifier le domaine | `Get-ADDomain` | Domaine 300159887.local |
| Vérifier la forêt | `Get-ADForest` | Forêt Active Directory |
| Vérifier l'OU | `Get-ADOrganizationalUnit` | OU Students créée |
| Vérifier les membres | `Get-ADGroupMember Students` | Etudiant1 et Etudiant2 |
| Vérifier le partage | `Get-SmbShareAccess -Name "SharedResources"` | Groupe Students autorisé |
| Vérifier les permissions | `icacls "C:\SharedResources"` | Permission Modify affichée |
| Vérifier la GPO | `Get-GPO -Name "MapSharedFolder"` | GPO trouvée |
| Vérifier la liaison | `Get-GPInheritance` | MapSharedFolder liée à Students |
| Vérifier RDP | `Get-ADGroupMember "Remote Desktop Users"` | Groupe Students présent |

Les résultats obtenus confirment la création de la structure Active Directory, du groupe de sécurité, des utilisateurs, du dossier partagé et de la stratégie de groupe.

La connexion effective des utilisateurs, l'apparition automatique du lecteur Z: et l'accès RDP doivent être confirmés par les tests finaux.

# 12. Conclusion

Ce laboratoire nous a permis de mettre en pratique plusieurs notions importantes de l'administration système avec Windows Server.

Nous avons appris à créer et organiser des utilisateurs dans Active Directory, à gérer les groupes de sécurité, à configurer un partage réseau SMB et à définir les permissions NTFS.

Nous avons également découvert comment utiliser les stratégies de groupe pour automatiser certaines configurations, notamment la connexion d'un lecteur réseau.

Enfin, nous avons travaillé sur la gestion des accès à distance avec Remote Desktop Protocol (RDP).

Ce travail nous a permis de mieux comprendre l'importance de la centralisation de la gestion des comptes, de la sécurité des ressources partagées et de l'automatisation des tâches d'administration dans un environnement professionnel.

---



