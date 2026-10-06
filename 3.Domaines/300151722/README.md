# Laboratoire 3 - Active Directory

**Nom : Oustani Islam**  
**ID : 300151722**  
**Système : Windows Server 2022 Datacenter**

## Objectif

L'objectif de ce laboratoire est d'installer et de configurer **Active Directory Domain Services (AD DS)** sur Windows Server 2022, puis de créer un nouveau domaine avec DNS intégré.

Le domaine configuré est :

```text
DC300151722.local
```

Le serveur utilisé comme contrôleur de domaine est :

```text
SRV300151722
```

---

## 1. Renommer le serveur

Le serveur a été renommé afin d'éviter un conflit avec le nom NetBIOS du domaine.

```powershell
Rename-Computer -NewName "SRV300151722" -Restart
```

Après le redémarrage, le nom du serveur a été vérifié avec :

```powershell
hostname
```

Résultat :

```text
SRV300151722
```

---

## 2. Installer le rôle Active Directory Domain Services

Le rôle **AD DS** et les outils d'administration ont été installés avec PowerShell :

```powershell
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
```

### Preuve de l'installation

<img width="997" height="232" alt="1" src="https://github.com/user-attachments/assets/adfcbde6-a646-458d-bd1a-f65019b35041" />


Le résultat `Success : True` confirme que le rôle **Active Directory Domain Services** a été installé correctement.

---

## 3. Créer le domaine Active Directory

Le nouveau domaine utilisé dans ce laboratoire est :

```text
DC300151722.local
```

La commande utilisée pour créer la forêt Active Directory est :

```powershell
Install-ADDSForest `
    -DomainName "DC300151722.local" `
    -SafeModeAdministratorPassword (Read-Host "Entrez le mot de passe DSRM" -AsSecureString) `
    -Force
```

Le mot de passe DSRM est saisi de manière sécurisée et n'est pas affiché dans la documentation.

Après la configuration, le serveur redémarre et devient contrôleur de domaine.

---

## 4. Vérifier le domaine et la forêt

Après le redémarrage, les commandes suivantes ont été utilisées :

```powershell
Get-ADDomain
Get-ADForest
```

### Preuve de la configuration Active Directory

<img width="1168" height="1073" alt="2" src="https://github.com/user-attachments/assets/4d9d059b-5da6-46c7-9dc1-5d7910ca103d" />


La sortie confirme notamment :

```text
Domaine : DC300151722.local
NetBIOS : DC300151722
Contrôleur de domaine : SRV300151722.DC300151722.local
```

Les commandes `Get-ADDomain` et `Get-ADForest` confirment donc que le domaine et la forêt Active Directory ont été créés avec succès.

---

## 5. Vérifier le DNS

Active Directory utilise DNS pour permettre aux ordinateurs et aux services de localiser le contrôleur de domaine.

Le gestionnaire DNS a été ouvert afin de vérifier que le service DNS est installé sur le serveur.

### Preuve DNS

<img width="1030" height="715" alt="3" src="https://github.com/user-attachments/assets/26a7995d-ddcb-4037-969d-de1e18ecb672" />


Le serveur `SRV300151722` apparaît dans **DNS Manager** avec les zones de recherche directe et inverse disponibles.

---

## Résultat

Le serveur Windows Server 2022 a été configuré avec succès comme contrôleur de domaine Active Directory.

| Élément | Configuration |
|---|---|
| Serveur | `SRV300151722` |
| Domaine Active Directory | `DC300151722.local` |
| Nom NetBIOS | `DC300151722` |
| Rôle | Active Directory Domain Services |
| DNS | Installé et intégré au domaine |

---

## Conclusion

Ce laboratoire a permis d'installer **Active Directory Domain Services**, de créer le domaine `DC300151722.local` et de vérifier son fonctionnement avec PowerShell. Le service DNS est également installé et permet au contrôleur de domaine de fournir les services nécessaires à l'environnement Active Directory.
