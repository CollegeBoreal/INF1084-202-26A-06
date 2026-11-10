# INF1084 — Architecture Active Directory avec Hyper-V

**Numéro étudiant :** 300159203  
**Cours :** INF1084 — Administration Windows  
**Environnement :** Windows Server 2022, Hyper-V, PowerShell et Active Directory Domain Services

SRV300159203
Windows Server 2022
      |
      |  Hyper-V
      |
   Switch LAB
   (Internal)
      |
    LABNAT
      |
172.16.21.0/24
      |
      +---- DC300159203
      |     IP : 172.16.21.10
      |     DNS : 127.0.0.1
      |     Domaine : DC300159203.local
      |     Active Directory + DNS
      |
      +---- CLIENT01
            IP : 172.16.21.20
            Passerelle : 172.16.21.1
            DNS : 172.16.21.10
            Domaine : DC300159203.local

## 1. Présentation du projet

Ce projet consiste à créer une infrastructure Windows Server virtualisée avec Hyper-V.

Chaque étudiant possède son propre environnement indépendant comprenant :
- Une machine virtuelle Windows Server 2022 assignée.
- Une forêt Active Directory indépendante.
- Un domaine AD DS indépendant.
- Son propre serveur DNS.
- Son propre sous-réseau privé.
- Ses propres machines virtuelles Hyper-V imbriquées.

L'objectif est de configurer Active Directory, gérer les utilisateurs et les groupes, créer un partage réseau et appliquer des permissions SMB et NTFS.

## 2. Architecture Hyper-V

**Serveur parent :** `SRV300159203`

Le serveur parent héberge les machines virtuelles Hyper-V suivantes :

- `DC300159203` : contrôleur de domaine.
- `CLIENT01` : poste client.
- `SRV01` : autre machine virtuelle présente dans Hyper-V.

**CAPTURE 01 — Machines virtuelles Hyper-V**

<img width="639" height="279" alt="Machines virtuelles Hyper-V" src="https://github.com/user-attachments/assets/1d7d6c6b-73bf-4904-a41f-0d559b4c6ebf" />

## 3. Configuration réseau

### 3.1 Réseau du Collège

Le réseau du Collège utilise le sous-réseau suivant :

`10.7.236.0/23`

Les serveurs parents disposent d'adresses IP attribuées dans ce réseau.

L'adresse IP extérieure exacte de `SRV300159203` doit être confirmée sur le serveur parent.

### 3.2 Réseau privé de l'étudiant

Mon réseau privé utilise le sous-réseau :

`172.16.21.0/24`

| Élément | Configuration |
|---|---|
| Serveur parent | SRV300159203 |
| Réseau privé | 172.16.21.0/24 |
| Commutateur virtuel | LAB |
| Passerelle NAT | 172.16.21.1 |
| NAT | LABNAT |
| Contrôleur de domaine | DC300159203 |
| Adresse IP du DC | 172.16.21.10 |
| Poste client | CLIENT01 |
| Adresse IP du client | 172.16.21.20 |
| Domaine AD DS | DC300159203.local |

### 3.3 Création du commutateur interne

Un commutateur virtuel interne nommé `LAB` a été créé pour isoler le réseau privé.

**CAPTURE 02 — Commutateur virtuel LAB**

<img width="579" height="125" alt="Commutateur LAB" src="https://github.com/user-attachments/assets/632390f2-222a-4e80-a7e9-dfc5225ad5c9" />

### 3.4 Configuration NAT

Un NAT nommé `LABNAT` a été configuré avec le préfixe `172.16.21.0/24`.

**CAPTURE 03 — Configuration NAT**

<img width="548" height="215" alt="Configuration NAT" src="https://github.com/user-attachments/assets/d6e0f45f-19f7-4ba8-ab2f-0d466c85282d" />

### 3.5 Configuration de la passerelle

L'interface `vEthernet (LAB)` utilise l'adresse `172.16.21.1/24`.

