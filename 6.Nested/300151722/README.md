# Laboratoire 6 — Hyper-V imbriqué et Active Directory

**Cours :** INF1084 — Administration Windows  
**Numéro étudiant :** 300151722  
**Système d'exploitation :** Windows Server 2022 Datacenter  
**Laboratoire :** 6.Nested

---

## 1. Objectif du laboratoire

L'objectif de ce laboratoire est de mettre en place une infrastructure réseau indépendante à l'aide d'Hyper-V imbriqué et d'Active Directory.

Chaque étudiant doit disposer de son propre réseau privé, de son domaine Active Directory, de son serveur DNS et de ses machines virtuelles.

Dans ce laboratoire, j'ai configuré un contrôleur de domaine nommé DC300151722 et une machine cliente nommée CLIENT01.

## 2. Architecture réseau

| Élément | Configuration |
|---|---|
| Serveur principal | VM01 |
| Adresse IP du serveur principal | 10.7.237.206 |
| Commutateur Hyper-V | LAB |
| Réseau privé | 172.16.17.0/24 |
| Passerelle NAT | 172.16.17.1 |
| Contrôleur de domaine | DC300151722 |
| Adresse IP du DC | 172.16.17.10 |
| Machine cliente | CLIENT01 |
| Adresse IP du client | 172.16.17.20 |
| Domaine | DC300151722.local |
| Nom NetBIOS | DC151722 |
| DNS | 172.16.17.10 |

### Schéma de l'architecture

```text
VM01 — 10.7.237.206
│
├── Hyper-V
│
└── LAB — Réseau privé
    │
    ├── Passerelle NAT
    │   172.16.17.1
    │
    ├── DC300151722
    │   172.16.17.10
    │   DC300151722.local
    │
    └── CLIENT01
        172.16.17.20
```

---

## 3. Création du réseau privé Hyper-V

J'ai commencé par créer un commutateur virtuel interne nommé LAB.

```powershell
New-VMSwitch -Name LAB -SwitchType Internal
```

Ensuite, j'ai configuré l'adresse IP de la passerelle.

```powershell
New-NetIPAddress `
    -IPAddress 172.16.17.1 `
    -PrefixLength 24 `
    -InterfaceAlias "vEthernet (LAB)"
```

J'ai créé le NAT pour le réseau privé.

```powershell
New-NetNat `
    -Name LABNAT `
    -InternalIPInterfaceAddressPrefix 172.16.17.0/24
```

### Vérification

```powershell
Get-VMSwitch
Get-NetIPAddress -InterfaceAlias "vEthernet (LAB)" -AddressFamily IPv4
Get-NetNat
```

**Résultat :** le commutateur LAB, l'adresse IP 172.16.17.1 et le NAT LABNAT ont été créés correctement.

<img width="983" height="996" alt="1" src="https://github.com/user-attachments/assets/0409f94f-07d6-4104-810e-7797495a464f" />

*Capture à insérer : `images/1.png` — Création de l'adresse IP et du NAT.*


*Capture à insérer : `images/2.png` — Résultats de Get-VMSwitch et Get-NetNat.*

---

## 4. Création du contrôleur de domaine

J'ai créé la machine virtuelle DC300151722 avec Hyper-V.

```powershell
New-VM `
    -Name DC300151722 `
    -Generation 2 `
    -MemoryStartupBytes 4GB `
    -NewVHDPath "C:\VMs\DC300151722.vhdx" `
    -NewVHDSizeBytes 60GB `
    -SwitchName LAB
```

### Vérification

```powershell
Get-VM -Name DC300151722
```

La machine virtuelle a été créée avec succès.

<img width="857" height="629" alt="3" src="https://github.com/user-attachments/assets/260be129-a140-4dca-9a3b-44d938071ca4" />

*Capture à insérer : `images/3.png`.*

---

## 5. Installation de Windows Server 2022

J'ai utilisé une image ISO de Windows Server 2022 afin d'installer le système d'exploitation.

L'édition choisie est **Windows Server 2022 Datacenter (Desktop Experience)**.

Cette version permet d'utiliser Windows Server avec une interface graphique pour faciliter l'administration.

<img width="921" height="780" alt="4" src="https://github.com/user-attachments/assets/ecf9967d-43cc-4085-8186-941a9e71f639" />

*Capture à insérer : `images/4.png` — Sélection de Datacenter (Desktop Experience).*


*Capture à insérer : `images/5.png` — Installation du système.*

---

## 6. Configuration du contrôleur de domaine

J'ai configuré le nom et l'adresse IP du serveur.

### Renommer le serveur

```powershell
Rename-Computer -NewName "DC300151722" -Restart
```

### Configuration IP

```powershell
New-NetIPAddress `
    -InterfaceAlias "Ethernet" `
    -IPAddress 172.16.17.10 `
    -PrefixLength 24 `
    -DefaultGateway 172.16.17.1
