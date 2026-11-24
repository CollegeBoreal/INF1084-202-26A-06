# 300159672

## INF1084 – Architecture simplifiée (1 étudiant = 1 forêt = 1 sous-réseau)

| | |
|---|---|
| **Étudiant** | Amadou – 300159672 |
| **Établissement** | Collège Boréal |
| **Cours** | INF1084 |
| **Laboratoire** | `6.Nested` |
| **Environnement** | Windows Server 2022, Hyper-V, PowerShell, Active Directory Domain Services |
| **Serveur parent** | SRV300159672 (10.7.237.225) = SRV24 |
| **Domaine** | `DC300159672.local` (NetBIOS : `AD300159672`) |

**Résumé :** sur mon serveur Windows Server 2022, j'ai créé mon propre réseau privé avec Hyper-V. J'y ai installé deux machines virtuelles imbriquées : un contrôleur de domaine (`DC300159672`) qui héberge ma propre forêt Active Directory, et un poste client (`CLIENT01`) que j'ai joint au domaine. Mon réseau est isolé de celui des autres étudiants, ce qui évite tout conflit AD DS, DNS ou DHCP.

---

## Plan d'adressage

Mon serveur est le **SRV24** (n = 24, car SRV01 = 10.7.237.202 … SRV24 = 10.7.237.225). Mon sous-réseau privé est donc `172.16.24.0/24`.

| Élément | Configuration |
|---|---|
| Serveur parent | SRV300159672 – 10.7.237.225 |
| Commutateur virtuel | LAB |
| Réseau privé | 172.16.24.0/24 |
| Passerelle NAT | 172.16.24.1 |
| Contrôleur de domaine | DC300159672 (172.16.24.10) |
| Domaine AD DS | DC300159672.local |
| Client | CLIENT01 (172.16.24.20) |

---

## Exercices 2 et 3 – Réseau privé, passerelle et NAT (sur le serveur)

```powershell
New-VMSwitch -Name LAB -SwitchType Internal
```

J'ai créé un commutateur virtuel interne nommé **LAB**. Mes VM peuvent communiquer entre elles et avec le serveur, mais restent isolées du réseau du collège.

```powershell
New-NetIPAddress -IPAddress 172.16.24.1 -PrefixLength 24 -InterfaceAlias "vEthernet (LAB)"
New-NetNat -Name LABNAT -InternalIPInterfaceAddressPrefix 172.16.24.0/24
```

J'ai donné l'adresse **172.16.24.1/24** à la carte `vEthernet (LAB)` : c'est la passerelle de mes VM. Puis j'ai créé le NAT **LABNAT**, qui permet aux VM d'accéder à l'extérieur en utilisant l'adresse du serveur (les adresses 172.16.x.x ne sont pas routables sur le réseau du collège).

**Capture 1/5 – Réseau :** le commutateur `LAB`, l'adresse 172.16.24.1 et le NAT `LABNAT`.

<img width="1512" height="982" alt="Capture d’écran 2026-11-17 à 12 19 13" src="https://github.com/user-attachments/assets/cc19e56c-b172-47a8-bdb6-d1aea01ff355" />


---

## Exercice 4 – Créer le contrôleur de domaine

### Création de la VM

```powershell
New-VM -Name DC300159672 -Generation 2 -MemoryStartupBytes 4GB -NewVHDPath "C:\VMs\DC300159672.vhdx" -NewVHDSizeBytes 60GB -SwitchName LAB
```

J'ai créé la VM **DC300159672** : génération 2, 4 Go de RAM, disque de 60 Go, branchée sur le commutateur LAB.

**Capture 2/5 – VM du contrôleur de domaine :** la VM `DC300159672` créée.

<img width="1512" height="982" alt="Capture d’écran 2026-11-17 à 12 34 23" src="https://github.com/user-attachments/assets/0b0de559-154d-4b80-88bc-d4318f1e17d5" />


**Écart par rapport au lab :** le lab place les disques dans `D:\VMs`. Sur mon serveur, le lecteur `D:` est un lecteur DVD en lecture seule, j'ai donc utilisé le dossier `C:\VMs`.

### Préparation du média d'installation

