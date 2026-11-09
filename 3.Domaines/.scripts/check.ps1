# --------------------------------------
# Validation INF1084 - Services Windows et AD DS
# --------------------------------------

# Forcer UTF-8 dans tout le script
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$PSDefaultParameterValues['Set-Content:Encoding'] = 'utf8'

# Autoriser les connexions WinRM
Set-Item WSMan:\localhost\Client\TrustedHosts -Value "10.7.236.*" -Force

#!/usr/bin/env pwsh
# --------------------------------------
# Dynamic participation script
# --------------------------------------


# Pass parameter to students.ps1
. ../.scripts/students.ps1

# --------------------------------------
# VALIDATION
# --------------------------------------

# Importer les fonctions
. ../.scripts/functions.ps1
. ../.scripts/commons.ps1

if (-not $SERVERS) {
    Write-Host "La variable `$SERVERS n'a pas été trouvée dans students.ps1" -ForegroundColor Red
    exit
}

# Compte administrateur
$User = "Administrator"

$plain = "Boreal@2026"
$Password = ConvertTo-SecureString $plain -AsPlainText -Force

# --------------------------------------
# README
# --------------------------------------

$timestamp = Get-Date -Format "dd-MM-yyyy HH:mm"

$md = @()

$md += "# Precision au $timestamp"
$md += ""
$md += "| Table des matieres | Description |"
$md += "|--------------------|-------------|"
$md += "| :a: [Presence](#a-presence) | La VM est accessible |"
$md += "| :b: [Precision](#b-precision) | Verification des services AD |"
$md += ""
$md += "## Legende"
$md += ""
$md += "| Symbole | Signification |"
$md += "|----------|-------------|"
$md += "| :heavy_check_mark: | Service actif |"
$md += "| :x: | Service arrêté ou absent |"
$md += "| :no_entry: | Connexion WinRM impossible |"
$md += "| :tada: | Tous les services sont actifs |"
$md += "| :warning: | Services manquants ou arrêtés |"
$md += ""
$md += "## :b: Precision"
$md += ""
$md += "| # | Boreal :id: | VM | NTDS | ADWS | DFSR | KDC | Netlogon | IsmServ | Résultat |"
$md += "|---|-------------|----|------|------|------|-----|----------|---------|----------|"

# --------------------------------------
# Validation
# --------------------------------------

$i = 0
$s = 0
$counter = 1

foreach ($VM in $SERVERS) {

    $parts = $STUDENTS[$i] -split '\|'
    
    $StudentID = $parts[0]
    $GitHubID  = $parts[1]
    $AvatarID  = $parts[2]

    $paths  = Get-StudentPaths -StudentID $StudentID
    $checks = Get-StudentChecks -Paths $paths
    $url    = Get-GitHubAvatarLink -GitHubID $GitHubID -AvatarID $AvatarID

    $id = $STUDENTS[$i]

    $FILE = "$id/README.md"

    Write-Host "Connexion à $VM ..." -ForegroundColor Cyan

    try {

        $Credential = New-Object PSCredential ($User, $Password)

        $Session = New-PSSession `
            -ComputerName $VM `
            -Credential $Credential

        $Services = Invoke-Command -Session $Session -ScriptBlock {

            $List = @(
                "NTDS",
                "ADWS",
                "DFSR",
                "KDC",
                "Netlogon",
                "IsmServ"
            )

            $Results = @{}

            foreach ($Service in $List) {

                $Obj = Get-Service `
                    -Name $Service `
                    -ErrorAction SilentlyContinue

                if ($null -eq $Obj) {
                    $Results[$Service] = "Missing"
                }
                else {
                    $Results[$Service] = $Obj.Status
                }
            }

            return $Results
        }

        $NTDS = if ($Services["NTDS"] -eq "Running") {
            ":heavy_check_mark:"
        }
        else {
            ":x:"
        }

        $ADWS = if ($Services["ADWS"] -eq "Running") {
            ":heavy_check_mark:"
        }
        else {
            ":x:"
        }

        $DFSR = if ($Services["DFSR"] -eq "Running") {
            ":heavy_check_mark:"
        }
        else {
            ":x:"
        }

        $KDC = if ($Services["KDC"] -eq "Running") {
            ":heavy_check_mark:"
        }
        else {
            ":x:"
        }

        $Netlogon = if ($Services["Netlogon"] -eq "Running") {
            ":heavy_check_mark:"
        }
        else {
            ":x:"
        }

        $IsmServ = if ($Services["IsmServ"] -eq "Running") {
            ":heavy_check_mark:"
        }
        else {
            ":x:"
        }

        $RunningCount = @(
            $Services["NTDS"],
            $Services["ADWS"],
            $Services["DFSR"],
            $Services["KDC"],
            $Services["Netlogon"],
            $Services["IsmServ"]
        ) | Where-Object { $_ -eq "Running" }

        if ($RunningCount.Count -eq 6) {

            $Result = ":tada:"
            $s++
        }
        else {

            $Result = ":warning:"
        }

        $md += "| $counter | [$id](../$FILE) $URL | $VM | $NTDS | $ADWS | $DFSR | $KDC | $Netlogon | $IsmServ | $Result |"

        Remove-PSSession $Session
    }
    catch {

        Write-Host "Échec de connexion à $VM : $($_.Exception.Message)" -ForegroundColor Red

        $md += "| $counter | [$id](../$FILE) $URL | $VM | :no_entry: | :no_entry: | :no_entry: | :no_entry: | :no_entry: | :no_entry: | :no_entry: |"
    }

    $i++
    $counter++

    $COUNT = "\$\frac{$s}{$i}$"
    $STATS = [math]::Round(($s * 100) / $i, 2)
    $SUM = "\$\displaystyle\sum_{i=1}^{$i} s_i$"
}

$md += ""
$md += "| :abacus: | $COUNT = $STATS% | | | | | | | | $SUM = $s |"

# --------------------------------------
# Export
# --------------------------------------

$md | Set-Content `
    -Path ".scripts/Check.md" `
    -Encoding UTF8

Write-Host "README.md généré avec succès !" -ForegroundColor Green
