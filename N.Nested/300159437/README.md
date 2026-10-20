
# Laboratoire INF1084 — Déploiement d'un domaine Active Directory avec Hyper-V

**Étudiant :** Bob Adly Pierre  
**Matricule :** 300159437  
**Environnement :** Windows Server 2022, Hyper-V, PowerShell et Active Directory  
**Domaine :** `DC300159437.local`

---

## 1. Introduction

Dans le cadre du cours INF1084, ce laboratoire avait pour objectif de déployer une infrastructure Active Directory dans un environnement virtualisé avec Hyper-V.

Le travail consistait à créer un contrôleur de domaine, configurer le réseau, installer une deuxième machine virtuelle, puis intégrer cette dernière au domaine Active Directory.

Ce laboratoire m'a permis de mettre en pratique mes connaissances en administration Windows Server, en virtualisation et en gestion centralisée des ordinateurs.

## 2. Objectifs du laboratoire

- Configurer un environnement de virtualisation Hyper-V.
- Déployer un contrôleur de domaine Windows Server 2022.
- Installer et configurer Active Directory Domain Services (AD DS).
- Créer une forêt et un domaine Active Directory.
- Configurer les adresses IP et le DNS.
- Installer une machine virtuelle cliente.
- Joindre CLIENT01 au domaine.
- Organiser les objets dans une unité d'organisation (OU).
- Vérifier la communication et la relation de confiance.

## 3. Présentation de l'infrastructure

| Équipement | Rôle | Adresse IP |
|---|---|---|
| SRV300159437 | Serveur hôte Hyper-V | Passerelle virtuelle : 172.16.22.1 |
| DC300159437 | Contrôleur de domaine et DNS | 172.16.22.223 |
| CLIENT01 | Serveur membre du domaine | 172.16.22.20 |

**Réseau :** `172.16.22.0/24`  
**Commutateur virtuel :** `LAB`  
**Domaine Active Directory :** `DC300159437.local`  
**Nom NetBIOS :** `LAB300159437`

## 4. Création du contrôleur de domaine

Une machine virtuelle nommée `DC300159437` a été préparée avec Windows Server 2022.

L'adresse IP statique `172.16.22.223` a été attribuée au contrôleur de domaine.

### Installation du rôle AD DS

```powershell
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
```

### Création de la forêt Active Directory

```powershell
Install-ADDSForest `
    -DomainName "DC300159437.local" `
    -DomainNetbiosName "LAB300159437" `
    -InstallDNS
```

Après le redémarrage, la création du domaine a été vérifiée avec :

```powershell
Get-ADDomain
```

**Résultat :** la forêt et le domaine Active Directory ont été créés avec succès.

## 5. Création des unités d'organisation

Plusieurs unités d'organisation ont été préparées afin de structurer les ressources du domaine.

- Students
- Groups
- Workstations
- Servers

Ces OU permettent de faciliter l'administration et l'organisation des objets Active Directory.

## 6. Création de la machine virtuelle CLIENT01

Une deuxième machine virtuelle nommée `CLIENT01` a été créée dans Hyper-V.

### Commandes utilisées

```powershell
New-VM -Name "CLIENT01" `
    -Generation 2 `
    -MemoryStartupBytes 4GB `
    -NewVHDPath "C:\VMs\CLIENT01.vhdx" `
    -NewVHDSizeBytes 60GB `
    -SwitchName "LAB"
```

```powershell
Set-VMProcessor -VMName "CLIENT01" -Count 2
```

### Installation du système d'exploitation

L'image ISO de Windows Server 2022 a été connectée au lecteur DVD virtuel de CLIENT01.

L'édition **Windows Server 2022 Datacenter (Desktop Experience)** a été sélectionnée afin de disposer d'une interface graphique.

L'installation s'est terminée avec succès.

## 7. Configuration réseau de CLIENT01

Après l'installation, le nom de l'ordinateur et son interface réseau ont été vérifiés.

```powershell
hostname
Get-NetAdapter
Get-NetIPConfiguration
```

L'interface réseau utilisée était `Ethernet`.

### Configuration IPv4

```powershell
New-NetIPAddress `
    -InterfaceAlias "Ethernet" `
    -IPAddress 172.16.22.224`
    -PrefixLength 24 `
    -DefaultGateway 172.16.22.1
```

### Configuration du DNS

```powershell
Set-DnsClientServerAddress `
    -InterfaceAlias "Ethernet" `
    -ServerAddresses 172.16.22.223
```

Cette configuration permet à CLIENT01 de communiquer avec le contrôleur de domaine et de résoudre les noms DNS internes.

