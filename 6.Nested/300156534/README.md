# LABORATOIRE 6.Nested | COMPTE RENDU TECHNIQUE

```
Étudiant : Oualid Salhi
Matricule : 300156534
Date : 17 novembre 2026
Serveur parent : SRV300156534 — 10.7.237.212
Réseau privé : 172.16.26.0/24
Passerelle : 172.16.26.1
Contrôleur de domaine : DC300156534 — 172.16.26.10
Domaine : DC300156534.local
Nom NetBIOS : AD300156534
Client : CLIENT01 — 172.16.26.20
Compte administrateur : Administrator
Mot de passe : walid@2026
CONFIDENTIEL — Le mot de passe est inscrit à la demande de l’étudiant. Ne pas publier ce document sur GitHub. Modifier ce mot de passe avant toute diffusion.
```

## 1. Objectif et architecture

Créer une infrastructure indépendante comprenant un commutateur Hyper-V interne, une passerelle NAT, un contrôleur de domaine AD DS et DNS, quatre sous-unités organisationnelles et un client membre du domaine.

```
SRV300156534 (10.7.237.212)
  LAB / LABNAT — 172.16.26.0/24
  ├─ SRV01 : DC300156534 — 172.16.26.10
  └─ CLIENT01 — 172.16.26.20
```

## 2. Création du réseau privé Hyper-V

Création du commutateur interne LAB et vérification des commutateurs disponibles.
Commandes PowerShell utilisées:

```powershell
Get-VMSwitch
New-VMSwitch -Name LAB -SwitchType Internal
Get-VMSwitch
```

Capture 01 — Commutateur virtuel et état initial
 <img width="893" height="864" alt="image" src="https://github.com/user-attachments/assets/efd279ee-351f-4f3f-973d-40a9b80a9750" />

Preuve visuelle de l’étape de configuration ou de vérification correspondante.
Capture 02 — Commutateur virtuel et état initial
 <img width="893" height="943" alt="image" src="https://github.com/user-attachments/assets/08272863-e383-42e4-8d30-1f907552e927" />

Preuve visuelle de l’étape de configuration ou de vérification correspondante.
Capture 03 — Commutateur virtuel et état initial
 <img width="893" height="872" alt="image" src="https://github.com/user-attachments/assets/bf47c02d-736b-4838-96a7-61b83dab39e6" />

Preuve visuelle de l’étape de configuration ou de vérification correspondante.
3. Configuration de la passerelle NAT
Attribution de l’adresse 172.16.26.1/24 au commutateur interne et mise en place du NAT LABNAT.
Commandes PowerShell utilisées
New-NetIPAddress -IPAddress 172.16.26.1 -PrefixLength 24 -InterfaceAlias "vEthernet (LAB)"
New-NetNat -Name LABNAT -InternalIPInterfaceAddressPrefix 172.16.26.0/24
Get-NetNat
Get-NetIPAddress -InterfaceAlias "vEthernet (LAB)" -AddressFamily IPv4
Capture 04 — Passerelle, interface LAB et NAT
 <img width="893" height="865" alt="image" src="https://github.com/user-attachments/assets/2a0abd60-876f-4b7e-9660-82bb6fd919db" />

Preuve visuelle de l’étape de configuration ou de vérification correspondante.
Capture 05 — Passerelle, interface LAB et NAT
<img width="893" height="420" alt="image" src="https://github.com/user-attachments/assets/a8245b5b-17b9-4981-a06e-263cf96c088c" />

 
Preuve visuelle de l’étape de configuration ou de vérification correspondante.
Capture 06 — Passerelle, interface LAB et NAT
 <img width="893" height="872" alt="image" src="https://github.com/user-attachments/assets/89de2571-2718-4e09-95e7-bccf984ffb80" />

Preuve visuelle de l’étape de configuration ou de vérification correspondante.
4. Préparation du contrôleur de domaine
Utilisation de la VM SRV01 existante, raccordée au commutateur LAB, puis configuration du nom et de l’adresse IP du contrôleur.
Commandes PowerShell utilisées
Get-VM
Connect-VMNetworkAdapter -VMName SRV01 -SwitchName LAB
Get-VMNetworkAdapter -VMName SRV01
Enter-PSSession -VMName SRV01 -Credential (Get-Credential)
Get-NetAdapter
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 172.16.26.10 -PrefixLength 24 -DefaultGateway 172.16.26.1
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses 172.16.26.10
Rename-Computer -NewName "DC300156534"
Exit-PSSession
Restart-VM -Name SRV01
Capture 07 — Machine virtuelle et préparation du contrôleur
 <img width="893" height="776" alt="image" src="https://github.com/user-attachments/assets/9b1ffb66-0d02-4772-bee2-71f28fe9cfa4" />

