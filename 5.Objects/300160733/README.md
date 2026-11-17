# INF1084 – Laboratoire 5 : Objects

**Collège Boréal – Technique des systèmes informatiques**

**Numéro étudiant :** 300160733  
**Serveur :** SRV300160733  
**Domaine :** DC300160733.local  
**Système :** Windows Server 2022  
**Outils utilisés :** PowerShell, Active Directory, GPO et Hyper-V

---

## 1. Introduction

Dans ce laboratoire, j'ai travaillé sur la gestion des objets Active Directory avec Windows Server 2022.

Le but était de créer des utilisateurs et des groupes, configurer un dossier partagé, gérer les permissions et utiliser les stratégies de groupe (GPO).

J'ai aussi effectué plusieurs vérifications avec PowerShell pour confirmer les configurations réalisées.

## 2. Création des utilisateurs et du groupe

J'ai utilisé Active Directory pour créer deux utilisateurs :

- Etudiant1
- Etudiant2

J'ai également créé un groupe de sécurité nommé **Students**.

Les deux utilisateurs ont été associés au groupe Students.

J'ai vérifié les objets dans l'unité d'organisation Students avec la commande suivante :

```powershell
Get-ADObject -SearchBase "OU=Students,DC=DC300160733,DC=local" -SearchScope OneLevel -Filter * | Select-Object Name,ObjectClass
```

**Résultat obtenu :**

```text
Name       ObjectClass
----       -----------
Etudiant1  user
Etudiant2  user
Students   group
```

Cette vérification confirme que les objets existent dans Active Directory.

## 3. Configuration du dossier partagé

J'ai configuré un dossier partagé sur le serveur.

**Chemin du dossier :**

```text
C:\SharedResources
```

**Nom du partage :**

```text
SharedResources
```

Le groupe Students possède les autorisations nécessaires pour accéder au dossier.

J'ai vérifié les permissions du partage avec :

```powershell
Get-SmbShareAccess -Name "SharedResources"
```

**Résultat obtenu :**

```text
Name             AccountName           AccessControlType AccessRight
----             -----------           ----------------- -----------
SharedResources  DC300160733\Students  Allow             Full
```

J'ai également vérifié les permissions NTFS :

```powershell
(Get-Acl "C:\SharedResources").Access |
Format-Table IdentityReference,FileSystemRights,AccessControlType
```

Le résultat montre notamment que le groupe Students possède le droit **FullControl**.

## 4. Création de la GPO MapSharedFolder

J'ai créé une stratégie de groupe appelée :

**MapSharedFolder**

Cette GPO permet de connecter automatiquement un lecteur réseau lors de l'ouverture de session des utilisateurs.

Le lecteur utilisé est :

```text
Z:
```

Le dossier partagé se trouve sur le serveur :

```text
\\SRV300160733\SharedResources
```

La commande de connexion configurée dans la GPO est :

```powershell
C:\Windows\System32\net.exe use Z: \\SRV300160733\SharedResources /persistent:no
```

J'ai vérifié la GPO avec :

```powershell
Get-GPO -Name "MapSharedFolder"
```

J'ai également généré un rapport HTML :

```powershell
Get-GPOReport -Name "MapSharedFolder" -ReportType Html -Path "C:\300160733\Verification_MapSharedFolder.html"
```

Le rapport confirme la présence de la stratégie de connexion du lecteur réseau.

**Rapport :** [Verification_MapSharedFolder.html](Verification_MapSharedFolder.html)

## 5. Création de la GPO Allow-RDP-Students

J'ai créé une deuxième stratégie de groupe appelée :

**Allow-RDP-Students**

Cette GPO sert à configurer les autorisations nécessaires pour les connexions Bureau à distance (RDP).

J'ai configuré une règle de pare-feu nommée :

**Autoriser RDP TCP**

Les paramètres vérifiés dans le rapport sont :

| Paramètre | Valeur |
|---|---|
| Règle | Autoriser RDP TCP |
| État | Activée |
| Action | Allow |
| Protocole | TCP |
| Port local | 3389 |
| Profil | Domain |

J'ai aussi configuré l'ajout du groupe Students au groupe local :

```text
Remote Desktop Users
```

J'ai généré un rapport HTML pour vérifier la configuration :

```powershell
Get-GPOReport -Name "Allow-RDP-Students" -ReportType Html -Path "C:\300160733\Verification_RDP.html"
```

**Rapport :** [Verification_RDP.html](Verification_RDP.html)

## 6. Vérification des stratégies de groupe

J'ai utilisé PowerShell pour vérifier les GPO présentes sur le serveur :

```powershell
Get-GPO -All | Select-Object DisplayName,GpoStatus
```

**Résultat obtenu :**

