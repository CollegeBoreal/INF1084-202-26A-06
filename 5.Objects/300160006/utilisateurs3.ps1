

# utilisateurs3.ps1
# Activation et verification du Bureau a distance (RDP)

$GroupName = "DC300160006\Students"

# 1. Activer les connexions RDP
Set-ItemProperty `
    -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" `
    -Name "fDenyTSConnections" `
    -Value 0

Write-Host "Connexions RDP activees."

# 2. Activer les regles du pare-feu
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
Write-Host "Regles du pare-feu RDP activees."

# 3. Verifier le groupe local avec net localgroup
$GroupOutput = net localgroup "Remote Desktop Users"

if ($LASTEXITCODE -ne 0) {
    Write-Error "Impossible de verifier le groupe Remote Desktop Users."
    exit 1
}

if ($GroupOutput -match "(?m)^\s*Students\s*$") {
    Write-Host "Students est deja membre de Remote Desktop Users."
} else {
    net localgroup "Remote Desktop Users" "$GroupName" /add

    if ($LASTEXITCODE -eq 0) {
        Write-Host "Students ajoute au groupe Remote Desktop Users."
    } else {
        Write-Error "Echec de l'ajout du groupe Students."
        exit 1
    }
}

# 4. Verifier le service RDP
$Service = Get-Service -Name "TermService"
Write-Host "Etat du service TermService : $($Service.Status)"

# 5. Verifier le Registre
$RDPValue = Get-ItemPropertyValue `
    -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" `
    -Name "fDenyTSConnections"

Write-Host "fDenyTSConnections = $RDPValue"
Write-Host "Verification RDP terminee."


Write-Host "fDenyTSConnections = $RDPValue"
Write-Host "Verification RDP terminee."
