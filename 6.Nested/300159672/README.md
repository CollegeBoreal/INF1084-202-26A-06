# 300159672

## INF1084 – Architecture simplifiée (1 étudiant = 1 forêt = 1 sous-réseau)

| | |
|---|---|
| **Étudiant** | Amadou – 300159672 |
| **Établissement** | Collège Boréal |
| **Cours** | INF1084 |
| **Laboratoire** | `6.Nested` |
| **Serveur parent** | SRV300159672 (10.7.237.225) = SRV24 |
| **Domaine** | `DC300159672.local` (NetBIOS : `AD300159672`) |

---

## Plan d'adressage

Mon serveur est le **SRV24** (n = 24, car SRV01 = 10.7.237.202 … SRV24 = 10.7.237.225). Mon sous-réseau privé est donc `172.16.24.0/24`.

| Élément | Configuration |
|---|---|
| Serveur parent | SRV300159672 – 10.7.237.225 |
| Réseau privé | 172.16.24.0/24 |
| Passerelle NAT | 172.16.24.1 |
| Contrôleur de domaine | DC300159672 |
| Adresse IP du DC | 172.16.24.10 |
| Client | CLIENT01 |
| Adresse IP du client | 172.16.24.20 |
| Domaine AD DS | DC300159672.local |

---

## Exercice 2 – Créer le réseau privé (sur le serveur)

```powershell
New-VMSwitch -Name LAB -SwitchType Internal
```

## Exercice 3 – Configurer la passerelle NAT (sur le serveur)

```powershell
New-NetIPAddress -IPAddress 172.16.24.1 -PrefixLength 24 -InterfaceAlias "vEthernet (LAB)"
New-NetNat -Name LABNAT -InternalIPInterfaceAddressPrefix 172.16.24.0/24
```

**Capture 1/5 – Réseau :** le commutateur `LAB`, l'adresse 172.16.24.1 et le NAT `LABNAT`.

<img width="1512" height="982" alt="Capture d’écran 2026-11-17 à 12 19 13" src="https://github.com/user-attachments/assets/1af52004-2ee9-4025-8c5a-a34ced16e1d4" />



---

## Exercice 4 – Créer le contrôleur de domaine

```powershell
New-VM -Name DC300159672 -Generation 2 -MemoryStartupBytes 4GB -NewVHDPath "C:\VMs\DC300159672.vhdx" -NewVHDSizeBytes 60GB -SwitchName LAB
```

**Capture 2/5 – VM du contrôleur de domaine :** la VM `DC300159672` créée.

<img width="1512" height="982" alt="Capture d’écran 2026-11-17 à 12 34 23" src="https://github.com/user-attachments/assets/09695e40-ed16-4d46-9b3a-d992923440b0" />


**Écart par rapport au lab :** les disques virtuels sont dans `C:\VMs` et non `D:\VMs`, car le lecteur `D:` de mon serveur est un lecteur DVD.

**Installation de Windows Server :** j'ai créé un fichier ISO à partir de ce DVD dans `C:\ISO\WS2022.iso`, je l'ai attaché à la VM, puis démarré la VM (touche appuyée au message « Press any key to boot from CD or DVD »).

**Configuration du DC** (faite depuis le serveur avec PowerShell Direct) :

