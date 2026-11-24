# ---------- Fonctions ----------

function Get-LabStudentPaths {
    param(
        [string]$StudentID
    )

    return @{
        SERVICES1   = "$StudentID/services1.ps1"
        SERVICES2   = "$StudentID/services2.ps1"
        SERVICES3   = "$StudentID/services3.ps1"
        SERVICES4   = "$StudentID/services4.ps1"
    }
}

function Get-LabStudentChecks {
    param(
        [hashtable]$Paths
    )

    return @{
        SERVICES1    = Test-LabItemExists -Path $Paths.SERVICES1
        SERVICES2    = Test-LabItemExists -Path $Paths.SERVICES2
        SERVICES3    = Test-LabItemExists -Path $Paths.SERVICES3
        SERVICES4    = Test-LabItemExists -Path $Paths.SERVICES4
    }
}

function Test-LabItemExists {
    param(
        [string]$Path
    )

    if (-not (Test-Path $Path)) {
        return ":x:"
    }

    return ":heavy_check_mark:"
}


function Test-LabAllRequiredFilesPresent {
    param(
        [hashtable]$Checks
    )

    return (
        $Checks.SERVICES1 -eq ":heavy_check_mark:" -and
        $Checks.SERVICES2 -eq ":heavy_check_mark:" -and
        $Checks.SERVICES3 -eq ":heavy_check_mark:" -and
        $Checks.SERVICES4 -eq ":heavy_check_mark:"
    )
}

function Write-LabParticipationHeader {
    Write-Output "# Participation"
    Write-Output ""

    Write-Output "| Table des matières            | Description                                             |"
    Write-Output "|-------------------------------|---------------------------------------------------------|"
    Write-Output "| :a: [Présence](#a-présence)   | L'étudiant.e a fait son travail    :heavy_check_mark:   |"
    Write-Output "| :b: [Précision](#b-précision) | L'étudiant.e a réussi son travail  :tada:               |"


    Write-Output ""
    Write-Output "## Légende"
    Write-Output ""
    Write-Output "| Colonne           | Signification              |"
    Write-OUtput "|-------------------|----------------------------|"
    Write-OUtput "| :bookmark_tabs:   | Fichier README.md         |"
    Write-OUtput "| :framed_picture:  | Répertoire images         |"
    Write-OUtput "| :100:             | Appréciation              |"
    Write-OUtput "| :speech_balloon:  | Commentaires              |"

    Write-Output ""
    Write-Output "| Signe              | Signification                               |"
    Write-Output "|--------------------|----------------------------------------------|"
    Write-Output "| :x:                | Rien dans `README.md`                        |"
    Write-Output "| :3rd_place_medal:  | Fichiers `services:hash:.ps1` présents       |"
    Write-Output "| :2nd_place_medal:  | Fichiers `services:hash:.ps1` Exécutés.      |"
    Write-Output "| :1st_place_medal:  | Répertoire et fichier `C:\Logs` présents.    |"
    Write-Output "| :trophy:           | `README.md` impeccable                       |"

}

function Write-LabHeader {
    param(
        [hashtable]$FeedbackLookup = @{}
    )

    Write-Output ""
    Write-Output "## :a: Présence"
    Write-Output ""

    if ($FeedbackLookup.Count -gt 0) {
        Write-Output "|:hash:| Boréal :id: | :bookmark_tabs: | :framed_picture: | :100: | :speech_balloon: | :link: IP | :one: | :two: | :three: | :four: |"
        Write-Output "|------|-------------|-----------------|------------------|-------|------------------|-----------|-|-|-|-|"
    }
    else {
        Write-Output "|:hash:| Boréal :id: | :bookmark_tabs: | :framed_picture: | :link: IP |"
        Write-Output "|------|-------------|----|---|---|"
    }
}

function Write-LabStudentRow {
    param(
        [int]$Index,
        [string]$StudentID,
        [string]$GitHubLink,
        [string]$ReadmePath,
        [hashtable]$Checks,
        [hashtable]$LabChecks,
        [hashtable]$FeedbackLookup = @{},
        [string]$Server
    )

    if ($FeedbackLookup.Count -gt 0) {

        $Feedback = $FeedbackLookup[$StudentID]

        $Appreciation = if ($Feedback) { $Feedback.Appreciation } else { "" }
        $Comments     = if ($Feedback) { $Feedback.Comments } else { "" }

        Write-Output "| $Index | [$StudentID](../$ReadmePath) :point_right: $GitHubLink | $($Checks.README) | $($Checks.Images) | $Appreciation | $Comments | $($Server) | $($LabChecks.SERVICES1) | $($LabChecks.SERVICES2) | $($LabChecks.SERVICES3) | $($LabChecks.SERVICES4) |"
    }
    else {

        Write-Output "| $Index | [$StudentID](../$ReadmePath) :point_right: $GitHubLink | $($Checks.README) | $($Checks.Images) | $($Server) |"
    }
}