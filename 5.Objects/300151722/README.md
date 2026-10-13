# Laboratoire 5 - Objets Active Directory, partage et RDP

**Nom : Oustani Islam**  
**ID : 300151722**  
**Système : Windows Server 2022 Datacenter**  
**Domaine : DC300151722.local**  
**Serveur : SRV300151722**

---

## Objectif

L'objectif de ce laboratoire est de manipuler différents objets Active Directory avec PowerShell et de mettre en place un environnement permettant :

- la création d'une unité d'organisation `Students` ;
- la création d'un groupe Active Directory `Students` ;
- la création de comptes utilisateurs ;
- la création d'un dossier partagé SMB ;
- la création et la liaison d'une GPO ;
- le mappage automatique d'un lecteur réseau `Z:` ;
- l'activation de Remote Desktop ;
- l'autorisation du groupe `Students` à utiliser RDP.

---

## 1. Vérification du domaine Active Directory

Les informations du domaine ont été récupérées avec PowerShell :

```powershell
$domain = Get-ADDomain

$domain.DNSRoot
$domain.NetBIOSName
```

Résultat :

```text
DNSRoot     : DC300151722.local
NetBIOSName : DC300151722
```

Une unité d'organisation nommée `Students` a ensuite été créée :

```powershell
New-ADOrganizationalUnit `
    -Name "Students" `
    -Path "DC=DC300151722,DC=local"
```

Vérification :

```powershell
Get-ADOrganizationalUnit -Filter 'Name -eq "Students"'
```

Résultat :

```text
DistinguishedName : OU=Students,DC=DC300151722,DC=local
Name              : Students
ObjectClass       : organizationalUnit
```

### Preuve

<img width="1060" height="1010" alt="1" src="https://github.com/user-attachments/assets/f2f560da-a2b8-486e-a1ea-03ce41b45092" />

---

## 2. Création du groupe et des utilisateurs Active Directory

Le groupe Active Directory `Students` a été créé afin de regrouper les utilisateurs autorisés à accéder aux différentes ressources.

Les comptes suivants ont été créés :

```text
Etudiant1
Etudiant2
```

Les utilisateurs ont été placés dans l'OU :

```text
OU=Students,DC=DC300151722,DC=local
```

### Vérification du groupe

```powershell
Get-ADGroup -Identity Students
```

Résultat :

```text
Name       : Students
GroupScope : Global
ObjectClass: group
```

### Vérification des utilisateurs

```powershell
Get-ADUser -Filter * `
    -SearchBase "OU=Students,DC=DC300151722,DC=local"
```

Les deux comptes apparaissent avec :

```text
Etudiant1 - Enabled : True
Etudiant2 - Enabled : True
```

---

## 3. Création du dossier partagé

Un dossier partagé a été créé sur le serveur :

```text
C:\SharedResources
```

Le partage SMB porte le nom :

```text
SharedResources
```

Vérification avec PowerShell :

```powershell
Get-SmbShare -Name SharedResources
```

Résultat :

```text
Name            Path
----            ----
SharedResources C:\SharedResources
```

### Preuve

<img width="1076" height="1006" alt="2" src="https://github.com/user-attachments/assets/f052de95-aa29-4695-a432-3ff32602a0a3" />

---

## 4. Création de la GPO MapSharedFolder

Une stratégie de groupe nommée `MapSharedFolder` a été créée avec PowerShell.

```powershell
New-GPO -Name "MapSharedFolder"
```

La GPO a été liée à l'OU `Students` :

```powershell
New-GPLink `
    -Name "MapSharedFolder" `
    -Target "OU=Students,DC=DC300151722,DC=local"
```

La présence de la GPO a été vérifiée avec :

```powershell
Get-GPO -Name "MapSharedFolder"
```

Résultat :

```text
DisplayName : MapSharedFolder
DomainName  : DC300151722.local
GpoStatus   : AllSettingsEnabled
```

La liaison avec l'OU `Students` a été vérifiée avec :

```powershell
Get-GPInheritance `
    -Target "OU=Students,DC=DC300151722,DC=local"
```

Le résultat confirme :

```text
GpoLinks : {MapSharedFolder}
```

---

## 5. Création du lecteur réseau Z:

Un script de connexion a été créé dans :

```text
C:\Scripts\MapDrive-Z.bat
```

Son contenu est :

```bat
net use Z: \\SRV300151722\SharedResources /persistent:no
```

Le contenu du fichier a été vérifié avec :

```powershell
Get-Content C:\Scripts\MapDrive-Z.bat
```

Le lecteur `Z:` permet aux utilisateurs concernés d'accéder au partage :

```text
\\SRV300151722\SharedResources
```

### Preuve

<img width="1012" height="955" alt="3" src="https://github.com/user-attachments/assets/9ee4cc76-9b56-47a8-91fd-bc522ba3889e" />

---

## 6. Activation de Remote Desktop

Remote Desktop a été activé sur le serveur avec PowerShell :

```powershell
Set-ItemProperty `
    -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" `
    -Name "fDenyTSConnections" `
    -Value 0
```

