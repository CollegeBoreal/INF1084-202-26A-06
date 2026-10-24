# TP Active Directory – Gestion des objets

**Étudiant :** 300157423  
**Cours :** INF1084 – Administration Windows  
**Serveur :** SRV300157423  
**Domaine :** DC300157423-0.local

## 1. Objectif du TP

Le but de ce travail est de gérer les utilisateurs et les groupes dans Active Directory, de configurer un dossier partagé et d'utiliser une stratégie de groupe (GPO) pour attribuer un lecteur réseau aux étudiants.

## 2. Utilisateurs et groupes Active Directory

J'ai utilisé l'unité d'organisation `Students` et le groupe `Students`, qui contient les comptes `Etudiant1` et `Etudiant2`.

## 3. Création du dossier partagé

J'ai créé le dossier `C:\SharedResources` et configuré le partage réseau `SharedResources` sur le serveur.

J'ai vérifié les permissions du partage avec :

```powershell
Get-SmbShareAccess -Name "SharedResources"
```

![Vérification du partage](images/capture1.png)

## 4. Permissions NTFS

J'ai donné au groupe `Students` la permission de modifier le contenu du dossier partagé.

```powershell
icacls "C:\SharedResources" /grant "DC300157423-0\Students:(OI)(CI)M"
```

J'ai ensuite vérifié les permissions avec :

```powershell
icacls "C:\SharedResources"
```

![Permissions NTFS](images/capture2.png)

## 5. Création de la stratégie de groupe

J'ai créé une GPO appelée `MapSharedFolder` et je l'ai liée à l'unité d'organisation `Students`.

![GPO MapSharedFolder](images/capture3.png)

## 6. Configuration du lecteur réseau Z:

Dans l'éditeur de stratégie de groupe, j'ai configuré le lecteur réseau dans :

`Configuration utilisateur > Préférences > Paramètres Windows > Mappages de lecteurs`

Paramètres utilisés :

- **Action :** Update
- **Lecteur :** Z:
- **Chemin :** `\\SRV300157423\SharedResources`
- **Reconnexion :** activée

![Configuration du lecteur Z](images/capture4.png)

## 7. Vérification de la GPO

J'ai vérifié que la stratégie `MapSharedFolder` est liée à l'unité d'organisation `Students`.

```powershell
Get-GPInheritance -Target "OU=Students,DC=DC300157423-0,DC=local"
```

![Vérification de la GPO](images/capture5.png)

Le lecteur `Z:` a été configuré dans la GPO. Son fonctionnement dans une session étudiante reste à vérifier.

## 8. Conclusion

Ce travail m'a permis de pratiquer la gestion des groupes Active Directory, les permissions NTFS, le partage de dossiers et la configuration d'une GPO pour un lecteur réseau.