```

### Configuration DNS

```powershell
Set-DnsClientServerAddress `
    -InterfaceAlias "Ethernet" `
    -ServerAddresses 172.16.17.10
```

### Vérification

```powershell
hostname
Get-NetIPConfiguration
Test-Connection 172.16.17.1 -Count 2
```

**Résultat :** le serveur DC utilise l'adresse IP 172.16.17.10 et communique avec la passerelle du réseau privé.

---

## 7. Installation d'Active Directory Domain Services

J'ai installé le rôle AD DS à l'aide de PowerShell.

```powershell
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
```

### Création de la forêt Active Directory

```powershell
Install-ADDSForest `
    -DomainName "DC300151722.local" `
    -DomainNetbiosName "DC151722" `
    -InstallDns:$true `
    -Force
```

J'ai utilisé DC151722 comme nom NetBIOS afin de respecter la limite de 15 caractères.

### Vérification

```powershell
Get-ADDomain
Get-ADForest
```

Le domaine DC300151722.local a été créé et fonctionne correctement.

<img width="952" height="815" alt="6" src="https://github.com/user-attachments/assets/a94e5d52-47b8-44cf-8cf7-39b12b4467b8" />

*Insérer une capture du résultat de Get-ADDomain et Get-ADForest.*

---

## 8. Création des unités d'organisation

J'ai créé une unité d'organisation principale portant mon numéro étudiant.

```powershell
New-ADOrganizationalUnit -Name "OU300151722"
```

Ensuite, j'ai créé quatre sous-OU.

```powershell
$OU = "OU=OU300151722,DC=DC300151722,DC=local"

New-ADOrganizationalUnit -Name "Students" -Path $OU
New-ADOrganizationalUnit -Name "Groups" -Path $OU
New-ADOrganizationalUnit -Name "Workstations" -Path $OU
New-ADOrganizationalUnit -Name "Servers" -Path $OU
```

### Vérification

```powershell
Get-ADOrganizationalUnit -Filter * |
Format-Table Name, DistinguishedName -AutoSize
```

**Résultat :** les unités d'organisation suivantes ont été créées : OU300151722, Students, Groups, Workstations et Servers.


*Insérer la capture montrant les cinq OU.*

---

## 9. Création de la machine cliente CLIENT01

J'ai créé une deuxième machine virtuelle nommée CLIENT01.

```powershell
New-VM `
    -Name CLIENT01 `
    -Generation 2 `
    -MemoryStartupBytes 4GB `
    -NewVHDPath "C:\VMs\CLIENT01.vhdx" `
    -NewVHDSizeBytes 60GB `
    -SwitchName LAB
```

### Ajustement de la mémoire

Pour résoudre un problème de mémoire insuffisante, j'ai réduit la mémoire de démarrage de CLIENT01 à 2 Go.

```powershell
Set-VMMemory -VMName CLIENT01 `
    -StartupBytes 2GB `
    -DynamicMemoryEnabled $true `
    -MinimumBytes 1GB `
    -MaximumBytes 4GB
```

### Vérification

```powershell
Get-VM -Name DC300151722,CLIENT01
```

Les deux machines virtuelles ont pu fonctionner simultanément.

<img width="1108" height="933" alt="8" src="https://github.com/user-attachments/assets/88b644ed-a6b6-4208-994a-77b0b834ad03" />

*Capture à insérer : `images/7.png` — Les deux VM en état Running.*

---

## 10. Configuration réseau de CLIENT01

J'ai configuré le nom de l'ordinateur et son adresse IP.

### Renommer CLIENT01

```powershell
Rename-Computer -NewName "CLIENT01" -Restart
```

### Configurer l'adresse IP

```powershell
New-NetIPAddress `
    -InterfaceAlias "Ethernet" `
    -IPAddress 172.16.17.20 `
    -PrefixLength 24 `
    -DefaultGateway 172.16.17.1
```

### Configurer le serveur DNS

```powershell
Set-DnsClientServerAddress `
    -InterfaceAlias "Ethernet" `
    -ServerAddresses 172.16.17.10
