# --------------------------------------
# Script pour accéder aux AD DS et vérifier les répertoires des étudiants
# --------------------------------------

# Forcer UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$PSDefaultParameterValues['Set-Content:Encoding'] = 'utf8'

# Autoriser toutes les IP pour WinRM
Set-Item WSMan:\localhost\Client\TrustedHosts -Value "10.7.236.*" -Force

# Charger la liste des VMs depuis students.ps1
. ../.scripts/students.ps1

if (-not $SERVERS) {
    Write-Host "La variable `$SERVERS n'a pas été trouvée dans students.ps1" -ForegroundColor Red
    exit
}

# Identifiants administrateur
$User = "Administrator"
$plain = 'Infra@2024'
$Password = ConvertTo-SecureString $plain -AsPlainText -Force

# Préparer le Markdown
$timestamp = Get-Date -Format "dd-MM-yyyy HH:mm"
$md = @()
$md += "# Precision au $timestamp"
$md += ""
$md += "| Table des matieres            | Description                                             |"
$md += "|-------------------------------|---------------------------------------------------------|"
$md += "| :a: [Presence](#a-presence)   | L'etudiant.e a fait son travail    :heavy_check_mark:   |"
$md += "| :b: [Precision](#b-precision) | L'etudiant.e a reussi son travail  :tada:               |"
$md += ""
$md += "## Legende"
$md += ""
$md += "| Signe              | Signification                 |"
$md += "|--------------------|-------------------------------|"
$md += "| :heavy_check_mark: | DFSR et C:\\Logs OK           |"
$md += "| :x:                | DFSR ou repertoire absent     |"
$md += "| :no_entry:         | Acces refuse                  |"
$md += ""
$md += "## :b: Precision"
$md += ""
$md += "| :hash: | Boreal :id: | :slot_machine: VM   | :file_folder: **C:\\Logs**   |"
$md += "|--------|-------------|---------------------|------------------------------|"

# Boucle sur chaque VM
$i = 0
$s = 0
$counter = 1

foreach ($VM in $SERVERS) {

    $URL = "[<image src='https://avatars0.githubusercontent.com/u/$($AVATARS[$i])?s=460&v=4' width=20 height=20></image>](https://github.com/$($IDS[$i]))"
    $id = $ETUDIANTS[$i]
    $FILE = "$id/README.md"
    $LOG = "$id/ADLogs.csv"   # <-- NEW : fichier local

    Write-Host "Connexion à $VM ..." -ForegroundColor Cyan

    try {
        $Session = New-PSSession -ComputerName $VM -Credential (New-Object PSCredential ($User, $Password))

        # 🔁 Vérifier le service DFSR
        $ADStatus = Invoke-Command -Session $Session -ScriptBlock {
            $svc = Get-Service -Name DFSR -ErrorAction SilentlyContinue
            if ($svc) { $svc.Status } else { -1 }
        }

        # 🔁 New logic: skip C:\Logs check if ADLogs.csv exists locally
        $SkipDirCheck = Test-Path $LOG

        if ($SkipDirCheck) {
            $dirExists = $true
        }
        else {
            $dirExists = Invoke-Command -Session $Session -ScriptBlock {
                Test-Path "C:\Logs"
            }
        }

        # Déterminer l'icône
        if ($ADStatus -eq 4 -and $dirExists) {
            $statusIcon = ":heavy_check_mark:"
            $s++
        }
        elseif ($ADStatus -eq 4 -or $dirExists) {
            $statusIcon = ":x:"
        }
        else {
            $statusIcon = ":x:"
        }

        # Ajouter la ligne Markdown
        $md += "| $counter | [$id](../$FILE) $URL | $VM | $statusIcon |"

        Remove-PSSession $Session
    }
    catch {
        Write-Host "Échec de connexion à $VM : $($_.Exception.Message)" -ForegroundColor Red
        $md += "| $counter | [$id](../$FILE) $URL | $VM | :no_entry: |"
    }

    $i++
    $counter++
    $COUNT = "\$\\frac{$s}{$i}$"
    $STATS = [math]::Round(($s * 100) / $i, 2)
    $SUM = "\$\displaystyle\sum_{i=1}^{$i} s_i$"
}

$md += "| :abacus: | $COUNT = $STATS% | | $SUM = $s |"

# Exporter le README.md
$md | Set-Content -Path ".scripts/Check.md" -Encoding UTF8
Write-Host "README.md généré avec succès !" -ForegroundColor Green