## 8. Vérification de la communication réseau

### Test de connectivité

```powershell
Test-Connection 172.16.22.223 -Count 4
```

**Résultat :** quatre réponses ont été reçues du contrôleur de domaine.

### Test DNS

```powershell
Resolve-DnsName DC300159437.local
```

**Résultat :** le domaine a été correctement résolu vers `172.16.22.223`.

Ces tests confirment que la communication réseau et la résolution DNS fonctionnent.

## 9. Jonction de CLIENT01 au domaine

La commande suivante a été exécutée sur CLIENT01 :

```powershell
Add-Computer `
    -DomainName "DC300159437.local" `
    -Credential "LAB300159437\Administrator" `
    -Restart
```

Après l'authentification et le redémarrage, l'appartenance au domaine a été vérifiée.

```powershell
Get-CimInstance Win32_ComputerSystem |
Select-Object Name, Domain, PartOfDomain
```

### Résultat

```text
Name      Domain              PartOfDomain
----      ------              ------------
CLIENT01  DC300159437.local   True
```

Ce résultat confirme que CLIENT01 est devenu membre du domaine Active Directory.

## 10. Organisation de CLIENT01 dans Active Directory

Après la jonction, l'objet ordinateur CLIENT01 se trouvait initialement dans le conteneur `Computers`.

L'unité d'organisation `Workstations` a été identifiée à l'aide de :

```powershell
Get-ADOrganizationalUnit -Filter 'Name -eq "Workstations"' |
Select-Object Name, DistinguishedName
```

### Déplacement de l'ordinateur

```powershell
Get-ADComputer -Identity "CLIENT01" |
Move-ADObject -TargetPath "OU=Workstations,DC=DC300159437,DC=local"
```

### Vérification

```powershell
Get-ADComputer -Identity "CLIENT01" |
Select-Object Name, DistinguishedName
```

**Résultat obtenu :**

```text
CN=CLIENT01,OU=Workstations,DC=DC300159437,DC=local
```

Le déplacement de CLIENT01 vers l'OU Workstations a été effectué avec succès.

## 11. Vérification finale du canal sécurisé

Une dernière vérification a été réalisée sur CLIENT01 afin de confirmer la relation de confiance avec le domaine.

```powershell
Test-ComputerSecureChannel
```

**Résultat :**

```text
True
```

Ce résultat confirme que le canal sécurisé entre CLIENT01 et Active Directory fonctionne correctement.

## 12. Difficultés rencontrées et solutions

### Problème 1 — Démarrage PXE de CLIENT01

**Difficulté :** la machine virtuelle tentait de démarrer sur le réseau au lieu du support d'installation.

**Solution :** ajout d'un lecteur DVD virtuel, connexion de l'image ISO et configuration de l'ordre de démarrage dans Hyper-V.

### Problème 2 — Adresse IP automatique

**Difficulté :** CLIENT01 possédait initialement une adresse APIPA `169.254.24.137`.

**Solution :** attribution d'une adresse IP statique et configuration du serveur DNS Active Directory.

### Problème 3 — Déplacement de CLIENT01

**Difficulté :** la première tentative de déplacement dans Workstations n'a pas donné le résultat attendu.

**Solution :** vérification du DistinguishedName réel de l'OU Workstations, puis utilisation du chemin correct dans `Move-ADObject`.

## 13. Résultats du laboratoire

| Test | Résultat |
|---|---|
| Déploiement du contrôleur de domaine | Réussi |
| Création du domaine Active Directory | Réussi |
| Installation de CLIENT01 | Réussi |
| Configuration IPv4 et DNS | Réussi |
| Communication avec le contrôleur de domaine | Réussi |
| Résolution DNS | Réussi |
| Jonction de CLIENT01 au domaine | Réussi |
| Déplacement dans Workstations | Réussi |
| Test du canal sécurisé | Réussi |

## 14. Conclusion

Ce laboratoire m'a permis de mieux comprendre le fonctionnement d'une infrastructure Active Directory et l'importance des différents composants nécessaires à son déploiement.

J'ai appris à configurer un contrôleur de domaine, à préparer une machine virtuelle, à établir la communication entre plusieurs serveurs et à intégrer un ordinateur dans un domaine.

J'ai également rencontré plusieurs difficultés, notamment au niveau du démarrage de la machine virtuelle, de la configuration réseau et de l'organisation des objets Active Directory.

La résolution de ces problèmes m'a aidé à développer mes compétences en dépannage, en administration système et en utilisation de PowerShell.

**Le laboratoire s'est terminé avec succès, comme le confirme le résultat `True` de la commande `Test-ComputerSecureChannel`.**