```text
Default Domain Policy              AllSettingsEnabled
MapSharedFolder                     AllSettingsEnabled
Default Domain Controllers Policy  AllSettingsEnabled
Allow-RDP-Students                  AllSettingsEnabled
```

Les deux GPO créées sont donc activées.

Pour vérifier les liens avec l'unité d'organisation Students, j'ai utilisé :

```powershell
Get-GPInheritance -Target "OU=Students,DC=DC300160733,DC=local"
```

Le résultat montre :

```text
GpoLinks : {MapSharedFolder, Allow-RDP-Students}
```

Les deux stratégies sont liées à l'unité d'organisation Students.

## 7. Vérification des utilisateurs

J'ai vérifié le compte Etudiant1 avec la commande :

```powershell
Get-ADUser -Identity "Etudiant1" -Properties Enabled,PasswordExpired |
Select-Object Name,Enabled,PasswordExpired
```

**Résultat obtenu :**

```text
Name       Enabled PasswordExpired
----       ------- ---------------
Etudiant1  True    False
```

Cela confirme que le compte Etudiant1 est activé et que son mot de passe n'est pas expiré.

## 8. Vérification du serveur

J'ai également vérifié les ordinateurs enregistrés dans Active Directory.

Commande :

```powershell
Get-ADComputer -Filter * | Select-Object Name,Enabled
```

**Résultat obtenu :**

```text
Name          Enabled
----          -------
SRV300160733  True
```

Le serveur est bien présent et activé dans Active Directory.

## 9. Vérification de l'application des GPO

J'ai utilisé la commande suivante :

```powershell
gpresult /r
```

Cette commande permet de vérifier les stratégies réellement appliquées à l'ordinateur ou à l'utilisateur.

Sur le contrôleur de domaine, les résultats montrent notamment :

```text
Default Domain Controllers Policy
Default Domain Policy
Local Group Policy
```

Les GPO destinées aux étudiants sont liées à l'OU Students.

Leur application effective doit être vérifiée lors d'une ouverture de session avec un compte étudiant sur un ordinateur client membre du domaine.

## 10. Scripts PowerShell

J'ai enregistré les fichiers suivants :

**bootstrap.ps1**

Script utilisé pour préparer la configuration du laboratoire.

**utilisateurs1.ps1**

Script permettant de vérifier ou préparer les éléments Active Directory, notamment le groupe Students, le dossier partagé et les utilisateurs.

**utilisateurs2.ps1**

Script utilisé pour vérifier la GPO MapSharedFolder, son lien avec l'OU Students et le partage réseau.

## 11. Vérification et tests

Pendant le laboratoire, j'ai effectué plusieurs vérifications.

| Vérification | Résultat |
|---|---|
| Domaine Active Directory | Réussi |
| Utilisateurs Etudiant1 et Etudiant2 | Présents |
| Groupe Students | Présent |
| Dossier SharedResources | Présent |
| Permissions SMB | Configurées |
| Permissions NTFS | Configurées |
| GPO MapSharedFolder | Créée et activée |
| GPO Allow-RDP-Students | Créée et activée |
| Liens GPO avec OU Students | Vérifiés |
| Rapports HTML | Générés |
| Connexion RDP depuis un client | À confirmer |
| Lecteur Z: sur un client | À confirmer |

## 12. Difficultés rencontrées

Pendant ce laboratoire, j'ai rencontré quelques difficultés.

J'ai eu des problèmes avec la connexion de Windows 10 au domaine Active Directory.

J'ai aussi rencontré des difficultés avec la configuration réseau et la résolution DNS.

J'ai utilisé plusieurs commandes PowerShell pour vérifier le domaine, les utilisateurs, les stratégies de groupe et les permissions.

J'ai également eu des difficultés avec Git et GitHub, notamment avec les chemins de fichiers incompatibles avec Windows et la synchronisation du dépôt.

J'ai finalement réussi à enregistrer mon travail et à envoyer mes fichiers sur GitHub.

## 13. Conclusion

Ce laboratoire m'a permis de mieux comprendre la gestion des utilisateurs, des groupes et des permissions dans Active Directory.

J'ai appris à configurer un dossier partagé et à utiliser les stratégies de groupe pour gérer l'accès aux ressources réseau et au Bureau à distance.

J'ai aussi appris à vérifier mes configurations avec PowerShell et à enregistrer mon travail sur GitHub.

Malgré les difficultés rencontrées, j'ai réussi à réaliser les principales configurations demandées.

---

## 14. Fichiers du laboratoire

```text
300160733/
|
|-- README.md
|-- bootstrap.ps1
|-- utilisateurs1.ps1
|-- utilisateurs2.ps1
|-- GPO_MapSharedFolder.html
|-- GPO_Allow-RDP-Students.html
|-- Verification_MapSharedFolder.html
|-- Verification_RDP.html
|
|-- images/
    |-- .gitkeep
```
