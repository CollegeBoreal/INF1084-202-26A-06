# 300159672

## INF1084 – Partage de ressources et RDP via PowerShell

| | |
|---|---|
| Étudiant | Amadou – 300159672 |
| Établissement | Collège Boréal |
| Cours | INF1084 |
| Laboratoire | Partage de ressources et RDP via PowerShell (`5.Objects`) |
| Domaine | `DC300159672.local` (NetBIOS : `DC300159672`) |
| Serveur | `SRV300159672` (10.7.237.225), Windows Server 2022 |
| Accès | RDP depuis un Mac (Windows App) |

Ce labo crée, uniquement avec PowerShell, un dossier partagé, un groupe `Students` avec deux utilisateurs, une GPO qui monte le lecteur `Z:`, puis autorise le RDP pour le groupe.

---

## Dépôt Git

Comme demandé dans le lab, le travail est rangé dans un dossier à mon identifiant `300159672`, avec ce `README.md` et un dossier `images/` (qui contient `.gitkeep`). Les fichiers ont été déposés depuis l'interface web de GitHub, car la VM n'est pas utilisée pour le `git push`.

```
5.Objects/300159672/
├── README.md
├── utilisateurs1.ps1
├── utilisateurs2.ps1
├── utilisateurs3.ps1
└── images/
```

## 1. Pré-requis et `bootstrap.ps1`

J'ai commencé par créer le fichier `bootstrap.ps1`, qui regroupe mes informations (numéro étudiant, nom du domaine, nom NetBIOS, nom du serveur) et les informations de sécurité. Je le charge avec le *dot-sourcing* (`. .\bootstrap.ps1`) pour que ces variables soient disponibles dans les scripts suivants. Le contrôleur de domaine avec AD DS et les modules `ActiveDirectory` et `GroupPolicy` étaient déjà en place.

```powershell
# vos informations
$studentNumber = 300159672

# les noms respectifs
$domainName = "DC$studentNumber.local"
$netbiosName = "DC$studentNumber"
$serverName = "SRV$studentNumber"

# les informations de securite
$plain = '<mot de passe de l Administrator>'
$secure = ConvertTo-SecureString $plain -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential("Administrator@$domainName", $secure)
```

> Le mot de passe réel n'est volontairement pas publié.

<img width="988" height="644" alt="Capture d’écran 2026-11-09 à 13 15 18" src="https://github.com/user-attachments/assets/4a2e9d11-572b-40d8-a0f5-6f1cdfb97408" />


---

## 2. Dossier partagé, groupe et utilisateurs – `utilisateurs1.ps1`

J'ai ensuite exécuté `utilisateurs1.ps1`. Il crée le dossier `C:\SharedResources`, le groupe de sécurité `Students`, les comptes `Etudiant1` et `Etudiant2` (ajoutés au groupe), puis partage le dossier avec le contrôle total pour le groupe `Students`. J'ai vérifié ensuite que le partage existe et que le groupe y a accès.

```powershell
# Chemin du dossier
$SharedFolder = "C:\SharedResources"

# Créer le dossier
New-Item -Path $SharedFolder -ItemType Directory -Force

# Créer un partage SMB pour le groupe Students
$GroupName = "Students"

# Créer le groupe AD
New-ADGroup -Name $GroupName -GroupScope Global -Description "Users allowed RDP and shared folder access"

# Créer des utilisateurs AD et les ajouter au groupe
$Users = @("Etudiant1","Etudiant2")
foreach ($user in $Users) {
    New-ADUser -Name $user -SamAccountName $user -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) -Enabled $true
    Add-ADGroupMember -Identity $GroupName -Members $user
}

# Partager le dossier avec le groupe
New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName
```

<img width="1007" height="591" alt="Capture d’écran 2026-11-09 à 14 14 45" src="https://github.com/user-attachments/assets/a188d7bd-1f60-4fb0-bdfb-f7b3755da1a7" />


### Préparation : l'OU `Students`

Le script suivant lie la GPO à `OU=Students,...`. Cette OU n'existait pas encore : je l'ai créée, puis j'y ai déplacé le groupe et les deux utilisateurs.

```powershell
New-ADOrganizationalUnit -Name "Students" -Path "DC=DC300159672,DC=local"
Get-ADUser -Filter 'SamAccountName -like "Etudiant*"' | Move-ADObject -TargetPath "OU=Students,DC=$netbiosName,DC=local"
Get-ADGroup Students | Move-ADObject -TargetPath "OU=Students,DC=$netbiosName,DC=local"
```

---

## 3. GPO de mappage du lecteur – `utilisateurs2.ps1`

J'ai créé la GPO `MapSharedFolder` avec `utilisateurs2.ps1` et je l'ai liée à l'OU `Students`. Le script écrit aussi un fichier `.bat` avec la commande `net use` dans `C:\Scripts`. `Get-GPInheritance` confirme que la GPO est bien liée à l'OU.

