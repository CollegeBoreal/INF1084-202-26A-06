# --------------------------------------
# Script pour tester les partages SMB étudiants + RDP GUI
# --------------------------------------

# Forcer UTF-8 pour les accents
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$PSDefaultParameterValues['Set-Content:Encoding'] = 'utf8'

# Charger la liste des étudiants et serveurs depuis students.ps1
. ../.scripts/students.ps1

# Charger la fonction si ce n'est pas déjà fait
. .\.scripts\Test-RDPSession.ps1

if (-not $SERVERS -or -not $ETUDIANTS) {
    Write-Host "Les variables `$SERVERS ou `$ETUDIANTS n'ont pas été trouvées dans students.ps1" -ForegroundColor Red
    exit
}

# Mot de passe commun pour les étudiants (adapter si nécessaire)
$plainPassword = "Pass123!"
$Password = ConvertTo-SecureString $plainPassword -AsPlainText -Force
$timestamp = Get-Date -Format "dd-MM-yyyy HH:mm"

# Préparer le Markdown
$md = @()
$md += "# Precision au $timestamp"
$md += ""
$md += "| Table des matieres            | Description                                             |"
$md += "|-------------------------------|---------------------------------------------------------|"
$md += "| :a: [Presence](#a-presence)   | L'etudiant.e a fait son travail    :heavy_check_mark:   |"
$md += "| :b: [Precision](#b-precision) | L'etudiant.e a reussi son travail  :tada:               |"
$md += ""
$md += ":bulb: Le mot de passe de ***Etudiant1*** est ***$plainPassword***"
$md += ""
$md += "## Legende"
$md += ""
$md += "| Signe              | Signification                    |"
$md += "|--------------------|----------------------------------|"
$md += "| :heavy_check_mark: | Acces OK                          |"
$md += "| :x:                | Service desactive / ressource off |"
$md += "| :no_entry:         | Acces refuse / host down          |"
$md += "| :warning:          | Mot de passe a changer            |"
$md += ""
$md += "## :b: Precision"
$md += ""
$md += "| :hash: | Boreal :id: | :roll_of_paper: Partage SMB | :toilet: Statut SMB  | :hiking_boot: netbios | :skateboard: RDP GUI |"
$md += "|--------|-------------|-----------------------------|----------------------|-----------------------|----------------------|"

# ------------------------------
# Boucle sur chaque étudiant
# ------------------------------
for ($i = 0; $i -lt $ETUDIANTS.Count; $i++) {

    $URL = "[<image src='https://avatars0.githubusercontent.com/u/$($AVATARS[$i])?s=460&v=4' width=20 height=20></image>](https://github.com/$($IDS[$i]))"    
    $id = $ETUDIANTS[$i]
    $FILE = "$id/README.md"
    $vm = $SERVERS[$i]

    Write-Host "Test pour $id sur $vm..." -ForegroundColor Cyan

    # ------------------------------
    # Test RDP GUI avec Test-RDPSession
    # ------------------------------
    $rdpIcon = ":x:"   # valeur par défaut
    try {
        if (Test-RDPSession -ComputerName $vm -Username "$($NETBIOS[$i])\Etudiant1" -Password $plainPassword) {
            $rdpIcon = ":heavy_check_mark:"
        } else {
            $rdpIcon = ":x:"
        }
    }
    catch {
        $rdpIcon = ":no_entry:"
        Write-Host "Erreur RDP pour $id@$vm" -ForegroundColor Red
    }

    # ------------------------------
    # Test SMB
    # ------------------------------
    $sharePath = "\\$vm\SharedResources"
    $CredsSMB = New-Object System.Management.Automation.PSCredential ("Etudiant1", $Password)
    $driveName = "S"
    $statusIcon = ":x:"
    try {
        New-PSDrive -Name $driveName -PSProvider FileSystem -Root $sharePath -Credential $CredsSMB -ErrorAction Stop | Out-Null
        if (Test-Path "$($driveName):\") { $statusIcon = ":heavy_check_mark:" }
        Remove-PSDrive -Name $driveName -ErrorAction SilentlyContinue
    }
    catch {
        if ($_.Exception.Message -match "password is not correct|incorrect") { $statusIcon = ":no_entry:" }
        elseif ($_.Exception.Message -match "must be changed") { $statusIcon = ":warning:" }
        elseif ($_.Exception.Message -match "cannot be found") { $statusIcon = ":x:" }
        else { $statusIcon = ":no_entry:" }
    }

    # ------------------------------
    # Ligne Markdown
    # ------------------------------
    $md += "| $i | [$id](../$FILE) $URL | \\\\$vm\\SharedResources | $statusIcon | $($NETBIOS[$i]) | $rdpIcon |"
}

# ------------------------------
# Exporter le Markdown dans Check.md
# ------------------------------
$md | Set-Content -Path ".scripts/Check.md" -Encoding UTF8
Write-Host "Check.md généré avec succès !" -ForegroundColor Green
