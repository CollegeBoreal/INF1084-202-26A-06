# 🚀 INF1084 - Scripts PowerShell pour les laboratoires AD DS

## 🎯 Exercice 1 - Installer Active Directory

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

## 🌲 Exercice 2 - Créer une forêt Active Directory

Remplacez par votre numéro étudiant.

```powershell
Install-ADDSForest `
    -DomainName "300123456.local"
```

✅ Vérifier :

```powershell
Get-ADForest
Get-ADDomain
```

---

# 🏢 Exercice 3 - Créer une OU

```powershell
New-ADOrganizationalUnit `
    -Name "INF1084"
```

Créer les sous-OU :

```powershell
New-ADOrganizationalUnit `
    -Name "Students" `
    -Path "OU=INF1084,DC=300123456,DC=local"

New-ADOrganizationalUnit `
    -Name "Servers" `
    -Path "OU=INF1084,DC=300123456,DC=local"

New-ADOrganizationalUnit `
    -Name "Groups" `
    -Path "OU=INF1084,DC=300123456,DC=local"
```

---

# 👤 Exercice 4 - Créer des utilisateurs

```powershell
New-ADUser `
    -Name "Alice Martin" `
    -GivenName "Alice" `
    -Surname "Martin" `
    -SamAccountName "alice.martin" `
    -Path "OU=Students,OU=INF1084,DC=300123456,DC=local" `
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
        -Path "OU=Students,OU=INF1084,DC=300123456,DC=local" `
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
    -Path "OU=Groups,OU=INF1084,DC=300123456,DC=local"
```

## 🌎 Groupe Universal

```powershell
New-ADGroup `
    -Name UG_ContentEditors `
    -GroupScope Universal `
    -GroupCategory Security `
    -Path "OU=Groups,OU=INF1084,DC=300123456,DC=local"
```

## 🏢 Groupe Domain Local

```powershell
New-ADGroup `
    -Name DL_ProjectFolder_Modify `
    -GroupScope DomainLocal `
    -GroupCategory Security `
    -Path "OU=Groups,OU=INF1084,DC=300123456,DC=local"
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

---

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
SRV17
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

Créer la VM :

```powershell
New-VM `
    -Name DC01 `
    -Generation 2 `
    -MemoryStartupBytes 4GB `
    -NewVHDPath "D:\VMs\DC01.vhdx" `
    -NewVHDSizeBytes 60GB `
    -SwitchName LAB
```

---

# 💻 Exercice 13 - Joindre un client au domaine

Dans CLIENT01 :

```powershell
Add-Computer `
    -DomainName 300123456.local `
    -Credential Administrator `
    -Restart
```

---

# 🏗️ Architecture finale

```text
🖥️ SRV17
10.7.237.218
│
├─ ⚙️ Hyper-V
│
└─ 🌐 NAT
    │
    ▼
172.16.17.0/24
│
├─ 🏢 DC01
│   172.16.17.10
│   300123456.local
│
└─ 💻 CLIENT01
    172.16.17.20
```

