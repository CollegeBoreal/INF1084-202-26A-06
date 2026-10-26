# INF1084 : Architecture Active Directory avec Hyper-V

**Numéro étudiant** : 300160006

**Cours** : INF1084, Administration Windows

**Environnement** : Windows Server 2022, Hyper-V, PowerShell, Active Directory Domain Services

## Plan d'adressage

| Élément | Configuration |
|---|---|
| Serveur parent | SRV300160006 (SRV27) |
| IP du serveur parent | 10.7.237.228 |
| Commutateur virtuel | LAB |
| Réseau privé | 172.16.27.0/24 |
| Passerelle NAT | 172.16.27.1 |
| Contrôleur de domaine | DC300160006 (172.16.27.10) |
| Domaine AD DS | DC300160006.local |
| Client | CLIENT01 (172.16.27.20) |

---

##  Vérification de Hyper-V

```powershell
Get-WindowsFeature Hyper-V
```
J'ai vérifié que le rôle Hyper-V était installé sur mon serveur. Le résultat affiche `[X] Hyper-V Installed`. Sans ce rôle, je ne pourrais pas créer de machines virtuelles.

```powershell
Get-VMHost
```
J'ai consulté les ressources de mon serveur SRV300160006 : 4 processeurs logiques et environ 14 Go de RAM. C'est suffisant pour faire tourner deux VM de 4 Go (le contrôleur de domaine et le client).
![images alt](https://github.com/CollegeBoreal/INF1084-202-26A-06/blob/03b90247d0b9845bb2044a0925553339678d2bc1/N.Nested/300160006/images/Screenshot%202026-10-20%20221945.png)

##  Choix de l'emplacement des machines virtuelles

```powershell
Get-Volume
```
J'ai listé les volumes du serveur. Le lecteur C: fait environ 170 Go avec 103 Go libres, et le lecteur D: est un lecteur DVD de 5 Go.

```powershell
New-Item -ItemType Directory -Path D:\VMs
New-Item -ItemType Directory -Path D:\VMs -Force
```
J'ai essayé de créer le dossier des VM sur D:. Les deux tentatives ont échoué avec l'erreur `Access denied`, car D: est un DVD en lecture seule.

```powershell
Get-ChildItem D:\
```
J'ai regardé le contenu de D: pour comprendre. J'y ai trouvé les dossiers `boot`, `efi`, `sources` et le fichier `setup.exe`, ce qui montre que c'est un disque d'installation de Windows.

```powershell
New-Item -ItemType Directory -Path C:\VMs -Force
```
J'ai donc créé le dossier `C:\VMs` à la place. La commande a réussi. C'est là que sont stockés les disques virtuels de mes VM.
![images alt](https://github.com/CollegeBoreal/INF1084-202-26A-06/blob/65a1c5c41e4d50bd9d73b995f9e4e73bcdc7af67/N.Nested/300160006/images/Screenshot%202026-10-20%20222005.png)

##  Création du réseau privé 

```powershell
New-VMSwitch -Name LAB -SwitchType Internal
```
J'ai créé un commutateur virtuel interne nommé **LAB**. Les VM peuvent communiquer entre elles et avec SRV27, mais restent isolées du réseau du collège. Cela évite tout conflit AD, DNS ou DHCP avec les autres étudiants.

```powershell
Get-VMSwitch
Get-NetAdapter
```
J'ai vérifié que le commutateur LAB existe (type Internal) et que la carte virtuelle `vEthernet (LAB)` a bien été créée, avec le nom exact dont j'avais besoin pour la commande suivante.
![images alt](https://github.com/CollegeBoreal/INF1084-202-26A-06/blob/ecda88d1628cf6a6525ba15275a6079da6dfe4e4/N.Nested/300160006/images/Screenshot%202026-10-20%20222024.png)

##  Configuration de la passerelle 

```powershell
New-NetIPAddress -IPAddress 172.16.27.1 -PrefixLength 24 -InterfaceAlias "vEthernet (LAB)"
```
J'ai attribué l'adresse **172.16.27.1/24** à la carte `vEthernet (LAB)`. Cette adresse est la passerelle de mes VM. Au premier affichage, l'état était `Tentative` : Windows vérifiait que l'adresse n'était pas déjà utilisée.

## Création du NAT 

```powershell
New-NetNat -Name LABNAT -InternalIPInterfaceAddressPrefix 172.16.27.0/24
```
J'ai créé le NAT **LABNAT** pour le réseau 172.16.27.0/24. Il permet à mes VM d'accéder à l'extérieur en utilisant l'adresse de SRV27, car les adresses 172.16.x.x ne sont pas routables sur le réseau du collège.

##  Vérification de la configuration

```powershell
Get-NetIPAddress -InterfaceAlias "vEthernet (LAB)"
Get-NetNat
```
J'ai confirmé que l'adresse 172.16.27.1/24 est à l'état `Preferred` et que LABNAT est actif (`Active : True`) sur 172.16.27.0/24.

## Recherche du média d'installation de Windows

```powershell
Get-ChildItem C:\ -Recurse -Filter *.iso -ErrorAction SilentlyContinue | Select-Object FullName
Get-DiskImage -DevicePath '\\.\CDROM0' -ErrorAction SilentlyContinue
```
J'ai cherché un fichier ISO sur C: et vérifié si le lecteur D: était une image montée. Je n'ai rien trouvé.

```powershell
Get-Volume -DriveLetter D | Format-List *
Get-CimInstance Win32_CDROMDrive | Select-Object Drive, VolumeName, Caption
```
Le lecteur D: est un DVD-ROM virtuel Microsoft d'étiquette `SSS_X64FREE_EN-US_DV9`. Il contient un média d'installation de Windows.

---

##  Création de la VM du contrôleur de domaine 

```powershell
New-VM -Name DC300160006 -Generation 2 -MemoryStartupBytes 4GB `
    -NewVHDPath "C:\VMs\DC300160006.vhdx" -NewVHDSizeBytes 60GB -SwitchName LAB
Set-VMProcessor -VMName DC300160006 -Count 2
```
J'ai créé la VM **DC300160006** : génération 2, 4 Go de RAM, disque de 60 Go dans `C:\VMs`, branchée sur le commutateur LAB, avec 2 processeurs.

```powershell
Get-VM DC300160006 | Select-Object Name, State, Generation, ProcessorCount, MemoryStartup
Get-VMNetworkAdapter -VMName DC300160006 | Select-Object Name, SwitchName
Get-VMHardDiskDrive -VMName DC300160006 | Select-Object Path
```
J'ai vérifié la configuration : génération 2, 2 processeurs, 4 Go de RAM, switch `LAB` et disque `C:\VMs\DC300160006.vhdx`.

##  Préparation du média d'installation

Mon serveur SRV27 est lui-même une machine virtuelle, et son lecteur D: est un DVD virtuel. Hyper-V ne propose donc pas l'option « Physical CD/DVD drive » : seule l'option « Image file » est disponible. J'ai créé un fichier ISO à partir du lecteur D: :

```powershell
New-Item -ItemType Directory -Path C:\ISO -Force

$src = New-Object System.IO.FileStream('\\.\D:', 'Open', 'Read', 'ReadWrite')
$dst = [System.IO.File]::Create('C:\ISO\WS2022.iso')
$src.CopyTo($dst, 1MB)
$dst.Close()
$src.Close()

Get-Item C:\ISO\WS2022.iso | Select-Object Name, @{n='Go';e={[math]::Round($_.Length/1GB,2)}}
```
Le fichier `C:\ISO\WS2022.iso` fait 5,17 Go, la même taille que le lecteur D:, donc la copie est complète.

##  Démarrage de la VM et installation de Windows

```powershell
Add-VMDvdDrive -VMName DC300160006 -Path "C:\ISO\WS2022.iso"
$dvd = Get-VMDvdDrive -VMName DC300160006
Set-VMFirmware -VMName DC300160006 -FirstBootDevice $dvd
(Get-VMFirmware -VMName DC300160006).BootOrder | Select-Object BootType, Device
```
J'ai attaché l'ISO à la VM et mis le DVD en premier dans l'ordre de démarrage. Au départ, `Get-VMDvdDrive` ne renvoyait rien : la VM n'avait aucun lecteur DVD, il a donc fallu utiliser `Add-VMDvdDrive`.

```powershell
Start-VM DC300160006
vmconnect.exe localhost DC300160006
```
Au premier essai, le message « Press any key to boot from CD or DVD » est passé sans que ma touche soit prise en compte, et la VM a affiché « No operating system was loaded ». Après **Action, Reset** et un appui immédiat sur une touche, Windows Setup s'est lancé.

J'ai installé **Windows Server 2022 Standard Evaluation (Desktop Experience)** avec l'option *Custom: Install Microsoft Server Operating System only*, sur le disque de 60 Go. Pendant les redémarrages, je n'ai appuyé sur aucune touche.

```powershell
Get-VMIntegrationService -VMName DC300160006 -Name Heartbeat | Select-Object Name, PrimaryStatusDescription
Get-Item C:\VMs\DC300160006.vhdx | Select-Object @{n='Go';e={[math]::Round($_.Length/1GB,2)}}
```
Le heartbeat affiche `OK` et le disque virtuel est passé à environ 10,5 Go : Windows est installé et démarré.
![images alt](https://github.com/CollegeBoreal/INF1084-202-26A-06/blob/016a678f1dd74a0376f1db06845a27dcdefc03ed/N.Nested/300160006/images/Screenshot%202026-10-20%20213427.png)

##  Configuration du réseau de la VM avec PowerShell Direct

Le copier-coller ne fonctionnant pas dans la fenêtre de la VM, j'ai utilisé PowerShell Direct depuis SRV27 :

```powershell
$cred = Get-Credential -UserName ".\Administrator" -Message "Compte de la VM"
Enter-PSSession -VMName DC300160006 -Credential $cred
```

```powershell
hostname
Get-NetAdapter
Get-NetIPAddress -AddressFamily IPv4 | Select-Object InterfaceAlias, IPAddress, PrefixLength
Get-NetRoute -DestinationPrefix 0.0.0.0/0
```
Le nom de la VM est `DC300160006` et son IP est `172.16.27.10/24`. La commande `New-NetIPAddress` a répondu « already exists », car l'adresse était déjà en place. En revanche, la route par défaut avait pour passerelle `0.0.0.0` au lieu de `172.16.27.1`, ce que j'ai corrigé :

```powershell
Remove-NetRoute -DestinationPrefix 0.0.0.0/0 -InterfaceAlias "Ethernet" -Confirm:$false
New-NetRoute -DestinationPrefix 0.0.0.0/0 -InterfaceAlias "Ethernet" -NextHop 172.16.27.1
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses 172.16.27.10
```

##  Tests de connectivité depuis la VM

```powershell
Get-DnsClientServerAddress -InterfaceAlias "Ethernet" -AddressFamily IPv4
Test-Connection 172.16.27.1 -Count 2
Test-NetConnection 8.8.8.8 -Port 53
```
- Le DNS de la VM est `172.16.27.10`.
- Le ping vers la passerelle `172.16.27.1` répond en 0 et 1 ms.
- `Test-NetConnection 8.8.8.8 -Port 53` renvoie `TcpTestSucceeded : True` avec `SourceAddress : 172.16.27.10`, ce qui confirme que mon NAT **LABNAT** fonctionne.

---
![images alt](https://github.com/CollegeBoreal/INF1084-202-26A-06/blob/6a44038fcc882cee4243162412c08cc2fd89c22b/N.Nested/300160006/images/Screenshot%202026-10-20%20222115.png)

| Étape | Résultat |
|---|---|
| Hyper-V installé | Réussi |
| Dossier C:\VMs | Réussi (D: étant un DVD en lecture seule) |
| Commutateur LAB | Réussi |
| Passerelle 172.16.27.1 | Réussi |
| NAT LABNAT | Réussi |
| ISO créé depuis D: (5,17 Go) | Réussi |
| VM DC300160006 créée | Réussi |
| Windows Server 2022 installé | Réussi |
| IP 172.16.27.10, passerelle et DNS | Réussi |
| Ping de la passerelle et sortie par le NAT | Réussi |
| Installation d'AD DS | À faire |
| Forêt DC300160006.local | À faire |
| OU OU300160006 et sous-OU | À faire |
| CLIENT01 et jonction au domaine | À faire |

![images alt](https://github.com/CollegeBoreal/INF1084-202-26A-06/blob/43eea708bd6954587da3f9c8297e8e88c304a320/N.Nested/300160006/images/Screenshot%202026-10-24%20194452.png)

J'ai préparé l'infrastructure réseau de mon laboratoire (commutateur LAB, passerelle, NAT) puis créé la machine virtuelle **DC300160006** sous Windows Server 2022. Elle est configurée avec l'adresse 172.16.27.10, joint la passerelle et sort vers l'extérieur grâce au NAT. La prochaine étape consiste à installer le rôle AD DS et à créer la forêt **DC300160006.local**.

## Réinitialisation du mot de passe Administrator

J'avais oublié le mot de passe Administrator de la VM. Comme j'étais encore connecté à la VM, je l'ai simplement réinitialisé depuis PowerShell au lieu de recréer la machine :

```powershell
Set-LocalUser -Name "Administrator" -Password (Read-Host "Nouveau mot de passe" -AsSecureString)
```

J'ai ensuite testé le nouveau mot de passe depuis SRV27 avec PowerShell Direct :

```powershell
$cred = Get-Credential -UserName ".\Administrator" -Message "Compte de la VM"
Enter-PSSession -VMName DC300160006 -Credential $cred
```

La session s'est ouverte (le prompt est devenu `[DC300160006]: PS ...`), ce qui confirme que le mot de passe fonctionne. J'ai aussi vérifié la configuration réseau de la VM :

```powershell
hostname
Get-NetIPAddress -InterfaceAlias "Ethernet" -AddressFamily IPv4 | Select-Object IPAddress, PrefixLength
Get-NetRoute -DestinationPrefix 0.0.0.0/0
```

Résultat : nom `DC300160006`, IP `172.16.27.10/24`, et route par défaut vers `172.16.27.1`.

##  Installation du rôle Active Directory 

```powershell
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
Get-WindowsFeature AD-Domain-Services
```

J'ai installé le rôle **AD DS** avec ses outils de gestion dans la VM. La vérification affiche `[X] Active Directory Domain Services` à l'état `Installed`.

## Création de la forêt 

Ma première tentative de promotion a échoué :

```powershell
Install-ADDSForest `
    -DomainName "DC300160006.local" `
    -DomainNetbiosName "DC300160006" `
    -InstallDns:$true `
    -SafeModeAdministratorPassword (Read-Host "Mot de passe DSRM" -AsSecureString) `
    -Force
```

Erreur : `Verification of prerequisites for Domain Controller promotion failed. The NetBIOS name DC300160006 is already in use.`

La cause est que ma VM s'appelle déjà `DC300160006`. Le nom NetBIOS du domaine ne peut pas être identique à celui de la machine. Je l'ai confirmé avec :

```powershell
hostname
nbtstat -n
```

Le nom `DC300160006 <20> UNIQUE Registered` est déjà enregistré par la machine. L'erreur étant détectée avant toute modification, il n'y avait rien à nettoyer. J'ai relancé la commande avec un nom NetBIOS différent :

```powershell
Install-ADDSForest `
    -DomainName "DC300160006.local" `
    -DomainNetbiosName "AD300160006" `
    -InstallDns:$true `
    -SafeModeAdministratorPassword (Read-Host "Mot de passe DSRM" -AsSecureString) `
    -Force
```

- `-DomainName` : nom DNS du domaine.
- `-DomainNetbiosName` : nom court du domaine (maximum 15 caractères). J'ai utilisé `AD300160006`.
- `-InstallDns:$true` : installe le DNS en même temps.
- `-SafeModeAdministratorPassword` : mot de passe du mode de restauration DSRM, saisi sans l'afficher.
- `-Force` : évite les confirmations.

La commande s'est terminée avec `Operation completed successfully` et `Status : Success`. Les avertissements sur la cryptographie NT 4.0 et sur la délégation DNS sont normaux pour une forêt isolée : il n'y a pas de zone parente à laquelle déléguer. La VM a ensuite redémarré automatiquement, ce qui a coupé ma session PowerShell Direct.

##  Vérification du domaine

Après le redémarrage, je me suis reconnecté avec le compte du domaine, car le compte local a été remplacé par celui du domaine :

```powershell
$cred = Get-Credential -UserName "Administrator@DC300160006.local" -Message "Compte du domaine"
Enter-PSSession -VMName DC300160006 -Credential $cred
```

```powershell
whoami
Get-ADForest
Get-ADDomain | Select-Object Name, NetBIOSName, DNSRoot, DomainMode, PDCEmulator
Get-Service NTDS, ADWS, DNS, KDC, Netlogon | Select-Object Name, Status
```

| Vérification | Résultat |
|---|---|
| `whoami` | `ad300160006\administrator` |
| Forêt | `DC300160006.local` (mode `Windows2016Forest`) |
| Domaine | `DC300160006.local`, NetBIOS `AD300160006` (mode `Windows2016Domain`) |
| Catalogue global | `DC300160006.DC300160006.local` |
| Rôles FSMO | Tous détenus par mon DC (un seul contrôleur) |
| Services NTDS, ADWS, DNS, KDC, Netlogon | Tous à l'état `Running` |

---

## Bilan

| Étape | Résultat |
|---|---|
| Hyper-V installé | Réussi |
| Dossier C:\VMs | Réussi (D: étant un DVD en lecture seule) |
| Commutateur LAB | Réussi |
| Passerelle 172.16.27.1 | Réussi |
| NAT LABNAT | Réussi |
| ISO créé depuis D: (5,17 Go) | Réussi |
| VM DC300160006 créée | Réussi |
| Windows Server 2022 installé | Réussi |
| IP 172.16.27.10, passerelle et DNS | Réussi |
| Ping de la passerelle et sortie par le NAT | Réussi |
| Mot de passe Administrator réinitialisé | Réussi |
| Installation d'AD DS | Réussi |
| Forêt DC300160006.local (NetBIOS AD300160006) | Réussi |
| Services AD (NTDS, ADWS, DNS, KDC, Netlogon) | Réussi |
| OU OU300160006 et sous-OU | À faire |
| Utilisateurs, groupes, AGDLP et AGUDLP | À faire |
| Partage et permissions NTFS | À faire |
| CLIENT01 et jonction au domaine | À faire |

![images alt](https://github.com/CollegeBoreal/INF1084-202-26A-06/blob/ecf29722ef9fd2b05d89701cf9a3532cbca4ea05/N.Nested/300160006/images/Screenshot%202026-10-25%20201018.png)

J'ai préparé l'infrastructure réseau de mon laboratoire (commutateur LAB, passerelle, NAT), créé la machine virtuelle **DC300160006** sous Windows Server 2022, puis installé le rôle AD DS et créé la forêt **DC300160006.local**. Un conflit de nom NetBIOS entre la machine et le domaine m'a obligé à utiliser `AD300160006` comme nom NetBIOS du domaine. Les cinq services AD fonctionnent. La prochaine étape consiste à créer les unités d'organisation, les utilisateurs et les groupes, puis à créer CLIENT01 et à le joindre au domaine.

##  Création des unités d'organisation 

J'ai ouvert une session PowerShell Direct dans la VM avec le compte du domaine, puis créé l'OU racine de mon environnement :

```powershell
New-ADOrganizationalUnit -Name "OU300160006"
```

J'ai ensuite créé les 5 sous-OU avec une boucle, ce qui évite de répéter la commande cinq fois :

```powershell
"Students","Servers","Groups","Workstations","ServiceAccounts" | ForEach-Object {
    New-ADOrganizationalUnit -Name $_ -Path "OU=OU300160006,DC=DC300160006,DC=local"
}
```

Le paramètre `-Path` indique l'OU parente : chaque sous-OU est créée à l'intérieur de `OU300160006`.

J'ai vérifié la structure :

```powershell
Get-ADOrganizationalUnit -Filter * | Select-Object Name, DistinguishedName
```

La sortie affiche 7 lignes : l'OU `Domain Controllers` (créée par défaut), `OU300160006` et ses 5 sous-OU. Voici la hiérarchie obtenue :

```
DC300160006.local
|
+-- OU300160006
    |
    +-- Students
    +-- Servers
    +-- Groups
    +-- Workstations
    +-- ServiceAccounts
```
![images alt](https://github.com/CollegeBoreal/INF1084-202-26A-06/blob/2761c6e45f9a96715a7afd4c78cfd96f2740f6a4/N.Nested/300160006/images/Screenshot%202026-10-25%20204024.png)

## . Création des utilisateurs 

Pour ne pas écrire de mot de passe en clair dans mes commandes, je l'ai saisi une seule fois sous forme sécurisée :

```powershell
$motDePasse = Read-Host "Mot de passe des utilisateurs" -AsSecureString
```

J'ai d'abord créé l'utilisateur `alice.martin` dans l'OU Students. Elle me servira d'exemple pour les groupes (AGDLP et AGUDLP) :

```powershell
New-ADUser `
    -Name "Alice Martin" `
    -GivenName "Alice" `
    -Surname "Martin" `
    -SamAccountName "alice.martin" `
    -UserPrincipalName "alice.martin@DC300160006.local" `
    -Path "OU=Students,OU=OU300160006,DC=DC300160006,DC=local" `
    -AccountPassword $motDePasse `
    -Enabled $true
```

Puis j'ai créé 10 comptes (`student1` à `student10`) avec une boucle :

```powershell
1..10 | ForEach-Object {
    New-ADUser `
        -Name "Student$_" `
        -SamAccountName "student$_" `
        -UserPrincipalName "student$_@DC300160006.local" `
        -Path "OU=Students,OU=OU300160006,DC=DC300160006,DC=local" `
        -AccountPassword $motDePasse `
        -Enabled $true
}
```

- `-SamAccountName` : nom de connexion du compte.
- `-UserPrincipalName` : permet la connexion sous la forme `nom@DC300160006.local`.
- `-AccountPassword` : mot de passe fourni sous forme sécurisée.
- `-Enabled $true` : le compte est actif dès sa création.

J'ai vérifié les comptes :

```powershell
Get-ADUser -Filter * -SearchBase "OU=Students,OU=OU300160006,DC=DC300160006,DC=local" |
    Select-Object Name, SamAccountName, Enabled | Sort-Object SamAccountName

(Get-ADUser -Filter * -SearchBase "OU=Students,OU=OU300160006,DC=DC300160006,DC=local").Count
```

La liste affiche `alice.martin` et `student1` à `student10`, tous avec `Enabled = True`, et le compte est de **11 utilisateurs**.
![images alt](https://github.com/CollegeBoreal/INF1084-202-26A-06/blob/6c0ebaf64c179bad90e367e3be56eb35e3dc9ff6/N.Nested/300160006/images/Screenshot%202026-10-25%20204039.png)

#  groupes
$groups = "OU=Groups,OU=OU300160006,DC=DC300160006,DC=local"
New-ADGroup -Name GG_Developers -GroupScope Global -GroupCategory Security -Path $groups
New-ADGroup -Name UG_ContentEditors -GroupScope Universal -GroupCategory Security -Path $groups
New-ADGroup -Name DL_ProjectFolder_Modify -GroupScope DomainLocal -GroupCategory Security -Path $groups
New-ADGroup -Name DL_ProjectFolder_Read -GroupScope DomainLocal -GroupCategory Security -Path $groups

#  AGDLP
Add-ADGroupMember -Identity GG_Developers -Members alice.martin
Add-ADGroupMember -Identity DL_ProjectFolder_Modify -Members GG_Developers

# AGUDLP
Add-ADGroupMember -Identity UG_ContentEditors -Members GG_Developers
Add-ADGroupMember -Identity DL_ProjectFolder_Modify -Members UG_ContentEditors

#  dossier et partage
New-Item -Path C:\ProjectFolder -ItemType Directory
New-SmbShare -Name ProjectFolder -Path C:\ProjectFolder -FullAccess Administrators

# permissions NTFS
$acl = Get-Acl C:\ProjectFolder
$read = New-Object System.Security.AccessControl.FileSystemAccessRule("DL_ProjectFolder_Read","ReadAndExecute","ContainerInherit,ObjectInherit","None","Allow")
$modify = New-Object System.Security.AccessControl.FileSystemAccessRule("DL_ProjectFolder_Modify","Modify","ContainerInherit,ObjectInherit","None","Allow")
$acl.AddAccessRule($read)
$acl.AddAccessRule($modify)
Set-Acl C:\ProjectFolder $acl

![images alt](https://github.com/CollegeBoreal/INF1084-202-26A-06/blob/41b1458f6e661f79af7dbebcead33cd34747a638/N.Nested/300160006/images/Screenshot%202026-10-25%20204905.png)
![images alt](https://github.com/CollegeBoreal/INF1084-202-26A-06/blob/cd76f9920fc6ce3d52ca31b14f640596499681fc/N.Nested/300160006/images/Screenshot%202026-10-25%20204920.png)

##  Création de CLIENT01 

```powershell
New-VM -Name CLIENT01 -Generation 2 -MemoryStartupBytes 4GB `
    -NewVHDPath "C:\VMs\CLIENT01.vhdx" -NewVHDSizeBytes 60GB -SwitchName LAB
Set-VMProcessor -VMName CLIENT01 -Count 2
Add-VMDvdDrive -VMName CLIENT01 -Path "C:\ISO\WS2022.iso"
$dvd = Get-VMDvdDrive -VMName CLIENT01
Set-VMFirmware -VMName CLIENT01 -FirstBootDevice $dvd
Start-VM CLIENT01
```

J'ai créé la VM **CLIENT01** (génération 2, 4 Go de RAM, disque de 60 Go, commutateur LAB) et installé Windows Server 2022 Standard Evaluation (Desktop Experience) à partir du même ISO que pour le DC. J'ai ensuite retiré l'ISO et ouvert une session PowerShell Direct, puis renommé la machine :

```powershell
Set-VMDvdDrive -VMName CLIENT01 -Path $null
Enter-PSSession -VMName CLIENT01 -Credential $credClient
Rename-Computer -NewName CLIENT01 -Restart
```

Après le redémarrage, j'ai configuré le réseau :

```powershell
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 172.16.27.20 -PrefixLength 24 -DefaultGateway 172.16.27.1
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses 172.16.27.10
```

Une erreur de ma part : après le redémarrage, ma session était coupée et ces commandes se sont exécutées sur SRV27 au lieu de CLIENT01. Je l'ai remarqué grâce au nom de machine `SRV300160006` dans la sortie, puis j'ai remis la carte de SRV27 dans son état d'origine (adresse `10.7.237.228`, route par défaut `10.7.237.1`, DNS `127.0.0.1`). J'ai ensuite relancé les commandes dans la session `[CLIENT01]`.

J'ai vérifié le réseau du client avant la jonction :

```powershell
Test-Connection 172.16.27.10 -Count 2
Resolve-DnsName DC300160006.local
Get-NetRoute -DestinationPrefix 0.0.0.0/0 | Select-Object InterfaceAlias, NextHop
```

- Le ping vers le DC répond en 0 et 1 ms.
- `Resolve-DnsName` renvoie uniquement `172.16.27.10`.
- La route par défaut pointe vers `172.16.27.1`.

Le DNS du client ne doit résoudre que mon DC, car mon serveur SRV27 est lui-même contrôleur d'un domaine du même nom (`DC300160006.local`, `DomainRole = 5`).

##  Intégration de CLIENT01 au domaine

```powershell
Add-Computer -DomainName DC300160006.local -Credential Administrator@DC300160006.local -Restart
```

J'ai utilisé `Administrator@DC300160006.local` plutôt que `DC300160006\Administrator`, car le nom NetBIOS de mon domaine est `AD300160006`. Après le redémarrage, je me suis reconnecté avec le compte du domaine et j'ai vérifié :

```powershell
Get-CimInstance Win32_ComputerSystem | Select-Object Name, Domain, PartOfDomain
whoami
nltest /dsgetdc:DC300160006.local
```

| Vérification | Résultat |
|---|---|
| Nom de la machine | `CLIENT01` |
| Domaine | `DC300160006.local` |
| `PartOfDomain` | `True` |
| `whoami` | `ad300160006\administrator` |
| Contrôleur de domaine | `\\DC300160006.DC300160006.local` (172.16.27.10) |

Le `whoami` en `ad300160006\...` confirme que CLIENT01 appartient au domaine de mon DC imbriqué et non à celui de SRV27.

---

## Bilan final

| Étape | Résultat |
|---|---|
| Hyper-V, C:\VMs, commutateur LAB | Réussi |
| Passerelle 172.16.27.1 et NAT LABNAT | Réussi |
| VM DC300160006 et Windows Server 2022 | Réussi |
| Réseau du DC (172.16.27.10) et test du NAT | Réussi |
| Installation d'AD DS | Réussi |
| Forêt DC300160006.local (NetBIOS AD300160006) | Réussi |
| OU OU300160006 et 5 sous-OU | Réussi |
| Utilisateurs (alice.martin, student1 à student10) | Réussi |
| Groupes, AGDLP et AGUDLP | Réussi |
| Dossier partagé ProjectFolder et permissions NTFS | Réussi |
| VM CLIENT01 (172.16.27.20) | Réussi |
| CLIENT01 membre du domaine | Réussi |

## Conclusion

J'ai construit un environnement Active Directory isolé dans Hyper-V : un réseau privé 172.16.27.0/24 avec NAT, un contrôleur de domaine Windows Server 2022 pour la forêt `DC300160006.local`, une structure d'OU, des utilisateurs, des groupes (AGDLP et AGUDLP), un dossier partagé avec permissions NTFS et un client CLIENT01 joint au domaine. Deux écarts par rapport au devoir : les VM sont stockées dans `C:\VMs` (D: est un DVD en lecture seule) et le nom NetBIOS du domaine est `AD300160006`, car mon serveur SRV27 est déjà contrôleur du domaine `DC300160006.local` avec le NetBIOS `DC300160006`. La vérification finale (`PartOfDomain = True`) confirme que l'architecture fonctionne.
