# 🌐 **Active Directory (AD)**


| #️⃣ | Participations |
|-|-|
| 1️⃣ | [:tada: Participation](.scripts/Participation.md) |

<details>
<summary>📚 Table des matières</summary>

- [:scroll: Installation et configuration d’un domaine Active Directory](#scroll-installation-et-configuration-dun-domaine-active-directory)  
  - [1️⃣ Qu’est-ce qu’un domaine dans Active Directory ?](#1️⃣-quest-ce-quun-domaine-dans-active-directory-)  
  - [2️⃣ Quel est le rôle principal d’un contrôleur de domaine ?](#2️⃣-quel-est-le-rôle-principal-dun-contrôleur-de-domaine-)  
  - [3️⃣ Pourquoi le DNS est-il indispensable à Active Directory ?](#3️⃣-pourquoi-le-dns-est-il-indispensable-à-active-directory-)  
  - [4️⃣ Quelle est la différence entre une forêt et un arbre ?](#4️⃣-quelle-est-la-différence-entre-une-forêt-et-un-arbre-)  
  - [5️⃣ Que contient le dossier SYSVOL ?](#5️⃣-que-contient-le-dossier-sysvol-)  
  - [6️⃣ Quel service gère les connexions et l’authentification au domaine ?](#6️⃣-quel-service-gère-les-connexions-et-lauthentification-au-domaine-)  
  - [7️⃣ Que fait le mot de passe DSRM ?](#7️⃣-que-fait-le-mot-de-passe-dsrm-)  
  - [8️⃣ Quelle commande permet d’ouvrir la console “Active Directory Users and Computers” ?](#8️⃣-quelle-commande-permet-douvrir-la-console-active-directory-users-and-computers-)  
- [:abacus: Laboratoires](#abacus-laboratoires)  

</details>

## :scroll: Installation et configuration d’un domaine **Active Directory** 👇

---

### **1️⃣ Qu’est-ce qu’un domaine dans Active Directory ?**

Un **domaine** est une **unité logique d’administration** dans Active Directory.
Il regroupe des **utilisateurs**, **ordinateurs**, **groupes**, et **ressources** qui partagent :

* une **même base de données** (le catalogue AD DS),
* une **même politique de sécurité**,
* et une **même authentification** gérée par un ou plusieurs **contrôleurs de domaine (DC)**.

> 🧩 Exemple : `DC🆔.local` est un domaine.

---

### **2️⃣ Quel est le rôle principal d’un contrôleur de domaine ?**

Le **contrôleur de domaine (DC)** :

* **héberge** la base de données Active Directory,
* **authentifie** les utilisateurs et ordinateurs lors de la connexion au domaine,
* **applique** les stratégies de sécurité (GPO),
* et **réplique** les données AD avec les autres DC du même domaine.

> 🔐 En résumé : le DC est le **cœur de l’infrastructure Active Directory**.

---

### **3️⃣ Pourquoi le DNS est-il indispensable à Active Directory ?**

Le **DNS (Domain Name System)** permet :

* de **localiser** les contrôleurs de domaine (DC) via des enregistrements **SRV**,
* d’assurer la **résolution de noms** (ex. : `DC🆔.local` → IP du DC),
* et de permettre aux clients et serveurs de **trouver les services AD DS** (authentification, réplication, etc.).

> 🧠 Sans DNS, Active Directory **ne peut pas fonctionner correctement**.

---

### **4️⃣ Quelle est la différence entre une forêt et un arbre ?**

| Élément   | Description                                                                                                  |
| --------- | ------------------------------------------------------------------------------------------------------------ |
| **Arbre** | Ensemble de domaines **hiérarchiquement liés** (ex. : `sales.DC🆔.local` et `hr.DC🆔.local`).                  |
| **Forêt** | Ensemble d’un ou plusieurs **arbres** partageant le **même schéma AD** et la **même configuration globale**. |

> 🌳 Une forêt peut contenir plusieurs arbres, chacun avec ses propres domaines.

---

### **5️⃣ Que contient le dossier SYSVOL ?**

> 📁 Le dossier **SYSVOL** contient :
> `C:\Windows\SYSVOL`

* les **scripts de connexion** (logon scripts),
  > 📁 Emplacement typique :
  > `C:\Windows\SYSVOL\sysvol\<nom_du_domaine>\scripts`
* les **fichiers des stratégies de groupe (GPO)**,
  > 📁 Emplacement typique :
  > `C:\Windows\SYSVOL\sysvol\<nom_du_domaine>\Policies`
* et d’autres données **synchronisées entre les contrôleurs de domaine**.


---

### **6️⃣ Quel service gère les connexions et l’authentification au domaine ?**

C’est le **service Active Directory Domain Services (AD DS)**.
Il s’appuie sur :

* le **protocole Kerberos** (authentification sécurisée),
* et le **protocole LDAP** (accès à la base d’annuaire).

> 🔑 Kerberos = authentification
> 📚 LDAP = requêtes et gestion des objets AD

---

### **7️⃣ Que fait le mot de passe DSRM ?**

Le **mot de passe DSRM (Directory Services Restore Mode)** sert à :

* accéder au **mode de restauration d’Active Directory**,
* lorsque le domaine est **en panne** ou doit être **réparé**.

> 🩺 C’est un mot de passe **local** au serveur DC (pas un compte de domaine).

---

### **8️⃣ Quelle commande permet d’ouvrir la console “Active Directory Users and Computers” ?**

#### 💠 En PowerShell :

Tu peux aussi l’ouvrir via :

```powershell
Start-Process dsa.msc
```

> 📋 Cette console permet de gérer utilisateurs, groupes, ordinateurs et unités d’organisation (OU).


# :abacus: Laboratoires


Installer et configurer un contrôleur de domaine Active Directory sur **Windows Server 2022**.

---

## 🚀 Installation AD : Étapes avec PowerShell

### 1. Renommer le serveur

```powershell
Rename-Computer -NewName "DC🆔" -Restart
```

*(le serveur va redémarrer)*

---

### 2. Installer le rôle AD DS

```powershell
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
```
<details>
<summary>Output</summary>

```powershell

Success Restart Needed Exit Code      Feature Result
------- -------------- ---------      --------------
True    No             Success        {Active Directory Domain Services, Group P...
```

</details>

---

### 3. Créer un nouveau domaine (nouvelle forêt)

Exemple avec domaine **DC🆔.local** :

```powershell
Install-ADDSForest `
    -DomainName "DC🆔.local" `
    -DomainNetbiosName "DC🆔" `
    -InstallDns:$true `
    -SafeModeAdministratorPassword (ConvertTo-SecureString "MotDePasseDSRM123!" -AsPlainText -Force) `
    -Force
```
<details>
<summary>Output</summary>

```powershell
Install-ADDSForest

  Validating environment and user input
      All tests completed successfully                                                                                       [oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo]
      Installing new forest Starting

For more information about this setting, see Knowledge Base article 942564
(http://go.microsoft.com/fwlink/?LinkId=104751).

WARNING: This computer has at least one physical network adapter that does not have static IP address(es) assigned to
its IP Properties. If both IPv4 and IPv6 are enabled for a network adapter, both IPv4 and IPv6 static IP addresses
should be assigned to both IPv4 and IPv6 Properties of the physical network adapter. Such static IP address(es)
assignment should be done to all the physical network adapters for reliable Domain Name System (DNS) operation.

WARNING: A delegation for this DNS server cannot be created because the authoritative parent zone cannot be found or it
 does not run Windows DNS server. If you are integrating with an existing DNS infrastructure, you should manually
create a delegation to this DNS server in the parent zone to ensure reliable name resolution from outside the domain
"DC🆔.local". Otherwise, no action is required.

WARNING: Windows Server 2022 domain controllers have a default for the security setting named "Allow cryptography
algorithms compatible with Windows NT 4.0" that prevents weaker cryptography algorithms when establishing security
channel sessions.

For more information about this setting, see Knowledge Base article 942564
(http://go.microsoft.com/fwlink/?LinkId=104751).

WARNING: This computer has at least one physical network adapter that does not have static IP address(es) assigned to
its IP Properties. If both IPv4 and IPv6 are enabled for a network adapter, both IPv4 and IPv6 static IP addresses
should be assigned to both IPv4 and IPv6 Properties of the physical network adapter. Such static IP address(es)
assignment should be done to all the physical network adapters for reliable Domain Name System (DNS) operation.
```

</details>

* `-DomainName` → nom DNS du domaine.
* `-DomainNetbiosName` → version courte (max 15 caractères, ex. DC🆔).
* `-InstallDns:$true` → installe DNS en même temps.
* `-SafeModeAdministratorPassword` → mot de passe pour le mode restauration DSRM.
* `-Force` → évite les confirmations.

👉 Le serveur redémarrera automatiquement.

---

### 4. Vérifier l’installation

Une fois redémarré, connecte-toi avec :

```
DC🆔\Administrator
```

Puis vérifie :

```powershell
Get-ADDomain
Get-ADForest
```

---

## 🎯 Résultat

Avec seulement **3 commandes PowerShell**, tu crées un **contrôleur de domaine Active Directory** complet avec DNS intégré.

### :gear: Configuration

| Windows Server 2022 Datacenter            | User/Pwd                   |
|-------------------------------------------|----------------------------|
| [Participation](.scripts/Participation.md)| Administrator/Infra@2️⃣02️⃣4  |