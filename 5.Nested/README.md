# 🚀 INF1084 - Scripts PowerShell pour les laboratoires AD DS (OU Ségréguées par étudiant)

## 🎯 Convention obligatoire

Remplacez toujours :

```text
300123456
```

- [ ] par votre numéro étudiant :id: .

`172.16.X.0/24`

- [ ] X par votre numéro séquentiel dans [🎉 Participation](../0.PlanDeCours/.scripts/Participation.md) .

Exemple :

| Élément | Configuration |
|----------|----------|
| 🖥️ Serveur | `DC300123456` |
| 🌳 Domaine | `DC300123456.local` |
| 🏢 NetBIOS | `DC300123456` |
| 📂 OU Racine | `OU300123456` |
| 🌐 Réseau interne | `172.16.X.0/24` |

---

# 🎯 Exercice 1 - Installer Active Directory

```powershell
Install-WindowsFeature `
    AD-Domain-Services `
    -IncludeManagementTools
```

✅ Vérification :

```powershell
Get-WindowsFeature AD-Domain-Services
```

---

# 🌲 Exercice 2 - Créer une forêt Active Directory

```powershell
Install-ADDSForest `
    -DomainName "DC300123456.local"
```

✅ Vérifier :

```powershell
Get-ADForest
Get-ADDomain
```

---

# 🏢 Exercice 3 - Créer des OU ségréguées

Créer l'OU racine de l'étudiant :

```powershell
New-ADOrganizationalUnit `
    -Name "OU300123456"
```

Créer les sous-OU :

```powershell
New-ADOrganizationalUnit `
    -Name "Students" `
    -Path "OU=OU300123456,DC=DC300123456,DC=local"

New-ADOrganizationalUnit `
    -Name "Servers" `
    -Path "OU=OU300123456,DC=DC300123456,DC=local"

New-ADOrganizationalUnit `
    -Name "Groups" `
    -Path "OU=OU300123456,DC=DC300123456,DC=local"

New-ADOrganizationalUnit `
    -Name "Workstations" `
    -Path "OU=OU300123456,DC=DC300123456,DC=local"

New-ADOrganizationalUnit `
    -Name "ServiceAccounts" `
    -Path "OU=OU300123456,DC=DC300123456,DC=local"
```

---

# 👤 Exercice 4 - Créer des utilisateurs

```powershell
New-ADUser `
    -Name "Alice Martin" `
    -GivenName "Alice" `
    -Surname "Martin" `
    -SamAccountName "alice.martin" `
    -Path "OU=Students,OU=OU300123456,DC=DC300123456,DC=local" `
    -AccountPassword (
        ConvertTo-SecureString `
        "P@ssw0rd123!" `
        -AsPlainText `
        -Force
    ) `
    -Enabled $true
```

Créer plusieurs utilisateurs :

```powershell
1..10 | ForEach-Object {

    New-ADUser `
        -Name "Student$_" `
        -SamAccountName "student$_" `
        -Path "OU=Students,OU=OU300123456,DC=DC300123456,DC=local" `
        -AccountPassword (
            ConvertTo-SecureString `
            "P@ssw0rd123!" `
            -AsPlainText `
            -Force
        ) `
        -Enabled $true

}
```

---

# 👥 Exercice 5 - Créer des groupes

## 🌍 Groupe Global

```powershell
New-ADGroup `
    -Name GG_Developers `
    -GroupScope Global `
    -GroupCategory Security `
    -Path "OU=Groups,OU=OU300123456,DC=DC300123456,DC=local"
```

## 🌎 Groupe Universal

```powershell
New-ADGroup `
    -Name UG_ContentEditors `
    -GroupScope Universal `
    -GroupCategory Security `
    -Path "OU=Groups,OU=OU300123456,DC=DC300123456,DC=local"
```

## 🏢 Groupe Domain Local

```powershell
New-ADGroup `
    -Name DL_ProjectFolder_Modify `
    -GroupScope DomainLocal `
    -GroupCategory Security `
    -Path "OU=Groups,OU=OU300123456,DC=DC300123456,DC=local"
```

---

# 🔗 Exercice 6 - AGDLP

Ajouter un utilisateur au groupe global :

```powershell
Add-ADGroupMember `
    -Identity GG_Developers `
    -Members alice.martin
```

Ajouter le groupe global au groupe Domain Local :

```powershell
Add-ADGroupMember `
    -Identity DL_ProjectFolder_Modify `
    -Members GG_Developers
```

Structure :

```text
👤 Alice
     ↓
🌍 GG_Developers
     ↓
🏢 DL_ProjectFolder_Modify
     ↓
🔐 Permissions
```

---

# 🏗️ Exercice 7 - AGUDLP

Ajouter le groupe global au groupe universel :

