
# utilisateurs1.ps1
# Creation du dossier partage, verification du groupe et des utilisateurs,
# puis configuration du partage SMB.

Import-Module ActiveDirectory

$SharedFolder = "C:\SharedResources"
$GroupName = "Students"
$ShareName = "SharedResources"
$DomainNetBIOS = "DC300160006"

# 1. Creer le dossier s'il n'existe pas
if (-not (Test-Path $SharedFolder)) {
    New-Item -Path $SharedFolder -ItemType Directory | Out-Null
}
Write-Host "Dossier partage verifie : $SharedFolder"

# 2. Verifier le groupe AD sans le recreer
$Group = Get-ADGroup -Identity $GroupName -ErrorAction SilentlyContinue
if (-not $Group) {
    New-ADGroup -Name $GroupName `
        -GroupScope Global `
        -GroupCategory Security `
        -Path "OU=Students,DC=DC300160006,DC=local" `
        -Description "Users allowed RDP and shared folder access"
    Write-Host "Groupe Students cree."
} else {
    Write-Host "Le groupe Students existe deja."
}

# 3. Verifier les utilisateurs et leur appartenance au groupe
foreach ($UserName in @("Etudiant1", "Etudiant2")) {
    $User = Get-ADUser -Identity $UserName -ErrorAction SilentlyContinue

    if (-not $User) {
        Write-Warning "$UserName n'existe pas. Aucun mot de passe n'a ete defini."
        continue
    }

    $Membership = Get-ADGroupMember -Identity $GroupName |
        Where-Object { $_.SamAccountName -eq $UserName }

    if (-not $Membership) {
        Add-ADGroupMember -Identity $GroupName -Members $UserName
        Write-Host "$UserName ajoute au groupe Students."
    } else {
        Write-Host "$UserName est deja membre de Students."
    }
}

# 4. Creer le partage SMB seulement s'il n'existe pas
$Share = Get-SmbShare -Name $ShareName -ErrorAction SilentlyContinue

if (-not $Share) {
    New-SmbShare -Name $ShareName `
        -Path $SharedFolder `
        -FullAccess "$DomainNetBIOS\$GroupName"
    Write-Host "Partage SMB cree."
} else {
    Write-Host "Le partage SMB existe deja."
}

# 5. Verifier les droits SMB du groupe Students
$Access = Get-SmbShareAccess -Name $ShareName
if (-not ($Access | Where-Object {
    $_.AccountName -eq "$DomainNetBIOS\$GroupName" -and
    $_.AccessControlType -eq "Allow" -and
    $_.AccessRight -eq "Full"
})) {
    Grant-SmbShareAccess -Name $ShareName `
        -AccountName "$DomainNetBIOS\$GroupName" `
        -AccessRight Full `
        -Force
    Write-Host "Droits SMB accordes au groupe Students."
} else {
    Write-Host "Les droits SMB du groupe Students sont deja configures."
}

# 6. Configurer les permissions NTFS Modify sans retirer les autres droits
icacls $SharedFolder /grant "$DomainNetBIOS\$GroupName`:(OI)(CI)M"

Write-Host "Verification terminee."