```

### Vérification réseau

```powershell
hostname
Get-NetIPConfiguration
Test-Connection 172.16.17.10 -Count 2
Resolve-DnsName DC300151722.local
```

**Résultat :** CLIENT01 communique correctement avec le contrôleur de domaine. La résolution DNS fonctionne.

<img width="1065" height="815" alt="9" src="https://github.com/user-attachments/assets/f22eaf60-9e69-4742-8ce7-b0b1a9319a0e" />

*Capture à insérer : `images/9.png`.*

---

## 11. Intégration de CLIENT01 au domaine Active Directory

J'ai joint la machine CLIENT01 au domaine DC300151722.local.

```powershell
Add-Computer `
    -DomainName "DC300151722.local" `
    -Credential "DC151722\Administrator" `
    -Restart
```

Après le redémarrage, je me suis connecté au domaine avec le compte administrateur.

### Vérification

```powershell
hostname
Get-ComputerInfo -Property CsDomain, CsPartOfDomain
```

### Résultat

```text
CsDomain       : DC300151722.local
CsPartOfDomain : True
```

Cela confirme que CLIENT01 appartient au domaine.

<img width="1185" height="733" alt="10" src="https://github.com/user-attachments/assets/411dd572-9507-49e6-9c1a-f6a5ff1952e1" />

*Capture à insérer : `images/10.png`.*

---

## 12. Vérification finale du laboratoire

Sur le contrôleur de domaine, j'ai vérifié les informations Active Directory.

```powershell
Get-ADDomain
Get-ADForest
```

### Vérification des ordinateurs

```powershell
Get-ADComputer -Filter * |
Format-Table Name, DNSHostName -AutoSize
```

### Résultat obtenu

```text
Name          DNSHostName
----          -----------
DC300151722   DC300151722.DC300151722.local
CLIENT01      CLIENT01.DC300151722.local
```

Les deux ordinateurs sont enregistrés dans Active Directory.

<img width="1128" height="790" alt="11" src="https://github.com/user-attachments/assets/ba7f5bce-bdac-4236-b11d-8f5f9c3d60ad" />

*Capture à insérer : `images/11.png`.*

### Vérification des OU

```powershell
Get-ADOrganizationalUnit -Filter * |
Format-Table Name, DistinguishedName -AutoSize
```

<img width="1150" height="798" alt="12" src="https://github.com/user-attachments/assets/ca00d97d-bd01-437f-9423-4cfe7de5b35f" />

*Capture à insérer : `images/12.png` — Liste des OU et des ordinateurs Active Directory.*

---

## 13. Difficultés rencontrées

### Problème de démarrage Hyper-V

Une erreur de démarrage UEFI empêchait initialement l'installation de Windows Server. Après plusieurs vérifications du fichier ISO et de la configuration Hyper-V, j'ai réussi à installer le système.

### Problème de nom NetBIOS

La création du domaine a échoué lors de la première tentative car un nom NetBIOS valide devait être spécifié.

J'ai corrigé la commande avec `-DomainNetbiosName "DC151722"`.

### Problème de mémoire RAM

CLIENT01 ne pouvait pas démarrer à cause d'un manque de mémoire disponible.

J'ai arrêté la machine de test TEST-BOOT et configuré la mémoire dynamique de CLIENT01.

### Problème de copier-coller

Le copier-coller dans Hyper-V ne fonctionnait pas initialement. J'ai configuré le mode de session améliorée pour faciliter l'administration de la VM.


### Connexion avec un utilisateur Active Directory

J'ai créé un utilisateur nommé Etudiant1 dans l'unité d'organisation Students du domaine DC300151722.local.

J'ai ensuite autorisé cet utilisateur à se connecter à distance à CLIENT01 en l'ajoutant au groupe Remote Desktop Users.

La connexion avec DC151722\Etudiant1 a réussi.

Les commandes de vérification sont :

```powershell
whoami
hostname
```

Résultats obtenus :

```text
dc151722\etudiant1
CLIENT01
```

<img width="1195" height="738" alt="1111111111111111111111111111111" src="https://github.com/user-attachments/assets/eb0a549c-4724-4b67-bbd3-590ecc13dbcf" />

---

## 14. Conclusion

Ce laboratoire m'a permis de créer une infrastructure Active Directory indépendante à l'aide d'Hyper-V imbriqué.

J'ai réussi à :

- Créer un réseau privé Hyper-V.
- Configurer un commutateur LAB et une passerelle NAT.
- Créer les machines virtuelles DC300151722 et CLIENT01.
- Installer Windows Server 2022 Datacenter.
- Installer le rôle AD DS.
- Créer une forêt et un domaine Active Directory.
- Configurer le serveur DNS.
- Créer des unités d'organisation.
- Configurer la machine cliente.
- Intégrer CLIENT01 au domaine.
- Vérifier la communication réseau et les objets Active Directory.

**Résultat final :** le domaine `DC300151722.local` fonctionne correctement et la machine CLIENT01 est membre du domaine.

**Laboratoire 6.Nested terminé avec succès.**
