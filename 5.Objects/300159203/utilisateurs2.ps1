Import-Module GroupPolicy
$GPOName = "MapSharedFolder"

if (-not (Get-GPO -Name $GPOName -ErrorAction SilentlyContinue)) {
    New-GPO -Name $GPOName
}

$netbiosName = (Get-ADDomain).NetBIOSName
$OU = "OU=Students,DC=$netbiosName,DC=local"

try {
    New-GPLink -Name $GPOName -Target $OU -ErrorAction Stop
} catch {
    Write-Host "Lien GPO déjà existant ou OU cible à vérifier."
}

$ScriptFolder = "C:\Scripts"
$ScriptPath = "$ScriptFolder\MapDrive-Z.bat"
if (-not (Test-Path $ScriptFolder)) { New-Item -ItemType Directory -Path $ScriptFolder }

$scriptContent = "net use Z: \\$netbiosName\SharedResources /persistent:no"
Set-Content -Path $ScriptPath -Value $scriptContent

Set-GPRegistryValue -Name $GPOName 
                    -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" 
                    -ValueName "LogonScript" 
                    -Type String 
                    -Value $ScriptPath
