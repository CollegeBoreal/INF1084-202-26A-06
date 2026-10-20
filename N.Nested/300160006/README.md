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

J'ai donc créé le dossier `C:\VMs` à la place. La commande a réussi. C'est là que seront stockés les disques virtuels de mes VM.

## 3. Création du réseau privé (exercice 2)

```powershell
New-VMSwitch -Name LAB -SwitchType Internal
```

J'ai créé un commutateur virtuel interne nommé **LAB**. Les VM pourront communiquer entre elles et avec SRV27, mais resteront isolées du réseau du collège. Cela évite tout conflit AD, DNS ou DHCP avec les autres étudiants.

```powershell
Get-VMSwitch
Get-NetAdapter
```

J'ai vérifié que le commutateur LAB existe (type Internal) et que la carte virtuelle `vEthernet (LAB)` a bien été créée, avec le nom exact dont j'avais besoin pour la commande suivante.

## 4. Configuration de la passerelle (exercice 3)

```powershell
New-NetIPAddress -IPAddress 172.16.27.1 -PrefixLength 24 -InterfaceAlias "vEthernet (LAB)"
```

J'ai attribué l'adresse **172.16.27.1/24** à la carte `vEthernet (LAB)`. Cette adresse sera la passerelle de mes VM. Au premier affichage, l'état était `Tentative` : Windows vérifiait simplement que l'adresse n'était pas déjà utilisée.

## 5. Création du NAT (exercice 3)

```powershell
New-NetNat -Name LABNAT -InternalIPInterfaceAddressPrefix 172.16.27.0/24
```

J'ai créé le NAT **LABNAT** pour le réseau 172.16.27.0/24. Il permettra à mes VM d'accéder à l'extérieur (Windows Update, internet) en utilisant l'adresse de SRV27, car les adresses 172.16.x.x ne sont pas routables sur le réseau du collège.

## 6. Vérification de la configuration

```powershell
Get-NetIPAddress -InterfaceAlias "vEthernet (LAB)"
Get-NetNat
```

J'ai confirmé que l'adresse 172.16.27.1/24 est maintenant à l'état `Preferred` et que LABNAT est actif (`Active : True`) sur 172.16.27.0/24.

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

J'ai demandé les détails du lecteur D:. C'est un DVD-ROM virtuel Microsoft d'étiquette `SSS_X64FREE_EN-US_DV9`. Il contient déjà un média d'installation de Windows, que j'utiliserai pour installer le système dans mes VM.

---

## Bilan

| Étape | Résultat |
|---|---|
| Hyper-V installé | Réussi |
| Dossier C:\VMs | Réussi (D: étant un DVD en lecture seule) |
| Commutateur LAB | Réussi |
| Passerelle 172.16.27.1 | Réussi |
| NAT LABNAT | Réussi |
| Média d'installation | Disponible sur D: |

## Conclusion

J'ai préparé l'infrastructure réseau de mon laboratoire : Hyper-V est prêt, un réseau privé isolé (172.16.27.0/24) existe avec sa passerelle et son NAT, et j'ai identifié la source d'installation de Windows. La prochaine étape sera de créer la VM du contrôleur de domaine **DC300160006**.
Média d’installation	Disponible sur D:
Conclusion

J’ai préparé l’infrastructure réseau de mon laboratoire : Hyper-V est prêt, un réseau privé isolé (172.16.27.0/24) existe avec sa passerelle et son NAT, et j’ai identifié la source d’installation de Windows. La prochaine étape sera de créer la VM du contrôleur de domaine DC300160006.
