# 🚀 INF1084 - Architecture simplifiée (1 étudiant = 1 forêt = 1 sous-réseau)

## 🎯 Objectif

Chaque étudiant possède :

- ✅ Une VM Windows Server 2022 assignée
- ✅ Une forêt Active Directory indépendante
- ✅ Un domaine AD DS indépendant
- ✅ Son propre DNS
- ✅ Son propre sous-réseau privé
- ✅ Ses propres VM Hyper‑V imbriquées

Aucun étudiant n'utilise directement le réseau des autres étudiants.

---

# 🌐 Réseau du collège

```text
10.7.236.0/23
```

Machines attribuées :

```text
SRV01 = 10.7.237.202
SRV02 = 10.7.237.203
...
SRV31 = 10.7.237.232
```

---

# 🏗️ Architecture recommandée

Chaque étudiant crée un réseau privé dans sa VM Hyper‑V.

Exemple :

```text
Étudiant : 🆔

Serveur parent :
SRV🆔
10.7.237.#️⃣

Réseau privé :
172.16.#️⃣.0/24
```

---

# 🌐 Plan d'adressage

| Élément | Configuration |
|----------|----------|
| 🖥️ Serveur parent | SRV🆔 |
| 🌐 Réseau privé | 172.16.#️⃣.0/24 |
| 🚪 Passerelle NAT | 172.16.#️⃣.1 |
| 🏢 Contrôleur de domaine | DC🆔 |
| 📍 Adresse IP du DC | 172.16.#️⃣.10 |
| 💻 Client | CLIENT01 |
| 📍 Adresse IP du client | 172.16.#️⃣.20 |
| 🌲 Domaine AD DS | DC🆔.local |

---

# 🌐 Exercice 2 - Créer le réseau privé

Créer le commutateur interne :

```powershell
New-VMSwitch `
    -Name LAB `
    -SwitchType Internal
```

---

# 🚪 Exercice 3 - Configurer la passerelle NAT

Créer l'adresse IP du réseau interne :

```powershell
New-NetIPAddress `
    -IPAddress 172.16.#️⃣.1 `
    -PrefixLength 24 `
    -InterfaceAlias "vEthernet (LAB)"
```

Créer le NAT :

```powershell
New-NetNat `
    -Name LABNAT `
    -InternalIPInterfaceAddressPrefix 172.16.#️⃣.0/24
```

---

# 💾 Exercice 4 - Créer le contrôleur de domaine

```powershell
New-VM `
    -Name DC300151722 `
    -Generation 2 `
    -MemoryStartupBytes 4GB `
    -NewVHDPath "D:\VMs\DC300151722.vhdx" `
    -NewVHDSizeBytes 60GB `
    -SwitchName LAB
```

---

# 🖥️ Configuration du DC

```text
Nom :
DC300151722

Adresse IP :
172.16.17.10

Masque :
255.255.255.0

Passerelle :
172.16.17.1

DNS :
172.16.17.10
```

---

# 🌲 Exercice 5 - Installer Active Directory

```powershell
Install-WindowsFeature `
    AD-Domain-Services `
    -IncludeManagementTools
```

---

# 🌳 Exercice 6 - Créer la forêt

```powershell
Install-ADDSForest `
    -DomainName "DC300151722.local"
```

---

# 🏢 Exercice 7 - Créer la structure Active Directory

Créer l'OU principale :

```powershell
New-ADOrganizationalUnit `
    -Name "OU300151722"
```

Créer les sous‑OU :

```powershell
New-ADOrganizationalUnit `
    -Name "Students" `
    -Path "OU=OU300151722,DC=DC300151722,DC=local"

New-ADOrganizationalUnit `
    -Name "Groups" `
    -Path "OU=OU300151722,DC=DC300151722,DC=local"

New-ADOrganizationalUnit `
    -Name "Workstations" `
    -Path "OU=OU300151722,DC=DC300151722,DC=local"

New-ADOrganizationalUnit `
    -Name "Servers" `
    -Path "OU=OU300151722,DC=DC300151722,DC=local"
```

---

# 💻 Exercice 8 - Créer un client

```powershell
New-VM `
    -Name CLIENT01 `
    -Generation 2 `
    -MemoryStartupBytes 4GB `
    -NewVHDPath "D:\VMs\CLIENT01.vhdx" `
    -NewVHDSizeBytes 60GB `
    -SwitchName LAB
```

---

# 🖥️ Configuration du client

```text
Nom :
CLIENT01

Adresse IP :
172.16.17.20

Masque :
255.255.255.0

Passerelle :
172.16.17.1

DNS :
172.16.17.10
```

---

# 🔗 Exercice 9 - Joindre le client au domaine

```powershell
Add-Computer `
    -DomainName DC300151722.local `
    -Credential DC300151722\Administrator `
    -Restart
```

---

# 🏗️ Architecture finale

```text
SRV17
10.7.237.218
│
├── Hyper-V
│
└── NAT
     │
     ▼
172.16.17.0/24
│
├── DC300151722
│     172.16.17.10
│     DC300151722.local
│
└── CLIENT01
      172.16.17.20
```

---

# 🎓 Avantages pédagogiques

✅ Un étudiant = une forêt

✅ Un étudiant = un domaine

✅ Un étudiant = un DNS

✅ Un étudiant = un sous-réseau privé

✅ Aucun conflit AD DS

✅ Aucun conflit DNS

✅ Aucun conflit DHCP

✅ Compatible avec :

- 🌲 AD DS
- 🌐 DNS
- 👥 Utilisateurs
- 👥 Groupes
- 📂 OU
- 📜 GPO
- 🔗 AGDLP
- 🏗️ AGUDLP
- 💻 Hyper‑V
- 🔒 Permissions NTFS
- 📁 Partages réseau

Cette approche est la plus simple à administrer pour un groupe de **31 étudiants** et facilite énormément la correction des laboratoires.