**CAPTURE 04 — Passerelle du réseau LAB**

<img width="558" height="185" alt="Passerelle LAB" src="https://github.com/user-attachments/assets/422eb19c-03df-4e48-bb94-fb38aa321d29" />

## 4. Installation du contrôleur de domaine

Le contrôleur de domaine utilisé est `DC300159203`.

### 4.1 Configuration IP

| Paramètre | Valeur |
|---|---|
| Nom | DC300159203 |
| Adresse IP | 172.16.21.10 |
| Masque | 255.255.255.0 |
| Passerelle | 172.16.21.1 |
| DNS | 127.0.0.1 / ::1 |

**CAPTURE 05 — Configuration IP du DC**

<img width="925" height="384" alt="Configuration IP DC" src="https://github.com/user-attachments/assets/dd65f929-2bc9-4031-af35-95dd9fa1c1b1" />

### 4.2 Installation du rôle Active Directory

Le rôle Active Directory Domain Services (AD DS) a été installé avec les outils de gestion nécessaires.

**CAPTURE 06 — Installation AD DS**

<img width="908" height="221" alt="Installation AD DS" src="https://github.com/user-attachments/assets/f12bde31-36ad-40de-8ca8-77f7154730ee" />

### 4.3 Création de la forêt

Une nouvelle forêt Active Directory a été créée.

| Paramètre | Valeur |
|---|---|
| Domaine | DC300159203.local |
| Nom NetBIOS | AD300159203 |
| Niveau fonctionnel | Windows2016Domain |

**CAPTURE 07 — Vérification du domaine**

<img width="928" height="241" alt="Domaine Active Directory" src="https://github.com/user-attachments/assets/1b388cf7-ff3b-48f5-8ddd-b217f4d7fd9f" />

## 5. Organisation Active Directory

Une unité organisationnelle principale nommée `OU300159203` a été créée.

Les sous-unités organisationnelles sont :

- Students
- Groups
- Workstations
- Servers
- ServiceAccounts

**CAPTURE 08 — Structure des OU**

<img width="813" height="303" alt="Structure des OU" src="https://github.com/user-attachments/assets/4e29b3e1-5565-417b-b7c8-cef1450b3e36" />

### 5.1 Création des utilisateurs

Les comptes suivants ont été créés dans l'unité organisationnelle `Students` :

- messi
- ronaldo
- mbappe
- haaland
- salah
- benzema
- modric
- neymar
- vinicius
- debruyne
- mahrez

**CAPTURE 09 — Utilisateurs Active Directory**

<img width="803" height="477" alt="Utilisateurs AD" src="https://github.com/user-attachments/assets/b1aca8e4-7478-400d-8cd1-1bf2933cc048" />

## 6. Groupes de sécurité et imbrication

Quatre groupes de sécurité ont été créés.

| Groupe | Type | Fonction |
|---|---|---|
| GG_Developers | Global | Développeurs |
| UG_ContentEditors | Universal | Éditeurs |
| DL_ProjectFolder_Modify | Domain Local | Modification |
| DL_ProjectFolder_Read | Domain Local | Lecture |

### 6.1 Création des groupes

**CAPTURE 10 — Groupes de sécurité**

<img width="817" height="226" alt="Groupes de sécurité" src="https://github.com/user-attachments/assets/98ed2dd7-6745-4573-9356-f4db337c013a" />

### 6.2 Imbrication des groupes

Le groupe `GG_Developers` et le groupe `UG_ContentEditors` ont été ajoutés au groupe `DL_ProjectFolder_Modify`.

**CAPTURE 11 — Imbrication des groupes**

<img width="820" height="226" alt="Imbrication des groupes" src="https://github.com/user-attachments/assets/213a4e55-6760-423b-b998-2c335e1c03cc" />

### 6.3 Membres de GG_Developers

Messi et Ronaldo sont membres du groupe Global `GG_Developers`.

**CAPTURE 20 — Membres GG_Developers**