Preuve visuelle de l’étape de configuration ou de vérification correspondante.
Capture 08 — Machine virtuelle et préparation du contrôleur
 <img width="893" height="251" alt="image" src="https://github.com/user-attachments/assets/0533044f-d2d5-4943-9251-4a906e7d9f28" />

Preuve visuelle de l’étape de configuration ou de vérification correspondante.
Capture 09 — Machine virtuelle et préparation du contrôleur
 <img width="893" height="731" alt="image" src="https://github.com/user-attachments/assets/b155c379-f4b2-4d4e-a20a-714d5aed2460" />

Preuve visuelle de l’étape de configuration ou de vérification correspondante.
Capture 10 — Machine virtuelle et préparation du contrôleur
 <img width="893" height="530" alt="image" src="https://github.com/user-attachments/assets/4cf0812b-bf57-4512-8512-a9f8e218f1f8" />

Preuve visuelle de l’étape de configuration ou de vérification correspondante.
5. Installation des services Active Directory
Installation du rôle AD DS sur la VM renommée DC300156534.
Commandes PowerShell utilisées
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
Get-WindowsFeature AD-Domain-Services
Capture 11 — Installation du rôle AD DS
 <img width="893" height="874" alt="image" src="https://github.com/user-attachments/assets/85fb549a-d8bd-4105-b63d-eefd2409fba9" />

Preuve visuelle de l’étape de configuration ou de vérification correspondante.
Capture 12 — Installation du rôle AD DS
 <img width="893" height="358" alt="image" src="https://github.com/user-attachments/assets/e99828f0-ec03-408b-a0a1-c0ca2ce53b4d" />

Preuve visuelle de l’étape de configuration ou de vérification correspondante.
6. Création de la forêt et du DNS
Création de la forêt personnelle. La première tentative a demandé explicitement un nom NetBIOS ; la commande a été corrigée.
Commandes PowerShell utilisées
Install-ADDSForest -DomainName "DC300156534.local" -DomainNetbiosName "AD300156534" -InstallDNS
Get-ADDomain
Get-Service NTDS,DNS
Capture 13 — Forêt Active Directory et DNS
 
Preuve visuelle de l’étape de configuration ou de vérification correspondante.
Capture 14 — Forêt Active Directory et DNS
 <img width="893" height="961" alt="image" src="https://github.com/user-attachments/assets/bef72221-b505-496e-90c8-04606ce77745" />

Preuve visuelle de l’étape de configuration ou de vérification correspondante.
Capture 15 — Forêt Active Directory et DNS
 <img width="893" height="948" alt="image" src="https://github.com/user-attachments/assets/7d51a7d7-3e41-4c5b-a46b-eb2311f91dc1" />

Preuve visuelle de l’étape de configuration ou de vérification correspondante.
7. Organisation Active Directory
Création de l’OU principale et des quatre sous-OU prévues par les consignes.
Commandes PowerShell utilisées
New-ADOrganizationalUnit -Name "OU300156534"
New-ADOrganizationalUnit -Name "Students" -Path "OU=OU300156534,DC=DC300156534,DC=local"
New-ADOrganizationalUnit -Name "Groups" -Path "OU=OU300156534,DC=DC300156534,DC=local"
New-ADOrganizationalUnit -Name "Workstations" -Path "OU=OU300156534,DC=DC300156534,DC=local"
New-ADOrganizationalUnit -Name "Servers" -Path "OU=OU300156534,DC=DC300156534,DC=local"
Get-ADOrganizationalUnit -Filter * | Select-Object Name,DistinguishedName
Capture 16 — Unités organisationnelles
 <img width="893" height="966" alt="image" src="https://github.com/user-attachments/assets/943f9e77-4a89-4cbb-b855-8d41c00f475c" />

