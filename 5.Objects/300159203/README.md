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

### Création