Comme `D:` est un DVD virtuel, Hyper-V ne propose que l'option « fichier image ». J'ai donc créé un fichier ISO à partir du lecteur `D:` :

```powershell
New-Item -ItemType Directory -Path C:\ISO -Force

$src = New-Object System.IO.FileStream('\\.\D:', 'Open', 'Read', 'ReadWrite')
$dst = [System.IO.File]::Create('C:\ISO\WS2022.iso')
$src.CopyTo($dst, 1MB)
$dst.Close()
$src.Close()
```

Le fichier `C:\ISO\WS2022.iso` fait environ 5,17 Go, comme le lecteur `D:`.

### Démarrage et installation de Windows

```powershell
Add-VMDvdDrive -VMName DC300159672 -Path "C:\ISO\WS2022.iso"
$dvd = Get-VMDvdDrive -VMName DC300159672
Set-VMFirmware -VMName DC300159672 -FirstBootDevice $dvd
Start-VM DC300159672
vmconnect.exe localhost DC300159672
```

J'ai attaché l'ISO à la VM, mis le DVD en premier dans l'ordre de démarrage, puis démarré la VM.

**Problème rencontré :** au premier essai, le message « Press any key to boot from CD or DVD » est passé sans que ma touche soit prise en compte, et la VM a affiché une erreur de démarrage. Après **Action, Reset** et plusieurs appuis sur la barre d'espace, Windows Setup s'est lancé. J'ai ensuite installé Windows Server 2022 avec l'option « Custom : Install Microsoft Server Operating System only », sur le disque de 60 Go.

### Configuration du DC avec PowerShell Direct

Le copier-coller étant peu fiable dans la fenêtre de la VM, j'ai configuré le DC depuis le serveur avec PowerShell Direct :

```powershell
$pw = Read-Host "Mot de passe Administrator de la VM" -AsSecureString
$cred = New-Object System.Management.Automation.PSCredential(".\Administrator", $pw)
Enter-PSSession -VMName DC300159672 -Credential $cred
```

Le mot de passe est saisi sans être affiché. Une fois dans la VM (le prompt devient `[DC300159672]: PS …`), j'ai configuré le réseau et le nom :

```powershell
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 172.16.24.10 -PrefixLength 24 -DefaultGateway 172.16.24.1
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses 172.16.24.10
Rename-Computer -NewName DC300159672 -Restart
```

| Paramètre | Valeur |
|---|---|
| Nom | `DC300159672` (il s'appelait `WIN-CI61HFB462L`) |
| Adresse IP | 172.16.24.10 |
| Masque | 255.255.255.0 |
| Passerelle | 172.16.24.1 |
| DNS | 172.16.24.10 (le DC lui-même) |

**Remarque :** le redémarrage coupe la session PowerShell Direct. Les commandes envoyées pendant que la VM redémarre échouent avec « session closed or broken » : il suffit d'attendre quelques minutes, puis de se reconnecter.

---

## Exercice 5 – Installer Active Directory (dans la VM DC)

```powershell
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
```

J'ai installé le rôle **AD DS** avec ses outils de gestion. Résultat : `Success : True`. Cette étape est obligatoire avant la création de la forêt : sans elle, la commande `Install-ADDSForest` n'est pas reconnue.

---

## Exercice 6 – Créer la forêt (dans la VM DC)

```powershell
Install-ADDSForest -DomainName "DC300159672.local" -DomainNetbiosName "AD300159672"
```

J'ai créé la forêt `DC300159672.local` et promu la VM en contrôleur de domaine. Le DNS est installé en même temps. La commande a demandé un mot de passe de restauration (DSRM), que j'ai saisi sans l'afficher, puis la VM a redémarré automatiquement, ce qui a coupé ma session.

**Capture 3/5 – Forêt :** la création de la forêt `DC300159672.local`.

<img width="1512" height="982" alt="Capture d’écran 2026-11-23 à 16 52 13" src="https://github.com/user-attachments/assets/c93a2d72-178d-4af8-ab44-4a9f8f523ae8" />

**Écart par rapport au lab :** j'ai ajouté `-DomainNetbiosName "AD300159672"`. Sans ce paramètre, le nom NetBIOS proposé (`DC300159672`) est identique au nom de l'ordinateur et la promotion échoue. Le nom NetBIOS du domaine ne peut pas être le même que celui de la machine.

Après le redémarrage, je me suis reconnecté avec le compte du domaine (`AD300159672\Administrator`), car le compte local a été remplacé par celui du domaine.

---

## Exercice 7 – Créer la structure Active Directory (dans la VM DC)

J'ai créé l'OU principale :

```powershell
New-ADOrganizationalUnit -Name "OU300159672"
```

Puis les 4 sous-OU à l'intérieur (le paramètre `-Path` indique l'OU parente) :

