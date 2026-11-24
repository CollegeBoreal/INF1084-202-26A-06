function Write-LabParticipationHeader {
    Write-Output "# Participation"
    Write-Output ""

    Write-Output "| Table des matières            | Description                                             |"
    Write-Output "|-------------------------------|---------------------------------------------------------|"
    Write-Output "| :a: [Présence](#a-présence)   | L'étudiant.e a fait son travail    :heavy_check_mark:   |"
    Write-Output "| :b: [Précision](#b-précision) | L'étudiant.e a réussi son travail  :tada:               |"

    Write-Output ""
    Write-Output "| Colonne   | Signification              |"
    Write-OUtput "|-----------|----------------------------|"
    Write-OUtput "| 📑        | Fichier README.md         |"
    Write-OUtput "| 🖼️        | Répertoire images         |"
    Write-OUtput "| 💯        | Appréciation              |"
    Write-OUtput "| 💬        | Commentaires              |"

    Write-Output ""
    Write-Output "## Légende"
    Write-Output ""
    Write-Output "| Signe              | Signification                       |"
    Write-Output "|--------------------|-------------------------------------|"
    Write-Output "| ❌                 | Rien dans `README.md`               |"
    Write-Output "| 🥉                 | Sous-réseau Class B créé            |"
    Write-Output "| 🥈                 | contrôleur de domaine créé          |"
    Write-Output "| 🥇                 | Client se connecte au domaine       |"
    Write-Output "| 🏆                 | `README.md` impeccable              |"

}


function Write-ConfigurationSection {
    param(
        [string]$Server
    )

    Write-Output "## :gear: Configuration"
    Write-Output ""

    Write-Output "| Proxmox PVE 9.2       | User/Pwd          |"
    Write-Output "|-------------------    |-------------------|"
    Write-Output "| ${Server}             | root/Boreal@2️⃣02️⃣6 |"
    Write-Output ""

}


function Write-LabHeader {
    param(
        [hashtable]$FeedbackLookup = @{}
    )

    Write-Output ""
    Write-Output "## :a: Présence"
    Write-Output ""

    if ($FeedbackLookup.Count -gt 0) {
        Write-Output "|:hash:| Boréal :id: | :bookmark_tabs: | :framed_picture: | :100: | :speech_balloon: | :link: IP |"
        Write-Output "|------|-------------|----|---|----|----|---|"
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
        [hashtable]$FeedbackLookup = @{},
        [string]$Server
    )

    if ($FeedbackLookup.Count -gt 0) {

        $Feedback = $FeedbackLookup[$StudentID]

        $Appreciation = if ($Feedback) { $Feedback.Appreciation } else { "" }
        $Comments     = if ($Feedback) { $Feedback.Comments } else { "" }

        Write-Output "| $Index | [$StudentID](../$ReadmePath) :point_right: $GitHubLink | $($Checks.README) | $($Checks.Images) | $Appreciation | $Comments | $($Server) |"
    }
    else {

        Write-Output "| $Index | [$StudentID](../$ReadmePath) :point_right: $GitHubLink | $($Checks.README) | $($Checks.Images) | $($Server) |"
    }
}

function Get-RdpStatus {
    param(
        [Parameter(Mandatory)]
        [string]$ServerIP,

        [int]$Timeout = 2
    )

    try {
        & nc -z -w $Timeout $ServerIP 3389 *> $null

        if ($LASTEXITCODE -eq 0) {
            return ":white_check_mark:"
        }

        return ":x:"
    }
    catch {
        return ":x:"
    }
}