<img width="815" height="236" alt="Membres GG Developers" src="https://github.com/user-attachments/assets/2f46e545-9449-4cb0-a7f8-3cf1a3ee9b42" />

### 6.4 Membres de UG_ContentEditors

Haaland et Mbappé sont membres du groupe Universal `UG_ContentEditors`.

**CAPTURE 21 — Membres UG_ContentEditors**

<img width="814" height="234" alt="Membres UG ContentEditors" src="https://github.com/user-attachments/assets/073ae018-5487-4f69-b631-9b9725cd0362" />

### 6.5 Groupe de lecture

Salah a été ajouté au groupe Domain Local `DL_ProjectFolder_Read`.

**CAPTURE 22 — Membre du groupe Read**

<img width="814" height="301" alt="Membre groupe Read" src="https://github.com/user-attachments/assets/01469771-c666-4dd2-8e9a-75d06339c288" />

## 7. Création du partage réseau et permissions

Un dossier nommé `ProjectFolder` a été créé sur le contrôleur de domaine.

**Emplacement :** `C:\ProjectFolder`

**Nom du partage :** `ProjectFolder`

**Chemin réseau :** `\\DC300159203\ProjectFolder`

### 7.1 Permissions SMB

Les permissions SMB ont été configurées comme suit :

| Groupe | Permission |
|---|---|
| Administrators | Full |
| DL_ProjectFolder_Modify | Change |
| DL_ProjectFolder_Read | Read |

**CAPTURE 12 — Création du partage**

<img width="818" height="219" alt="Partage ProjectFolder" src="https://github.com/user-attachments/assets/e860ac81-6342-466d-85bd-f2476721dce0" />

**CAPTURE 13 — Permissions SMB**

<img width="814" height="250" alt="Permissions SMB" src="https://github.com/user-attachments/assets/004ea903-3e99-48d6-bfd7-b0fa3fe3da8b" />

### 7.2 Permissions NTFS

Les permissions NTFS ont été configurées comme suit :

| Groupe | Permission |
|---|---|
| DL_ProjectFolder_Modify | Modify |
| DL_ProjectFolder_Read | Read & Execute |

L'héritage des permissions a été désactivé pour utiliser les autorisations explicites configurées pour les groupes.

**CAPTURE 14 — Permissions NTFS**

<img width="820" height="247" alt="Permissions NTFS" src="https://github.com/user-attachments/assets/e7e6fe5a-b16a-45a2-afe0-c6c7f28cd476" />

## 8. Configuration et intégration du poste client

Le poste client utilisé est `CLIENT01`.

### 8.1 Configuration IP

| Paramètre | Valeur |
|---|---|
| Nom | CLIENT01 |
| Adresse IP | 172.16.21.20 |
| Masque | 255.255.255.0 |
| Passerelle | 172.16.21.1 |
| DNS | 172.16.21.10 |
| Domaine | DC300159203.local |

**CAPTURE 15 — Configuration réseau CLIENT01**

<img width="788" height="320" alt="Configuration réseau CLIENT01" src="https://github.com/user-attachments/assets/5ba3bdfc-551b-483b-b0d9-e4fc47f52f6d" />

### 8.2 Jonction au domaine

Le poste client a été intégré au domaine Active Directory `DC300159203.local`.

**CAPTURE 16 — Jonction au domaine**

<img width="639" height="253" alt="Jonction au domaine" src="https://github.com/user-attachments/assets/a34fb5a8-1c64-424b-941e-6176b0c5d36b" />

## 9. Tests des permissions du partage réseau

Les tests suivants ont été effectués depuis le poste client CLIENT01.

### 9.1 Vérification de l'accès au partage

Le chemin réseau `\\DC300159203\ProjectFolder` a été testé depuis le client.

**Résultat :** True.

**CAPTURE 17 — Accès au partage réseau**

