
# utilisateurs2.ps1
# Verification et configuration de la GPO MapSharedFolder

Import-Module GroupPolicy

$GPOName = "MapSharedFolder"
$OU = "OU=Students,DC=DC300160006,DC=local"
$SharePath = "\\SRV300160006\SharedResources"
$DriveLetter = "Z:"

# 1. Verifier si la GPO existe
$GPO = Get-GPO -Name $GPOName -ErrorAction SilentlyContinue

if (-not $GPO) {
    $GPO = New-GPO -Name $GPOName
    Write-Host "GPO creee : $GPOName"
} else {
    Write-Host "GPO existante reutilisee : $GPOName"
}

# 2. Verifier si la GPO est liee a l'OU Students
$Inheritance = Get-GPInheritance -Target $OU
$LinkExists = $Inheritance.GpoLinks |
    Where-Object { $_.DisplayName -eq $GPOName }

if (-not $LinkExists) {
    New-GPLink -Name $GPOName -Target $OU
    Write-Host "GPO liee a l'OU Students."
} else {
    Write-Host "La GPO est deja liee a l'OU Students."
}

# 3. Verifier le mappage du lecteur Z dans le rapport GPO
$ReportPath = Join-Path $env:TEMP "MapSharedFolder.xml"
Get-GPOReport -Name $GPOName -ReportType Xml -Path $ReportPath

$Report = Get-Content -Path $ReportPath -Raw

if ($Report -match 'name="Z:"' -and
    $Report -match [regex]::Escape($SharePath)) {
    Write-Host "Le lecteur Z: est deja configure vers $SharePath."
} else {
    Write-Warning "Le mappage Z: n'a pas ete trouve dans le rapport."
    Write-Warning "Aucune modification automatique du mappage n'a ete effectuee."
}

Write-Host "Verification de la GPO terminee."