```powershell
New-ADOrganizationalUnit -Name "Students" -Path "OU=OU300159672,DC=DC300159672,DC=local"
New-ADOrganizationalUnit -Name "Groups" -Path "OU=OU300159672,DC=DC300159672,DC=local"
New-ADOrganizationalUnit -Name "Workstations" -Path "OU=OU300159672,DC=DC300159672,DC=local"
New-ADOrganizationalUnit -Name "Servers" -Path "OU=OU300159672,DC=DC300159672,DC=local"
```

Pour afficher le résultat dans la capture, j'ai ajouté une commande de lecture seule :

```powershell
Get-ADOrganizationalUnit -Filter *
```

Hiérarchie obtenue :

```
DC300159672.local
|
+-- OU300159672
    |
    +-- Students
    +-- Groups
    +-- Workstations
    +-- Servers
```

**Capture 4/5 – Unités d'organisation :** l'OU `OU300159672` et ses 4 sous-OU.

<img width="1009" height="331" alt="Capture d’écran 2026-11-23 à 21 27 59" src="https://github.com/user-attachments/assets/3a3ecf1a-74aa-4d34-aaa7-4a8adf018b8d" />


### Comptes étudiants (ajout demandé par le prof)

Le prof a demandé de voir des comptes `student1`, `student2`, etc. dans le domaine. Je les ai créés dans l'OU `Students`, depuis le serveur avec PowerShell Direct (session ouverte dans le DC) :

```powershell
$motDePasse = Read-Host "Mot de passe des étudiants" -AsSecureString
$ou = "OU=Students,OU=OU300159672,DC=DC300159672,DC=local"
1..3 | ForEach-Object { New-ADUser -Name "student$_" -SamAccountName "student$_" -AccountPassword $motDePasse -Path $ou -Enabled $true }
```

Le mot de passe est saisi sans être affiché et n'est écrit nulle part. J'ai testé la connexion sur `CLIENT01` avec `student1` (écran « Other user », domaine `AD300159672`) : l'ouverture de session a réussi.

---

## Exercice 8 – Créer le client CLIENT01

Sur le serveur :

```powershell
New-VM -Name CLIENT01 -Generation 2 -MemoryStartupBytes 4GB -NewVHDPath "C:\VMs\CLIENT01.vhdx" -NewVHDSizeBytes 60GB -SwitchName LAB
Add-VMDvdDrive -VMName CLIENT01 -Path "C:\ISO\WS2022.iso"
$dvd = Get-VMDvdDrive -VMName CLIENT01
Set-VMFirmware -VMName CLIENT01 -FirstBootDevice $dvd
Start-VM CLIENT01
vmconnect.exe localhost CLIENT01
```

J'ai créé la VM **CLIENT01** sur le même commutateur LAB et installé Windows Server 2022 avec le même ISO que pour le DC (même appui sur une touche au démarrage). J'ai ensuite ouvert une session PowerShell Direct vers CLIENT01 et configuré le réseau et le nom :

```powershell
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 172.16.24.20 -PrefixLength 24 -DefaultGateway 172.16.24.1
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses 172.16.24.10
Rename-Computer -NewName CLIENT01 -Restart
```

| Paramètre | Valeur |
|---|---|
| Nom | `CLIENT01` |
| Adresse IP | 172.16.24.20 |
| Masque | 255.255.255.0 |
| Passerelle | 172.16.24.1 |
| DNS | 172.16.24.10 (le contrôleur de domaine) |

