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

## 1. Vérification de Hyper-V

```powershell
Get-WindowsFeature Hyper-V
```
J'ai vérifié que le rôle Hyper-V était installé sur mon serveur. Le résultat affiche `[X] Hyper-V Installed`. Sans ce rôle, je ne pourrais pas créer de machines virtuelles.

```powershell
Get-VMHost
```
J'ai consulté les ressources de mon serveur SRV300160006 : 4 processeurs logiques et environ 14 Go de RAM. C'est suffisant pour faire tourner deux VM de 4 Go (le contrôleur de domaine et le client).

## 2. Choix de l'emplacement des machines virtuelles

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

## 3. Création du réseau privé (exercice 2)

```powershell
New-VMSwitch -Name LAB -SwitchType Internal
```
J'ai créé un commutateur virtuel interne nommé **LAB**. Les VM peuvent communiquer entre elles et avec SRV27, mais restent isolées du réseau du collège. Cela évite tout conflit AD, DNS ou DHCP avec les autres étudiants.

```powershell
Get-VMSwitch
Get-NetAdapter
```
J'ai vérifié que le commutateur LAB existe (type Internal) et que la carte virtuelle `vEthernet (LAB)` a bien été créée, avec le nom exact dont j'avais besoin pour la commande suivante.

## 4. Configuration de la passerelle (exercice 3)

```powershell
New-NetIPAddress -IPAddress 172.16.27.1 -PrefixLength 24 -InterfaceAlias "vEthernet (LAB)"
```
J'ai attribué l'adresse **172.16.27.1/24** à la carte `vEthernet (LAB)`. Cette adresse est la passerelle de mes VM. Au premier affichage, l'état était `Tentative` : Windows vérifiait que l'adresse n'était pas déjà utilisée.

## 5. Création du NAT (exercice 3)

```powershell
New-NetNat -Name LABNAT -InternalIPInterfaceAddressPrefix 172.16.27.0/24
```
J'ai créé le NAT **LABNAT** pour le réseau 172.16.27.0/24. Il permet à mes VM d'accéder à l'extérieur en utilisant l'adresse de SRV27, car les adresses 172.16.x.x ne sont pas routables sur le réseau du collège.

## 6. Vérification de la configuration

```powershell
Get-NetIPAddress -InterfaceAlias "vEthernet (LAB)"
Get-NetNat
```
J'ai confirmé que l'adresse 172.16.27.1/24 est à l'état `Preferred` et que LABNAT est actif (`Active : True`) sur 172.16.27.0/24.

## 7. Recherche du média d'installation de Windows

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

## 8. Création de la VM du contrôleur de domaine (exercice 4)

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

## 9. Préparation du média d'installation

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

## 10. Démarrage de la VM et installation de Windows

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

## 11. Configuration du réseau de la VM avec PowerShell Direct

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

## 12. Tests de connectivité depuis la VM

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