```powershell
# Nom de la GPO
$GPOName = "MapSharedFolder"

# Créer la GPO
New-GPO -Name $GPOName

# Lier la GPO à une OU spécifique (ex: "Students")
$OU = "OU=Students,DC=$netbiosName,DC=local"
New-GPLink -Name $GPOName -Target $OU

# Créer une preference pour mapper le lecteur réseau
$DriveLetter = "Z:"
$SharePath = "\\$serverName\SharedResources"

# Créer un script logon
$ScriptFolder = "C:\Scripts"
$ScriptPath = "$ScriptFolder\MapDrive-$DriveLetter.bat"
if (-not (Test-Path $ScriptFolder)) { New-Item -ItemType Directory -Path $ScriptFolder }

$scriptContent = "net use $DriveLetter $SharePath /persistent:no"
Set-Content -Path $ScriptPath -Value $scriptContent

# Lier le script logon à la GPO
Set-GPRegistryValue -Name $GPOName `
                    -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" `
                    -ValueName "LogonScript" `
                    -Type String `
                    -Value $ScriptPath
```

<img width="1512" height="982" alt="Capture d’écran 2026-11-10 à 11 42 42" src="https://github.com/user-attachments/assets/951305fd-ed7a-4f47-90ab-551347fd230a" />


**Écart par rapport au lab :** `$SharePath` utilise `$serverName` (`\\SRV300159672\...`) et non `$netbiosName`, car ce dernier est le nom du **domaine**, pas celui du serveur qui héberge le partage.

---

## 4. Activer le RDP – `utilisateurs3.ps1`

J'ai autorisé les connexions Bureau à distance sur le serveur, activé les règles du pare-feu *Remote Desktop*, puis donné le droit de connexion RDP au groupe `Students`. Cette dernière étape a demandé une solution de contournement (voir plus bas).

```powershell
# Autoriser RDP sur la machine
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0

# Autoriser le firewall RDP
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

# Le groupe Students peut se connecter en RDP
Add-ADGroupMember -Identity "Remote Desktop Users" -Members "Students"
```

### Droit « Allow log on through Remote Desktop Services » (`SeRemoteInteractiveLogonRight`)

Le lab utilise `secedit /export` puis `/import`. Sur mon serveur, `secedit /export /cfg C:\secpol.cfg` échoue :

```
The system cannot find the file specified.
The task has completed with an error.
```

L'éditeur de GPO (GPMC) échouait aussi à enregistrer ce droit (*Failed to save ...\SecEdit\GptTmpl.inf*). J'ai donc ajouté la ligne **directement dans le fichier `GptTmpl.inf` de la GPO** `Default Domain Controllers Policy` (sauvegarde faite avant), puis monté la version de la GPO pour qu'elle soit appliquée :

```powershell
$f = "C:\Windows\SYSVOL\domain\Policies\{6AC1786C-016F-11D2-945F-00C04FB984F9}\MACHINE\Microsoft\Windows NT\SecEdit\GptTmpl.inf"
Copy-Item $f C:\GptTmpl.inf.bak
$sid = (Get-ADGroup Students).SID.Value
$lines = Get-Content $f
$i = [array]::IndexOf($lines, "[Privilege Rights]")
$new = "SeRemoteInteractiveLogonRight = *S-1-5-32-544,*$sid"
$lines = $lines[0..$i] + $new + $lines[($i+1)..($lines.Count-1)]
Set-Content -Path $f -Value $lines -Encoding Unicode
Select-String -Path $f -Pattern "SeRemoteInteractiveLogonRight"