Le DNS du client pointe sur le DC : c'est ce qui permet au client de trouver le domaine `DC300159672.local`.

---

## Exercice 9 – Joindre le client au domaine (dans la VM CLIENT01)

```powershell
Add-Computer -DomainName DC300159672.local -Credential AD300159672\Administrator -Restart
```

J'ai ajouté CLIENT01 au domaine `DC300159672.local` avec le compte Administrateur du domaine, puis la machine a redémarré. J'ai utilisé `AD300159672\Administrator` (et non `DC300159672\Administrator` comme dans le lab), car c'est le nom NetBIOS de mon domaine.

**Capture 5/5 – CLIENT01 dans le domaine :** le Gestionnaire de serveur (Serveur local) montre CLIENT01 membre du domaine `DC300159672.local`.

<img width="1015" height="754" alt="Capture d’écran 2026-11-23 à 22 20 02" src="https://github.com/user-attachments/assets/146c401b-329b-43f7-a9fd-f6cfa706542b" />


---

## Architecture finale

```
SRV300159672 (SRV24)
10.7.237.225
│
├── Hyper-V
│
└── NAT (LABNAT)
     │
     ▼
172.16.24.0/24
│
├── DC300159672
│     172.16.24.10
│     DC300159672.local
│
└── CLIENT01
      172.16.24.20
```

---

## Récapitulatif des écarts par rapport au lab

| # | Écart | Raison |
|---|---|---|
| 1 | Disques virtuels dans `C:\VMs` au lieu de `D:\VMs` | Le lecteur `D:` du serveur est un DVD en lecture seule |
| 2 | ISO créé à partir du lecteur `D:` | Il n'y avait pas de fichier ISO fourni |
| 3 | Nom, IP et DNS des VM configurés avec des commandes PowerShell | Le lab donne seulement les valeurs, pas les commandes |
| 4 | `-DomainNetbiosName "AD300159672"` | Le nom NetBIOS `DC300159672` est identique au nom de la VM |
| 5 | Identifiant `AD300159672\Administrator` | Conséquence du nom NetBIOS choisi |
| 6 | `Get-ADOrganizationalUnit -Filter *` | Commande de lecture seule ajoutée pour afficher les OU dans la capture |
| 7 | Création de `student1` à `student3` | Demande du prof, pour pouvoir tester une connexion avec un compte étudiant |

---

## Bilan

| Étape | Résultat |
|---|---|
| Commutateur LAB, passerelle 172.16.24.1 et NAT LABNAT | Réussi |
| VM DC300159672 créée et Windows Server 2022 installé | Réussi |
| IP, passerelle et DNS du DC (172.16.24.10) | Réussi |
| Installation d'AD DS | Réussi |
| Forêt DC300159672.local (NetBIOS AD300159672) | Réussi |
| OU OU300159672 et 4 sous-OU | Réussi |
| Comptes student1 à student3 (demandés par le prof) | Réussi |
| VM CLIENT01 (172.16.24.20) | Réussi |
| CLIENT01 membre du domaine | Réussi |
| Connexion à CLIENT01 avec student1 | Réussi |

---

## Conclusion

L'architecture est en place : un réseau privé `172.16.24.0/24` avec NAT, un contrôleur de domaine `DC300159672` qui héberge la forêt `DC300159672.local` et sa structure d'OU, et un poste client `CLIENT01` joint au domaine. À la demande du prof, j'ai aussi créé des comptes `student1` à `student3` et vérifié qu'on peut ouvrir une session avec l'un d'eux sur `CLIENT01`. Chaque étudiant a ainsi sa propre forêt, son propre DNS et son propre sous-réseau, sans conflit avec les autres. Les deux principaux écarts par rapport au lab sont l'emplacement des VM (`C:\VMs`, car `D:` est un DVD) et le nom NetBIOS du domaine (`AD300159672`, car `DC300159672` était déjà le nom de la machine).

---

## Fichiers du dossier

- `README.md`
- `images/`
  - `01-reseau.png`
  - `02-vm-dc.png`
  - `03-foret.png`
  - `04-ou.png`
  - `05-client-domaine.png`
