# Laboratoire — Active Directory, partage SMB, GPO et RDP

**Collège Boréal — Techniques des systèmes informatiques**

- **Cours :** INF1084 — Objets gérables par Active Directory
- **Étudiant :** Riadh Sahraoui
- **Matricule :** 300159203
- **Système d’exploitation :** Windows Server 2022 Datacenter
- **Nom du serveur :** `SRV300159203`
- **Domaine Active Directory :** `DC300159203.local`

---

## 1. Objectif du laboratoire

L’objectif de ce laboratoire est de gérer les utilisateurs, les ressources partagées et les autorisations d’accès dans un environnement Active Directory sous Windows Server 2022.

Les tâches réalisées sont les suivantes :

- Création d’une unité organisationnelle (OU) nommée `Students`.
- Création d’un groupe de sécurité global nommé `Students`.
- Création des comptes utilisateurs `Etudiant1` et `Etudiant2`.
- Création et configuration d’un partage SMB dans `C:\SharedResources`.
- Création et liaison d’une stratégie de groupe (GPO) pour le mappage automatique du lecteur réseau `Z:`.
- Activation du Bureau à distance (RDP) et vérification des autorisations de connexion.
- Validation de l’accès au partage réseau et des restrictions de sécurité.

## 2. Environnement de travail

| Élément | Configuration |
|---|---|
| Contrôleur de domaine | `SRV300159203` |
| Système d’exploitation | Windows Server 2022 Datacenter |
| Domaine DNS | `DC300159203.local` |
| Nom NetBIOS | `DC300159203` |
| Nom distinctif du domaine | `DC=DC300159203,DC=local` |
| Unité organisationnelle (OU) | `Students` |
| Groupe de sécurité global | `Students` |
| Utilisateurs | `Etudiant1`, `Etudiant2` |
| Dossier partagé | `C:\SharedResources` |
| Chemin réseau UNC | `\\SRV300159203\SharedResources` |
| Stratégie de groupe (GPO) | `MapSharedFolder` |
| Lettre du lecteur réseau | `Z:` |

## 3. Création des objets Active Directory et du partage SMB

Les objets Active Directory et le répertoire partagé ont été configurés à l’aide de scripts PowerShell exécutés avec un compte administrateur sur le contrôleur de domaine.

L’unité organisationnelle `Students` permet de regrouper les comptes utilisateurs du laboratoire. Le groupe de sécurité global `Students` sert à gérer les autorisations d’accès aux ressources et au Bureau à distance.

### Création de l’OU et du groupe

```powershell
New-ADOrganizationalUnit -Name "Students" -Path "DC=DC300159203,DC=local"

New-ADGroup -Name "Students" `
    -GroupScope Global `
    -Description "Users allowed RDP and shared folder access"
```

Le script `utilisateurs1.ps1` a permis de créer les comptes `Etudiant1` et `Etudiant2`, de les ajouter au groupe `Students`, de créer le dossier `C:\SharedResources` et de configurer le partage SMB.

### Preuve d’exécution du script

![Exécution du script utilisateurs1.ps1](https://github.com/user-attachments/assets/7b918ce2-d24e-4ca8-97a0-04564a9dcb2c)

*Figure 1 — Exécution du script `utilisateurs1.ps1` : création de l’OU, du groupe, des utilisateurs, du dossier partagé et du partage SMB.*

## 4. Configuration de la stratégie de groupe (GPO)

Une stratégie de groupe nommée `MapSharedFolder` a été créée et liée à l’OU `Students`.

Son objectif est de configurer le mappage du lecteur réseau `Z:` vers le partage SMB suivant :

```text
\\SRV300159203\SharedResources
```

### Création et liaison de la GPO

```powershell
New-GPO -Name "MapSharedFolder"

New-GPLink -Name "MapSharedFolder" `
    -Target "OU=Students,DC=DC300159203,DC=local"
```

Le script `utilisateurs2.ps1` a également été utilisé pour appliquer la configuration prévue, activer le Bureau à distance (RDP) et configurer les règles de pare-feu nécessaires.

### Preuves d’exécution du script

![Première capture du script utilisateurs2.ps1](https://github.com/user-attachments/assets/3c0fe75d-f7f9-445b-99f0-e0e0d93e7673)

![Deuxième capture du script utilisateurs2.ps1](https://github.com/user-attachments/assets/2db85aa0-3833-46ef-9976-4f0f64071f1a)

*Figures 2 et 3 — Exécution du script `utilisateurs2.ps1` : création et liaison de la GPO, activation du RDP et configuration du pare-feu.*

## 5. Validation de la connexion client et du partage réseau

Une validation a été effectuée avec le compte utilisateur `Etudiant1`.

La commande suivante a permis de forcer la mise à jour des stratégies de groupe :

```powershell
gpupdate /force
```

Le lecteur réseau `Z:` a ensuite été vérifié à l’aide de la commande `net use Z:`. Il apparaît dans l’Explorateur de fichiers, sous **Ce PC**.

### Preuve du mappage du lecteur réseau

![Validation de gpupdate, net use et affichage du lecteur Z](https://github.com/user-attachments/assets/f0a95fdd-8417-4f5c-b280-c6988febea34)

*Figure 4 — Validation de la mise à jour des stratégies de groupe et affichage du lecteur réseau `Z:` dans la session d’`Etudiant1`.*

L’ouverture du lecteur réseau permet de vérifier l’accès au partage `SharedResources` hébergé sur `SRV300159203`.

### Preuve d’accès au partage SMB

![Ouverture du lecteur réseau SharedResources](https://github.com/user-attachments/assets/b5eb8124-a967-49ee-97bc-648f68fcf17f)

*Figure 5 — Accès au partage réseau `\\SRV300159203\SharedResources` depuis l’Explorateur de fichiers.*

## 6. Test de sécurité RDP avec un utilisateur non autorisé

Un test de sécurité a été effectué avec le compte `UserTest`, qui n’appartient pas au groupe `Students`.

Lors d’une tentative de connexion RDP au serveur à l’adresse IP `10.7.237.222`, la connexion a été refusée. Le système a affiché le message suivant :

> The connection was denied because the user account is not authorized for remote login.

Ce résultat confirme que le compte testé ne dispose pas des autorisations nécessaires pour ouvrir une session à distance sur le serveur.

### Preuve du refus de connexion RDP

![Message de refus de connexion RDP](https://github.com/user-attachments/assets/eb84a027-27f3-46e3-92a6-d3734b457b2a)

*Figure 6 — Refus de connexion RDP lors d’une tentative effectuée avec le compte `UserTest`.*

## 7. Conclusion

Ce laboratoire a permis de mettre en pratique la gestion des utilisateurs et des ressources dans un domaine Active Directory sous Windows Server 2022.

Les manipulations réalisées comprennent la création d’une unité organisationnelle, d’un groupe de sécurité et de comptes utilisateurs, la configuration d’un partage SMB, le déploiement d’une GPO pour le mappage d’un lecteur réseau et la vérification des autorisations d’accès au Bureau à distance.

Les tests effectués avec `Etudiant1` ont permis de valider l’accès au partage réseau. Le test avec `UserTest` a également démontré le refus de connexion RDP pour un compte non autorisé.

Ces manipulations illustrent l’importance de la gestion centralisée des comptes, des stratégies de groupe et des permissions afin de contrôler l’accès aux ressources d’un réseau Windows.