La configuration a ensuite été vérifiée :

```powershell
Get-ItemProperty `
    -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" `
    -Name "fDenyTSConnections"
```

Résultat :

```text
fDenyTSConnections : 0
```

La valeur `0` confirme que Remote Desktop est activé.

---

## 7. Activation des règles du pare-feu RDP

Les règles Windows Firewall pour Remote Desktop ont été activées avec :

```powershell
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
```

Puis vérifiées avec :

```powershell
Get-NetFirewallRule -DisplayGroup "Remote Desktop" |
    Select-Object DisplayName, Enabled
```

Résultat :

```text
Remote Desktop - Shadow (TCP-In)      True
Remote Desktop - User Mode (TCP-In)   True
Remote Desktop - User Mode (UDP-In)   True
```

Les règles nécessaires à RDP sont donc bien actives.

---

## 8. Groupe Remote Desktop Users

Comme le serveur est un contrôleur de domaine, le groupe intégré Remote Desktop Users a été identifié avec son SID :

```powershell
Get-ADGroup -Identity "S-1-5-32-555"
```

Résultat :

```text
Name           : Remote Desktop Users
SamAccountName : Remote Desktop Users
SID            : S-1-5-32-555
GroupScope     : DomainLocal
```

Le groupe Active Directory `Students` peut être ajouté à ce groupe avec :

```powershell
Add-ADGroupMember `
    -Identity "S-1-5-32-555" `
    -Members "Students"
```

La vérification s'effectue avec :

```powershell
Get-ADGroupMember -Identity "S-1-5-32-555"
```

### Preuve

<img width="1037" height="972" alt="4" src="https://github.com/user-attachments/assets/9a2332f9-3589-482e-a84f-c2eaeedb80b3" />

---

## Scripts PowerShell

Deux scripts principaux ont été utilisés pendant le laboratoire.

### utilisateurs1.ps1

Ce script permet de :

- créer le dossier `C:\SharedResources` ;
- créer le groupe Active Directory `Students` ;
- créer les utilisateurs `Etudiant1` et `Etudiant2` ;
- ajouter les utilisateurs au groupe ;
- créer le partage SMB.

```powershell
$SharedFolder = "C:\SharedResources"

New-Item `
    -Path $SharedFolder `
    -ItemType Directory `
    -Force

$GroupName = "Students"

New-ADGroup `
    -Name $GroupName `
    -GroupScope Global `
    -Description "Users allowed RDP and shared folder access"

$Users = @("Etudiant1","Etudiant2")

foreach ($user in $Users) {

    New-ADUser `
        -Name $user `
        -SamAccountName $user `
        -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) `
        -Enabled $true `
        -Path "OU=Students,DC=DC300151722,DC=local"

    Add-ADGroupMember `
        -Identity $GroupName `
        -Members $user
}

New-SmbShare `
    -Name "SharedResources" `
    -Path $SharedFolder `
    -FullAccess $GroupName
```

---

### utilisateurs2.ps1

Ce script permet de créer la GPO `MapSharedFolder`, de la lier à l'OU `Students` et de préparer le lecteur réseau `Z:`.

```powershell
$GPOName = "MapSharedFolder"

New-GPO -Name $GPOName

$OU = "OU=Students,DC=DC300151722,DC=local"

New-GPLink `
    -Name $GPOName `
    -Target $OU

$DriveLetter = "Z:"
$SharePath = "\\SRV300151722\SharedResources"

$ScriptFolder = "C:\Scripts"

if (-not (Test-Path $ScriptFolder)) {
    New-Item `
        -ItemType Directory `
        -Path $ScriptFolder
}

$ScriptPath = "$ScriptFolder\MapDrive-Z.bat"

$scriptContent = "net use Z: $SharePath /persistent:no"

Set-Content `
    -Path $ScriptPath `
    -Value $scriptContent
```

---

## Résultat

À la fin du laboratoire, les éléments suivants ont été configurés :

| Élément | Résultat |
|---|---|
| Domaine | `DC300151722.local` |
| OU | `Students` |
| Groupe AD | `Students` |
| Utilisateur 1 | `Etudiant1` |
| Utilisateur 2 | `Etudiant2` |
| Dossier partagé | `C:\SharedResources` |
| Partage SMB | `SharedResources` |
| GPO | `MapSharedFolder` |
| Lecteur réseau | `Z:` |
| Remote Desktop | Activé |
| Pare-feu RDP | Activé |
| Groupe RDP | `Remote Desktop Users` |

---

## Conclusion

Ce laboratoire a permis de gérer plusieurs objets Active Directory à l'aide de PowerShell.

Nous avons créé une unité d'organisation, un groupe et des utilisateurs Active Directory, configuré un partage SMB, créé une GPO pour préparer le mappage d'un lecteur réseau et activé l'accès Remote Desktop.

Ce laboratoire permet de mieux comprendre la relation entre **Active Directory, les groupes, les utilisateurs, les GPO, les partages réseau et RDP** dans un environnement Windows Server 2022.
