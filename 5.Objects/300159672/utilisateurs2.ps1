
# Nom de la GPO
$GPOName = "MapSharedFolder"

# Creer la GPO
New-GPO -Name $GPOName

# Lier la GPO a une OU specifique (ex: "Students")
$OU = "OU=Students,DC=$netbiosName,DC=local"
New-GPLink -Name $GPOName -Target $OU

# Creer une preference pour mapper le lecteur reseau
$DriveLetter = "Z:"
$SharePath = "\\$serverName\SharedResources"

# Creer un script logon
$ScriptFolder = "C:\Scripts"
$ScriptPath = "$ScriptFolder\MapDrive-$DriveLetter.bat"
if (-not (Test-Path $ScriptFolder)) { New-Item -ItemType Directory -Path $ScriptFolder }

$scriptContent = "net use $DriveLetter $SharePath /persistent:no"
Set-Content -Path $ScriptPath -Value $scriptContent

# Lier le script logon a la GPO
Set-GPRegistryValue -Name $GPOName `
                    -Key "HKCU\Software\Microsoft\Windows\Curren
