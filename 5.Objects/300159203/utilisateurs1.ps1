$SharedFolder = "C:\SharedResources"
if (-not (Test-Path $SharedFolder)) { New-Item -Path $SharedFolder -ItemType Directory -Force }

$GroupName = "Students"
if (-not (Get-ADGroup -Filter "Name -eq '$GroupName'")) {
    New-ADGroup -Name $GroupName -GroupScope Global -Description "Users allowed RDP and shared folder access"
}

$Users = @("Etudiant1", "Etudiant2")
foreach ($user in $Users) {
    if (-not (Get-ADUser -Filter "SamAccountName -eq '$user'")) {
        New-ADUser -Name $user -SamAccountName $user -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) -Enabled $true
    }
    Add-ADGroupMember -Identity $GroupName -Members $user -ErrorAction SilentlyContinue
}

if (-not (Get-SmbShare -Name "SharedResources" -ErrorAction SilentlyContinue)) {
    New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName
}