<img width="757" height="163" alt="Accès au partage" src="https://github.com/user-attachments/assets/fce02049-1367-4edb-afed-c9728c271d70" />

### 9.2 Test de modification avec Messi

Messi, membre du groupe `GG_Developers`, a réussi à créer un fichier dans le partage.

**Résultat :** accès en modification réussi.

**CAPTURE 18 — Test de modification avec Messi**

<img width="776" height="409" alt="Test Messi" src="https://github.com/user-attachments/assets/6cb4bace-004e-4d59-878b-edbb117b278d" />

### 9.3 Refus d'accès initial avec Salah

Avant son ajout au groupe de lecture, Salah ne disposait pas d'autorisation sur le partage.

**Résultat :** accès refusé.

**CAPTURE 19 — Refus d'accès initial avec Salah**

<img width="775" height="342" alt="Refus accès Salah" src="https://github.com/user-attachments/assets/c8d59797-2876-4c1c-93fd-12d82b1c171d" />

### 9.4 Test de lecture avec Salah

Après son ajout au groupe `DL_ProjectFolder_Read`, Salah a réussi à afficher les fichiers du dossier partagé.

**Résultat :** accès en lecture réussi.

**CAPTURE 23 — Test de lecture avec Salah**

<img width="765" height="391" alt="Test lecture Salah" src="https://github.com/user-attachments/assets/0038f45d-1e41-4815-a7ff-3d5d36dc1046" />

### 9.5 Refus de modification avec Salah

Salah a essayé de créer un fichier dans le partage, mais l'opération a été refusée.

**Résultat :** Access denied.

Cela confirme que Salah possède uniquement les permissions de lecture.

**CAPTURE 24 — Refus de modification avec Salah**

<img width="788" height="479" alt="Refus modification Salah" src="https://github.com/user-attachments/assets/770d6bbc-4c4a-46a5-8f09-99999d9ec30b" />

## 10. Informations de connexion du laboratoire

Pour les comptes créés dans le cadre de ce laboratoire, le mot de passe utilisé est :

**Mot de passe :** `Infra@2024`

Cette information concerne les comptes du laboratoire et ne doit pas être réutilisée pour des comptes personnels ou des services externes.

## 11. Résultats obtenus

Les objectifs principaux du laboratoire ont été réalisés :

- Création et configuration des machines virtuelles Hyper-V.
- Création du réseau privé et configuration du NAT.
- Installation et configuration d'Active Directory Domain Services.
- Création d'une forêt et d'un domaine indépendants.
- Configuration du DNS.
- Création des unités organisationnelles.
- Création et gestion des utilisateurs.
- Création des groupes Global, Universal et Domain Local.
- Imbrication des groupes de sécurité.
- Création du partage réseau SMB.
- Configuration des permissions SMB et NTFS.
- Configuration et intégration du poste client au domaine.
- Vérification des accès en lecture et en modification.
- Vérification du refus des opérations non autorisées.

## 12. Conclusion

Ce laboratoire m'a permis de pratiquer l'administration d'un environnement Windows Server avec Hyper-V et Active Directory.

J'ai appris à configurer un domaine, organiser les utilisateurs et les groupes, créer un partage réseau et appliquer des permissions adaptées aux différents profils.

Les tests effectués depuis CLIENT01 confirment que les utilisateurs peuvent accéder aux ressources selon les permissions attribuées à leurs groupes.  

<img width="2686" height="2070" alt="mermaid-diagram" src="https://github.com/user-attachments/assets/d48eb0ad-b5ce-41a9-bb94-bcb1cff3c308" />  

Ce que le schéma démontre
- Infrastructure : Hyper-V, switch interne, NAT et deux machines virtuelles.
- Services : Active Directory Domain Services et DNS.
- Organisation : OU, utilisateurs et groupes de sécurité.
- Sécurité : groupes imbriqués, permissions SMB et NTFS.
- Validation : Messi peut modifier les fichiers, tandis que Salah peut lire, mais pas créer de fichiers.

