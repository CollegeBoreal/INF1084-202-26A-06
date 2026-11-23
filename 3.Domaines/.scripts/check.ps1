# --------------------------------------
# Validation INF1084 - Services Windows et AD DS
# --------------------------------------

# Forcer UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$PSDefaultParameterValues['Set-Content:Encoding'] = 'utf8'

# --------------------------------------
# Chargement des étudiants
# --------------------------------------

. ../.scripts/students.ps1

if (-not $SERVERS) {
    Write-Host "La variable `$SERVERS n'a pas été trouvée dans students.ps1" -ForegroundColor Red
    exit
}

# --------------------------------------
# Authentification
# --------------------------------------

$User = "Administrator"

$Password = ConvertTo-SecureString `
    "Infra@2024" `
    -AsPlainText `
    -Force

$Credential = New-Object System.Management.Automation.PSCredential (
    $User,
    $Password
)

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
$md += "| :x: | Service arrete ou absent |"
$md += "| :no_entry: | Connexion WinRM impossible |"
$md += "| :tada: | Tous les services sont actifs |"
$md += "| :warning: | Au moins un service est arrete |"
$md += ""
$md += "## :b: Precision"
$md += ""
$md += "| # | Boreal ID | VM | NTDS | ADWS | DFSR | KDC | Netlogon | IsmServ | Resultat |"
$md += "|---|-----------|----|------|------|------|-----|----------|---------|----------|"

# --------------------------------------
# Validation
# --------------------------------------

$SuccessCount = 0
$Counter = 1

for ($i = 0; $i -lt $STUDENTS.Count; $i++) {

    $parts = $STUDENTS[$i] -split '\|'

    $StudentID = $parts[0]
    $ServerIP  = $SERVERS[$i]

    Write-Host ""
    Write-Host "Connexion à $ServerIP ..." -ForegroundColor Cyan

    try {

        $Services = Invoke-Command `
            -ComputerName $ServerIP `
            -Credential $Credential `
            -ScriptBlock {

                Get-Service `
                    NTDS,
                    ADWS,
                    DFSR,
                    KDC,
                    Netlogon,
                    IsmServ `
                    -ErrorAction SilentlyContinue |
                Select-Object Name, Status
            }

        # --------------------------------------
        # Conversion des statuts
        #
        # 1 = Stopped
        # 4 = Running
        # --------------------------------------

        $NTDSStatus     = ($Services | Where-Object Name -eq "NTDS").Status
        $ADWSStatus     = ($Services | Where-Object Name -eq "ADWS").Status
        $DFSRStatus     = ($Services | Where-Object Name -eq "DFSR").Status
        $KDCStatus      = ($Services | Where-Object Name -eq "KDC").Status
        $NetlogonStatus = ($Services | Where-Object Name -eq "Netlogon").Status
        $IsmServStatus  = ($Services | Where-Object Name -eq "IsmServ").Status

        Write-Host "NTDS     : $NTDSStatus"
        Write-Host "ADWS     : $ADWSStatus"
        Write-Host "DFSR     : $DFSRStatus"
        Write-Host "KDC      : $KDCStatus"
        Write-Host "Netlogon : $NetlogonStatus"
        Write-Host "IsmServ  : $IsmServStatus"

        $NTDS     = if ($NTDSStatus     -eq 4) { ":heavy_check_mark:" } else { ":x:" }
        $ADWS     = if ($ADWSStatus     -eq 4) { ":heavy_check_mark:" } else { ":x:" }
        $DFSR     = if ($DFSRStatus     -eq 4) { ":heavy_check_mark:" } else { ":x:" }
        $KDC      = if ($KDCStatus      -eq 4) { ":heavy_check_mark:" } else { ":x:" }
        $Netlogon = if ($NetlogonStatus -eq 4) { ":heavy_check_mark:" } else { ":x:" }
        $IsmServ  = if ($IsmServStatus  -eq 4) { ":heavy_check_mark:" } else { ":x:" }

        $RunningCount = @(
            $NTDSStatus,
            $ADWSStatus,
            $DFSRStatus,
            $KDCStatus,
            $NetlogonStatus,
            $IsmServStatus
        ) | Where-Object { $_ -eq 4 }

        if ($RunningCount.Count -eq 6) {

            $Result = ":tada:"
            $SuccessCount++
        }
        else {

            $Result = ":warning:"
        }

        $md += "| $Counter | [$StudentID](../$StudentID/README.md) | $ServerIP | $NTDS | $ADWS | $DFSR | $KDC | $Netlogon | $IsmServ | $Result |"
    }
    catch {

        Write-Host "Échec de connexion à $ServerIP : $($_.Exception.Message)" -ForegroundColor Red

        $md += "| $Counter | [$StudentID](../$StudentID/README.md) | $ServerIP | :no_entry: | :no_entry: | :no_entry: | :no_entry: | :no_entry: | :no_entry: | :no_entry: |"
    }

    $Counter++
}

# --------------------------------------
# Résumé
# --------------------------------------

$TotalStudents = $Counter - 1

if ($TotalStudents -gt 0) {

    $Percentage = [math]::Round(
        ($SuccessCount * 100) / $TotalStudents,
        2
    )
}
else {

    $Percentage = 0
}

$md += ""
$md += "| :abacus: | `$\frac{$SuccessCount}{$TotalStudents}$ = $Percentage% | | | | | | | | `$\displaystyle\sum_{i=1}^{$TotalStudents} s_i$ = $SuccessCount |"

# --------------------------------------
# Export
# --------------------------------------

$OutputFile = ".scripts/Check.md"

$md | Out-File `
    -FilePath $OutputFile `
    -Encoding utf8

Write-Host ""
Write-Host "README.md généré avec succès !" -ForegroundColor Green
Write-Host "$SuccessCount / $TotalStudents étudiants ont tous les services AD actifs." -ForegroundColor Green
Write-Host "Fichier : $OutputFile" -ForegroundColor Yellow