| Paramètre | Valeur |
|---|---|
| Nom | `DC300159672` (il s'appelait `WIN-CI61HFB462L`) |
| Adresse IP | 172.16.24.10 |
| Masque | 255.255.255.0 |
| Passerelle | 172.16.24.1 |
| DNS | 172.16.24.10 |

---

## Exercice 5 – Installer Active Directory (dans la VM DC)

```powershell
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
```

Résultat : `Success : True`.

---

## Exercice 6 – Créer la forêt (dans la VM DC)

```powershell
Install-ADDSForest -DomainName "DC300159672.local" -DomainNetbiosName "AD300159672"
```

**Capture 3/5 – Forêt :** la création de la forêt `DC300159672.local`.

<img width="1512" height="982" alt="Capture d’écran 2026-11-23 à 16 52 13" src="https://github.com/user-attachments/assets/dc857da4-171a-465b-b2ed-69a27acca440" />



**Écart par rapport au lab :** j'ai ajouté `-DomainNetbiosName "AD300159672"`. Sans cela, le nom NetBIOS proposé (`DC300159672`) est identique au nom de l'ordinateur et la commande refuse de continuer.

---

## Exercice 7 – Créer la structure Active Directory (dans la VM DC)

OU principale :

```powershell
New-ADOrganizationalUnit -Name "OU300159672"
```

Sous-OU :

```powershell
New-ADOrganizationalUnit -Name "Students" -Path "OU=OU300159672,DC=DC300159672,DC=local"
New-ADOrganizationalUnit -Name "Groups" -Path "OU=OU300159672,DC=DC300159672,DC=local"
New-ADOrganizationalUnit -Name "Workstations" -Path "OU=OU300159672,DC=DC300159672,DC=local"
New-ADOrganizationalUnit -Name "Servers" -Path "OU=OU300159672,DC=DC300159672,DC=local"
```

Pour afficher le résultat dans la capture (commande de lecture seule, ajoutée) :

```powershell
Get-ADOrganizationalUnit -Filter *
```

**Capture 4/5 – Unités d'organisation :** l'OU `OU300159672` et ses 4 sous-OU.

<img width="1009" height="331" alt="Capture d’écran 2026-11-23 à 21 27 59" src="https://github.com/user-attachments/assets/8134052a-4c2e-4b09-a0a8-3f6c5d080d17" />


---

## Exercice 8 – Créer un client

Sur le serveur :

```powershell
New-VM -Name CLIENT01 -Generation 2 -MemoryStartupBytes 4GB -NewVHDPath "C:\VMs\CLIENT01.vhdx" -NewVHDSizeBytes 60GB -SwitchName LAB
```

Installation de Windows Server à partir du même ISO, puis configuration :

| Paramètre | Valeur |
|---|---|
| Nom | `CLIENT01` |
| Adresse IP | 172.16.24.20 |
| Masque | 255.255.255.0 |
| Passerelle | 172.16.24.1 |
| DNS | 172.16.24.10 |

---

## Exercice 9 – Joindre le client au domaine (dans la VM CLIENT01)

```powershell
Add-Computer -DomainName DC300159672.local -Credential AD300159672\Administrator -Restart
```

**Capture 5/5 – CLIENT01 dans le domaine :** le Gestionnaire de serveur (Serveur local) montre CLIENT01 membre du domaine `DC300159672.local`.

<img width="1015" height="754" alt="Capture d’écran 2026-11-23 à 22 20 02" src="https://github.com/user-attachments/assets/fdd617ad-c810-4392-a07f-0f3a98768ea3" />


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
| 1 | Disques virtuels dans `C:\VMs` au lieu de `D:\VMs` | Le lecteur `D:` du serveur est un DVD |
| 2 | ISO créé à partir du lecteur `D:` | Il n'y avait pas de fichier ISO fourni |
| 3 | Nom, IP et DNS des VM configurés avec des commandes PowerShell | Le lab donne seulement les valeurs, pas les commandes |
| 4 | `-DomainNetbiosName "AD300159672"` | Le nom NetBIOS `DC300159672` est identique au nom de la VM |
| 5 | Identifiant `AD300159672\Administrator` | Conséquence du nom NetBIOS choisi |
| 6 | `Get-ADOrganizationalUnit -Filter *` | Commande de lecture seule ajoutée pour afficher les OU dans la capture |

---

## Conclusion

L'architecture est en place : un réseau privé `172.16.24.0/24` avec NAT, un contrôleur de domaine `DC300159672` qui héberge la forêt `DC300159672.local` et sa structure d'OU, et un poste client `CLIENT01` joint au domaine.

---

## Fichiers du dossier

- `README.md`
- `images/`
  - `01-reseau.png`
  - `02-vm-dc.png`
  - `03-foret.png`
  - `04-ou.png`
  - `05-client-domaine.png`