$ini = "C:\Windows\SYSVOL\domain\Policies\{6AC1786C-016F-11D2-945F-00C04FB984F9}\GPT.INI"
(Get-Content $ini) -replace "Version=1","Version=2" | Set-Content $ini
Set-ADObject -Identity "CN={6AC1786C-016F-11D2-945F-00C04FB984F9},CN=Policies,CN=System,DC=DC300159672,DC=local" -Replace @{versionNumber=2}
gpupdate
```

Le droit est donné à `Administrators` (`S-1-5-32-544`) **et** à `Students`, sinon les administrateurs perdraient l'accès RDP sur un contrôleur de domaine.

### Vérification

```powershell
(Get-ItemProperty "HKLM:\System\CurrentControlSet\Control\Terminal Server").fDenyTSConnections
Get-NetFirewallRule -DisplayGroup "Remote Desktop" | Select-Object DisplayName, Enabled | Format-Table -AutoSize
Get-ADGroupMember "Remote Desktop Users" | Select-Object Name | Format-Table -AutoSize
```

<img width="1053" height="658" alt="Capture d’écran 2026-11-10 à 15 10 28" src="https://github.com/user-attachments/assets/ca4d054c-183c-480f-b438-47306871ba02" />


`fDenyTSConnections` = `0`, les trois règles *Remote Desktop* sont activées, et `Students` est membre de *Remote Desktop Users*.

---

## 5. Test

Pour terminer, je me suis connecté en RDP avec `Etudiant1`, un membre du groupe `Students`, et j'ai vérifié le compte et le lecteur réseau. Connexion RDP (Windows App sur Mac) vers `10.7.237.225` avec `DC300159672\Etudiant1`, un membre de `Students`.

```powershell
whoami
net use
```

<img width="1023" height="652" alt="Capture d’écran 2026-11-17 à 11 38 32" src="https://github.com/user-attachments/assets/44317593-1f38-4f8b-8c96-d7d04c870914" />


L'Explorateur de fichiers confirme aussi que le lecteur réseau `SharedResources (Z:)` est bien monté pour `Etudiant1` :

<img width="990" height="641" alt="Capture d’écran 2026-11-17 à 11 39 27" src="https://github.com/user-attachments/assets/c6476d01-7751-4e84-b40b-6a239174d3c6" />


| Vérification du lab | Résultat |
|---|---|
| Un membre de Students peut se connecter en RDP | ✅ `dc300159672\etudiant1` |
| Le lecteur `Z:` est mappé automatiquement | ✅ `Z:` → `\\SRV300159672\SharedResources` (statut OK) |
| Un utilisateur hors du groupe n'a pas accès | ⚪ non testé (aucun compte hors Students créé) |

### Complément pour `Z:`

Avec la méthode du lab seule (`LogonScript` dans `Policies\System`), `net use` restait vide pour Etudiant1 : cette valeur ne déclenche pas de script à l'ouverture de session. J'ai ajouté au même GPO une valeur `Run` qui exécute la commande à l'ouverture de session :

```powershell
Set-GPRegistryValue -Name "MapSharedFolder" -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" -ValueName "MapZ" -Type String -Value "net use Z: \\SRV300159672\SharedResources /persistent:no"
```

Après `gpupdate`, déconnexion et reconnexion d'Etudiant1, `Z:` apparaît (capture 05).

---

## Récapitulatif des écarts par rapport au lab

| # | Écart | Raison |
|---|---|---|
| 1 | `$SharePath` avec `$serverName` | `$netbiosName` est le nom du domaine, pas celui du serveur |
| 2 | OU `Students` créée avant `utilisateurs2.ps1` | la GPO est liée à cette OU |
| 3 | Droit RDP écrit dans `GptTmpl.inf` au lieu de `secedit` | `secedit /export` échoue sur ce serveur (*cannot find the file specified*) |
| 4 | Valeur `Run` ajoutée pour `Z:` | `LogonScript` du lab ne lançait pas le script |

## Tableau récapitulatif

| Élément | Configuration | Vérification |
|---|---|---|
| Domaine | `DC300159672.local` | `bootstrap.ps1` |
| Serveur | `SRV300159672` (10.7.237.225) | `hostname` |
| Unité d'organisation | `Students` | créée avant `utilisateurs2.ps1` |
| Groupe AD | `Students` (global) | `utilisateurs1.ps1` |
| Utilisateurs | `Etudiant1` et `Etudiant2`, membres de `Students` | `utilisateurs1.ps1` |
| Dossier partagé | `C:\SharedResources`, partage `SharedResources` (contrôle total pour `Students`) | `utilisateurs1.ps1` |
| GPO | `MapSharedFolder`, liée à l'OU `Students` | `Get-GPInheritance` |
| Lecteur réseau | `Z:` vers `\\SRV300159672\SharedResources` | `net use` (statut OK) |
| Bureau à distance | Activé (`fDenyTSConnections` = 0), règles du pare-feu activées | registre, `Get-NetFirewallRule` |
| Groupe `Remote Desktop Users` | `Students` ajouté | `Get-ADGroupMember` |
| Droit RDP sur le DC | `Students` et `Administrators` dans `Default Domain Controllers Policy` | `GptTmpl.inf`, version de la GPO |
| Test RDP | Connexion réussie avec `DC300159672\Etudiant1` | `whoami` |
| Test lecteur `Z:` | `SharedResources (Z:)` visible dans l'Explorateur | capture 06 |

## Conclusion

Ce labo m'a permis de créer avec PowerShell une OU, un groupe de sécurité, deux comptes utilisateurs, un dossier partagé SMB, une GPO de mappage de lecteur et l'accès Bureau à distance.

Le test final avec `Etudiant1` montre que l'ensemble fonctionne : la connexion RDP réussit, `whoami` confirme le compte et le lecteur `Z:` est relié au partage `\\SRV300159672\SharedResources`.

J'ai aussi appris trois choses :
- Un contrôleur de domaine se comporte différemment d'un serveur membre : ajouter `Students` à `Remote Desktop Users` ne suffit pas, il faut aussi le droit « Allow log on through Remote Desktop Services » dans `Default Domain Controllers Policy`.
- Dans le chemin du partage, il faut le nom du **serveur** (`SRV300159672`) et non celui du domaine.
- Une valeur `LogonScript` dans une GPO ne lance pas un script à elle seule : j'ai dû ajouter une valeur `Run` pour que `Z:` soit monté.

## Fichiers du dossier

- `README.md`
- `images/` : `01-bootstrap.png`, `02-utilisateurs1.png`, `03-utilisateurs2.png`, `04-rdp.png`, `05-test.png`, `06-explorateur.png`
- `utilisateurs1.ps1`, `utilisateurs2.ps1`, `utilisateurs3.ps1` (le contenu est reproduit dans ce README)