```powershell
Add-ADGroupMember `
    -Identity UG_ContentEditors `
    -Members GG_Developers
```

Ajouter le groupe universel au groupe Domain Local :

```powershell
Add-ADGroupMember `
    -Identity DL_ProjectFolder_Modify `
    -Members UG_ContentEditors
```

Structure :

```text
👤 Alice
     ↓
🌍 GG_Developers
     ↓
🌎 UG_ContentEditors
     ↓
🏢 DL_ProjectFolder_Modify
     ↓
🔐 Permissions
```

---

# 📁 Exercice 8 - Dossier partagé

Créer :

```powershell
New-Item `
    -Path C:\ProjectFolder `
    -ItemType Directory
```

Partager :

```powershell
New-SmbShare `
    -Name ProjectFolder `
    -Path C:\ProjectFolder `
    -FullAccess Administrators
```

---

# 🔒 Exercice 9 - Permissions NTFS

## 📖 Lecture

```powershell
$acl = Get-Acl C:\ProjectFolder

$rule = New-Object `
    System.Security.AccessControl.FileSystemAccessRule(
        "DL_ProjectFolder_Read",
        "ReadAndExecute",
        "ContainerInherit,ObjectInherit",
        "None",
        "Allow"
)

$acl.AddAccessRule($rule)

Set-Acl C:\ProjectFolder $acl
```

## ✏️ Modification

```powershell
$acl = Get-Acl C:\ProjectFolder

$rule = New-Object `
    System.Security.AccessControl.FileSystemAccessRule(
        "DL_ProjectFolder_Modify",
        "Modify",
        "ContainerInherit,ObjectInherit",
        "None",
        "Allow"
)

$acl.AddAccessRule($rule)

Set-Acl C:\ProjectFolder $acl
```

---

# 🖥️ Exercice 10 - Installer Hyper‑V

```powershell
Install-WindowsFeature `
    Hyper-V `
    -IncludeManagementTools `
    -Restart
```

---

# 🌐 Exercice 11 - Créer le réseau NAT des VM imbriquées

Pour l'étudiant utilisant :

```text
DC300123456
```

Réseau recommandé :

```text
172.16.17.0/24
```

Créer le vSwitch :

```powershell
New-VMSwitch `
    -Name LAB `
    -SwitchType Internal
```

Configurer l'interface :

```powershell
New-NetIPAddress `
    -IPAddress 172.16.17.1 `
    -PrefixLength 24 `
    -InterfaceAlias "vEthernet (LAB)"
```

Créer le NAT :

```powershell
New-NetNat `
    -Name LABNAT `
    -InternalIPInterfaceAddressPrefix 172.16.17.0/24
```

---

# 💾 Exercice 12 - Créer un DC imbriqué

```powershell
New-VM `
    -Name DC300123456 `
    -Generation 2 `
    -MemoryStartupBytes 4GB `
    -NewVHDPath "D:\VMs\DC300123456.vhdx" `
    -NewVHDSizeBytes 60GB `
    -SwitchName LAB
```

Configuration réseau :

```text
Nom : DC300123456

IP :
172.16.17.10

DNS :
172.16.17.10

Domaine :
DC300123456.local
```

---

# 💻 Exercice 13 - Joindre un client au domaine

CLIENT01 :

```text
IP :
172.16.17.20

DNS :
172.16.17.10
```

Joindre le domaine :

```powershell
Add-Computer `
    -DomainName DC300123456.local `
    -Credential DC300123456\Administrator `
    -Restart
```

---

# 🏗️ Architecture finale

```text
🖥️ DC300123456
10.7.237.218
│
├─ ⚙️ Hyper-V
│
└─ 🌐 NAT
    │
    ▼
172.16.17.0/24
│
├─ 🏢 DC300123456
│   172.16.17.10
│   DC300123456.local
│
└─ 💻 CLIENT01
    172.16.17.20
```

---

# 🏢 Structure Active Directory finale

```text
DC300123456.local
│
└── OU300123456
    │
    ├── Students
    ├── Servers
    ├── Groups
    ├── Workstations
    └── ServiceAccounts
```

---

# 🎓 Compétences développées

✅ Forêt Active Directory personnelle 🌲

✅ Domaine AD DS personnalisé 🏢

✅ DNS intégré 🌐

✅ OU ségréguées par étudiant 📂

✅ Utilisateurs 👥

✅ Groupes 🌍🌎🏢

✅ AGDLP 🔗

✅ AGUDLP 🏗️

✅ Hyper‑V imbriqué ⚙️

✅ VM clientes 💻

✅ GPO 📜

✅ Partages réseau 📁

✅ Permissions NTFS 🔒

✅ Environnement totalement isolé pour chaque étudiant 🎯
