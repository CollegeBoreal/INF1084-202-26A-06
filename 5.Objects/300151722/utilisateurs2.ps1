# Nom de la GPO
$GPOName = "MapSharedFolder"

# Créer la GPO
New-GPO -Name $GPOName

# OU Students
$OU = "OU=Students,DC=DC300151722,DC=local"

# Lier la GPO à l'OU Students
New-GPLink -Name $GPOName -Target $OU

# Lecteur réseau
$DriveLetter = "Z:"
$SharePath = "\\SRV300151722\SharedResources"

# Créer le dossier de scripts
$ScriptFolder = "C:\Scripts"

if (-not (Test-Path $ScriptFolder)) {
    New-Item -ItemType Directory -Path $ScriptFolder
}

# Créer le script batch de connexion
$ScriptPath = "$ScriptFolder\MapDrive-Z.bat"

$scriptContent = "net use Z: $SharePath /persistent:no"

Set-Content -Path $ScriptPath -Value $scriptContent