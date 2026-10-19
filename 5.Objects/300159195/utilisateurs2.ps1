# Nom de la GPO
$GPOName = "MapSharedFolder"

# Creer la GPO
New-GPO -Name $GPOName

# Lier la GPO a une OU specifique
$OU = "OU=Students,DC=DC300159195,DC=local"
New-GPLink -Name $GPOName -Target $OU

# Informations du lecteur reseau
$DriveLetter = "Z:"
$SharePath = "\\SRV300159195\SharedResources"

# Creer un script logon
$ScriptFolder = "C:\Scripts"
$ScriptPath = "$ScriptFolder\MapDrive-Z.bat"
if (-not (Test-Path $ScriptFolder)) {
    New-Item -ItemType Directory -Path $ScriptFolder
}

$ScriptContent = "net use $DriveLetter $SharePath /persistent:no"
Set-Content -Path $ScriptPath -Value $ScriptContent

# Lier le script logon a la GPO
Set-GPRegistryValue -Name $GPOName `
    -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" `
    -ValueName "LogonScript" `
    -Type String `
    -Value $ScriptPath
