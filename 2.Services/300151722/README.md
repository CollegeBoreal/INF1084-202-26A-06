# Laboratoire 2 - Services

**Nom : Islam Oustani**  
**ID : 300151722**

## Objectif

Créer un utilisateur Active Directory avec mon ID étudiant et lui donner les droits d’administration sur Windows Server 2022 en utilisant PowerShell.

## Commandes PowerShell utilisées

```powershell
$domain = Get-ADDomain

$password = Read-Host "Entrez le mot de passe pour 300151722" -AsSecureString

New-ADUser `
    -Name "300151722" `
    -SamAccountName "300151722" `
    -UserPrincipalName "300151722@$($domain.DNSRoot)" `
    -AccountPassword $password `
    -Enabled $true

$domainAdminSID = "$($domain.DomainSID)-512"

Add-ADGroupMember `
    -Identity $domainAdminSID `
    -Members "300151722"

Get-ADUser `
    -Identity "300151722" `
    -Properties Enabled,MemberOf

Get-ADGroupMember `
    -Identity $domainAdminSID |
    Where-Object {$_.SamAccountName -eq "300151722"}
