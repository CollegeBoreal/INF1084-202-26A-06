
# Laboratoire 6 — Hyper-V imbriqué et Active Directory

**Cours :** INF1084 — Administration Windows  
**Numéro étudiant :** 300151722  
**Environnement :** Windows Server 2022 Datacenter

## 1. Objectif

L'objectif de ce laboratoire est de créer une infrastructure Active Directory indépendante avec Hyper-V imbriqué, un réseau privé, un contrôleur de domaine et une machine cliente.

## 2. Architecture réseau

| Élément | Configuration |
|---|---|
| Serveur Hyper-V | VM01 |
| Adresse IP du serveur parent | 10.7.237.206 |
| Commutateur virtuel | LAB |
| Réseau privé | 172.16.17.0/24 |
| Passerelle NAT | 172.16.17.1 |
| Contrôleur de domaine | DC300151722 |
| IP du contrôleur | 172.16.17.10 |
| Machine cliente | CLIENT01 |
| IP du client | 172.16.17.20 |
| Domaine Active Directory | DC300151722.local |
| Nom NetBIOS | DC151722 |
| Serveur DNS | 172.16.17.10 |

## 3. Création du réseau privé et du NAT

J'ai créé un commutateur Hyper-V interne nommé LAB, configuré l'adresse IP de la passerelle et créé une règle NAT.

```powershell
New-VMSwitch -Name LAB -SwitchType Internal

New-NetIPAddress `
    -IPAddress 172.16.17.1 `
    -PrefixLength 24 `
    -InterfaceAlias "vEthernet (LAB)"

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

Le commutateur LAB et le NAT LABNAT ont été configurés avec succès.

<img width="983" height="996" alt="1" src="https://github.com/user-attachments/assets/d78dbf09-a1a7-45ba-8571-ef2dda12ff59" />

## 4. Création des machines virtuelles

J'ai créé deux machines virtuelles de génération 2 dans Hyper-V.

### Contrôleur de domaine

```powershell
New-VM `
    -Name DC300151722 `
    -Generation 2 `
    -MemoryStartupBytes 4GB `
    -NewVHDPath "C:\VMs\DC300151722.vhdx" `
    -NewVHDSizeBytes 60GB `
    -SwitchName LAB
```

### Machine cliente

```powershell
New-VM `
    -Name CLIENT01 `
    -Generation 2 `
    -MemoryStartupBytes 4GB `
    -NewVHDPath "C:\VMs\CLIENT01.vhdx" `
    -NewVHDSizeBytes 60GB `
    -SwitchName LAB
```

La mémoire de CLIENT01 a ensuite été ajustée à 2 Go au démarrage pour tenir compte des ressources disponibles.

### Vérification

```powershell
Get-VM -Name DC300151722,CLIENT01
```

Les deux machines virtuelles fonctionnent dans Hyper-V.

<img width="712" height="669" alt="2" src="https://github.com/user-attachments/assets/c774df9f-b49b-40a6-8e01-f0685e7e1f94" />

## 5. Installation de Windows Server 2022

J'ai installé Windows Server 2022 Datacenter (Desktop Experience) sur les machines virtuelles à partir d'un fichier ISO.

J'ai ensuite configuré les noms et les adresses IP des machines.

### Configuration du contrôleur de domaine

```powershell
New-NetIPAddress `
    -InterfaceAlias "Ethernet" `
    -IPAddress 172.16.17.10 `
    -PrefixLength 24 `
    -DefaultGateway 172.16.17.1

Set-DnsClientServerAddress `
    -InterfaceAlias "Ethernet" `
    -ServerAddresses 172.16.17.10
```

## 6. Installation d'Active Directory

Sur DC300151722, j'ai installé le rôle AD DS et créé une nouvelle forêt.

```powershell
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
```

### Création de la forêt

```powershell
Install-ADDSForest `
    -DomainName "DC300151722.local" `
    -DomainNetbiosName "DC151722" `
    -InstallDns:$true `
    -Force
```

Le nom NetBIOS DC151722 a été utilisé pour respecter la limite de 15 caractères.

### Vérification

```powershell
Get-ADDomain
Get-ADForest
```

Le domaine DC300151722.local a été créé avec succès.

<img width="857" height="629" alt="3" src="https://github.com/user-attachments/assets/f3fbaab7-22e7-4352-9168-8d1bb7e6d20a" />

## 7. Création des unités d'organisation

J'ai créé une OU principale et quatre sous-OU pour organiser les objets Active Directory.

```powershell
New-ADOrganizationalUnit -Name "OU300151722"

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

Les unités d'organisation ont été créées avec succès.

<img width="921" height="780" alt="4" src="https://github.com/user-attachments/assets/bbf92b9b-7acb-47ea-a2ed-1ff389c344d0" />

## 8. Configuration de CLIENT01

J'ai configuré la machine CLIENT01 avec une adresse IP fixe et le DNS du contrôleur de domaine.

```powershell
Rename-Computer -NewName "CLIENT01" -Restart
```

### Configuration IP

```powershell
New-NetIPAddress `
    -InterfaceAlias "Ethernet" `
    -IPAddress 172.16.17.20 `
    -PrefixLength 24 `
    -DefaultGateway 172.16.17.1

Set-DnsClientServerAddress `
    -InterfaceAlias "Ethernet" `
    -ServerAddresses 172.16.17.10
```

### Tests réseau

```powershell
Test-Connection 172.16.17.10 -Count 2
Resolve-DnsName DC300151722.local
```

Les tests de connectivité et de résolution DNS ont réussi.

## 9. Intégration de CLIENT01 au domaine

J'ai joint CLIENT01 au domaine Active Directory.

```powershell
Add-Computer `
    -DomainName "DC300151722.local" `
    -Credential "DC151722\Administrator" `
    -Restart
```

### Vérification

```powershell
hostname
Get-ComputerInfo -Property CsDomain, CsPartOfDomain
```

Résultat :

```text
CsDomain       : DC300151722.local
CsPartOfDomain : True
```

CLIENT01 est membre du domaine Active Directory.

<img width="933" height="782" alt="5" src="https://github.com/user-attachments/assets/04882b0c-5cfe-4b32-ba42-0a6166a805e4" />

## 10. Vérification finale

Sur le contrôleur de domaine, j'ai utilisé les commandes suivantes :

```powershell
Get-ADDomain
Get-ADForest

Get-ADOrganizationalUnit -Filter * |
Format-Table Name, DistinguishedName -AutoSize

Get-ADComputer -Filter * |
Format-Table Name, DNSHostName -AutoSize
```

Les ordinateurs enregistrés dans Active Directory sont :

- DC300151722
- CLIENT01

## 11. Conclusion

Ce laboratoire m'a permis de mettre en place une infrastructure Active Directory avec Hyper-V imbriqué.

J'ai réussi à :

- Créer un réseau privé Hyper-V.
- Configurer une passerelle NAT.
- Créer deux machines virtuelles.
- Installer Windows Server 2022.
- Installer et configurer Active Directory Domain Services.
- Créer une forêt et un domaine.
- Configurer le service DNS.
- Créer des unités d'organisation.
- Joindre CLIENT01 au domaine.
- Vérifier la communication et l'intégration des machines.

**Résultat final :** le domaine DC300151722.local fonctionne et CLIENT01 y est intégré avec succès.