Preuve visuelle de l’étape de configuration ou de vérification correspondante.
Capture 17 — Unités organisationnelles
 <img width="893" height="971" alt="image" src="https://github.com/user-attachments/assets/de95569c-f7d0-4b79-b143-b7c3e9e52f88" />

Preuve visuelle de l’étape de configuration ou de vérification correspondante.
8. Création et installation de CLIENT01
Création de CLIENT01 sur LAB, transfert de l’ISO Windows Server 2022, montage du DVD virtuel et installation en mode Desktop Experience.
Commandes PowerShell utilisées
New-VM -Name CLIENT01 -Generation 2 -MemoryStartupBytes 4GB -NewVHDPath "C:\VMs\CLIENT01.vhdx" -NewVHDSizeBytes 60GB -SwitchName LAB
Get-VMHardDiskDrive -VMName CLIENT01
Add-VMDvdDrive -VMName CLIENT01 -Path "C:\iso\en-us_windows_server_2022_updated_july_2023_x64_dvd_541692c3.iso"
$dvd = Get-VMDvdDrive -VMName CLIENT01
Set-VMFirmware -VMName CLIENT01 -FirstBootDevice $dvd
Set-VMFirmware -VMName CLIENT01 -EnableSecureBoot Off
Start-VM -Name CLIENT01
Capture 18 — Création de CLIENT01 et support Windows
 <img width="893" height="440" alt="image" src="https://github.com/user-attachments/assets/a3714e6b-b3f2-418f-a7e8-2c54510e5d25" />

Preuve visuelle de l’étape de configuration ou de vérification correspondante.
Capture 19 — Création de CLIENT01 et support Windows
 
Preuve visuelle de l’étape de configuration ou de vérification correspondante.
Capture 20 — Création de CLIENT01 et support Windows
 
Preuve visuelle de l’étape de configuration ou de vérification correspondante.
9. Configuration réseau et jonction au domaine
Configuration du client et vérification de la communication avec le DC avant la jonction au domaine.
Commandes PowerShell utilisées
Enter-PSSession -VMName CLIENT01 -Credential (Get-Credential)
Get-NetAdapter
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 172.16.26.20 -PrefixLength 24 -DefaultGateway 172.16.26.1
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses 172.16.26.10
ipconfig /all
ping 172.16.26.10
Resolve-DnsName DC300156534.local
Rename-Computer -NewName "CLIENT01"
Add-Computer -DomainName "DC300156534.local" -Credential "AD300156534\Administrator" -Restart
Get-CimInstance Win32_ComputerSystem | Select-Object Name,Domain,PartOfDomain
Capture 21 — Installation, réseau et jonction de CLIENT01
 <img width="893" height="952" alt="image" src="https://github.com/user-attachments/assets/560ecf39-1c7b-4aa6-af3f-13b7955c97cd" />

Preuve visuelle de l’étape de configuration ou de vérification correspondante.
Capture 22 — Installation, réseau et jonction de CLIENT01
 <img width="893" height="953" alt="image" src="https://github.com/user-attachments/assets/5ba215c4-f0d6-4c1b-8fca-ffc3b4de549b" />

Preuve visuelle de l’étape de configuration ou de vérification correspondante.
Capture 23 — Installation, réseau et jonction de CLIENT01
 <img width="893" height="911" alt="image" src="https://github.com/user-attachments/assets/56657533-b760-48e2-a431-2df837a1f344" />

Preuve visuelle de l’étape de configuration ou de vérification correspondante.
Capture 24 — Installation, réseau et jonction de CLIENT01
 <img width="893" height="626" alt="image" src="https://github.com/user-attachments/assets/83b7924d-371a-4c18-ba07-de022dda6cec" />

Preuve visuelle de l’étape de configuration ou de vérification correspondante.
Capture 25 — Installation, réseau et jonction de CLIENT01
 <img width="893" height="364" alt="image" src="https://github.com/user-attachments/assets/e4ce85de-3842-47e2-8324-679fa796c010" />



11. Résultats et conclusion
Les vérifications réseau ont donné 4 réponses sur 4 au ping du contrôleur de domaine, sans perte de paquets. La résolution DNS du domaine a retourné 172.16.26.10. La commande de contrôle du client a affiché PartOfDomain = True pour DC300156534.local. Le laboratoire d’architecture simplifiée est donc réalisé pour les exercices 2 à 9.

