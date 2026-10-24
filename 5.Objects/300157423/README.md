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

<img width="477" height="520" alt="Capture514" src="https://github.com/user-attachments/assets/8ab95bf2-4929-4a60-abff-dcac8d54e5b9" />


## 4. Permissions NTFS

J'ai donné au groupe `Students` la permission de modifier le contenu du dossier partagé.

```powershell
icacls "C:\SharedResources" /grant "DC300157423-0\Students:(OI)(CI)M"
```

J'ai ensuite vérifié les permissions avec :

```powershell
icacls "C:\SharedResources"
```

<img width="478" height="520" alt="Capture 513" src="https://github.com/user-attachments/assets/beab65f0-0fff-4417-99a8-d0d0ec76534e" />


## 5. Création de la stratégie de groupe

J'ai créé une GPO appelée `MapSharedFolder` et je l'ai liée à l'unité d'organisation `Students`.

<img width="477" height="516" alt="Capture 512" src="https://github.com/user-attachments/assets/ae55c511-c089-4995-a066-d98e927cf579" />


## 6. Configuration du lecteur réseau Z:

Dans l'éditeur de stratégie de groupe, j'ai configuré le lecteur réseau dans :

`Configuration utilisateur > Préférences > Paramètres Windows > Mappages de lecteurs`

Paramètres utilisés :

- **Action :** Update
- **Lecteur :** Z:
- **Chemin :** `\\SRV300157423\SharedResources`
- **Reconnexion :** activée

<img width="919" height="487" alt="Capture 511" src="https://github.com/user-attachments/assets/d267390a-248f-4832-aaab-0b8ad4efaa32" />


## 7. Vérification de la GPO

J'ai vérifié que la stratégie `MapSharedFolder` est liée à l'unité d'organisation `Students`.

```powershell
Get-GPInheritance -Target "OU=Students,DC=DC300157423-0,DC=local"
```

<img width="744" height="425" alt="Capture 510" src="https://github.com/user-attachments/assets/6616aabf-7fca-4bd7-bb8e-f01062c2bb01" />


Le lecteur `Z:` a été configuré dans la GPO. Son fonctionnement dans une session étudiante reste à vérifier.

## 8. Conclusion

Ce travail m'a permis de pratiquer la gestion des groupes Active Directory, les permissions NTFS, le partage de dossiers et la configuration d'une GPO pour un lecteur réseau.
