# Rapport de Laboratoire :
  Objets Active Directory, Partage de Ressources et GPO (TP 5)
  
## 1. Objectif du laboratoire :

L'objectif de ce TP est de manipuler les objets Active Directory via PowerShell (Unités d'Organisation, Groupes, Utilisateurs), de configurer un partage de fichiers SMB sécurisé, d'automatiser le mappage d'un lecteur réseau à l'aide d'une stratégie de groupe (GPO), et d'activer l'accès à distance (RDP).2. Environnement de travail :Contrôleur de domaine : SRV300153416.boreal.local (10.7.237.210)   Domaine / NetBIOS : boreal.local / BOREAL   Dossier partagé : C:\SharedResources3. Réalisation et Scripts PowerShell :Étape 1 : Création de la structure organisationnelle, du groupe et des utilisateurs (utilisateurs1.ps1)Création de l'OU Students, du groupe global Students, des comptes utilisateurs (Etudiant1, Etudiant2) et configuration du partage SMB avec un accès total pour le groupe.PowerShell# Créer l'Unité d'Organisation (OU) Students
if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'Students'")) {
    New-ADOrganizationalUnit -Name "Students" -Path "DC=boreal,DC=local"
}

# Créer le dossier partagé et le groupe AD
$SharedFolder = "C:\SharedResources"
New-Item -Path $SharedFolder -ItemType Directory -Force
New-ADGroup -Name "Students" -GroupScope Global -Path "OU=Students,DC=boreal,DC=local" -Description "Users allowed RDP and shared folder access"

# Créer les utilisateurs et les ajouter au groupe
$Users = @("Etudiant1","Etudiant2")
foreach ($user in $Users) {
    New-ADUser -Name $user -SamAccountName $user -Path "OU=Students,DC=boreal,DC=local" -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) -Enabled $true
    Add-ADGroupMember -Identity "Students" -Members $user
}

# Partager le dossier
New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess "Students"
Étape 2 : Création de la GPO pour le mappage du lecteur réseau (utilisateurs2.ps1)Création d'un objet de stratégie de groupe (MapSharedFolder), association à l'OU Students, et configuration du script de connexion pour mapper automatiquement le lecteur Z:.PowerShell$GPOName = "MapSharedFolder"
New-GPO -Name $GPOName
New-GPLink -Name $GPOName -Target "OU=Students,DC=boreal,DC=local"

$DriveLetter = "Z:"
$SharePath = "\\BOREAL\SharedResources"
$ScriptPath = "C:\Scripts\MapDrive-Z.bat"

"net use $DriveLetter $SharePath /persistent:no" | Out-File -FilePath $ScriptPath -Encoding ascii

Set-GPRegistryValue -Name $GPOName `
                    -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" `
                    -ValueName "LogonScript" `
                    -Type String `
                    -Value $ScriptPath
Étape 3 : Activation du Bureau à distance (RDP) et mise à jour des politiquesAutorisation des connexions RDP sur le serveur et application forcée des stratégies de groupe.PowerShellSet-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

$rdpGroup = Get-LocalGroup | Where-Object { $_.SID -eq "S-1-5-32-555" }
if ($rdpGroup) {
    Add-LocalGroupMember -Group $rdpGroup.Name -Member "BOREAL\Students"
}

gpupdate /force
4. Conclusion :
Toutes les tâches du laboratoire ont été exécutées avec succès via PowerShell. La création de la structure Active Directory, le partage SMB, le déploiement de la GPO de mappage de lecteur et l'accès RDP sont pleinement fonctionnels sur le domaine boreal.local
<img width="2040" height="1536" alt="0" src="https://github.com/user-attachments/assets/c2d27cf8-4807-4c0a-ad82-a332db8f24b8" />
<img width="2040" height="1536" alt="00" src="https://github.com/user-attachments/assets/f9b8da4a-5f95-428e-bec0-2c77909f02e6" />
<img width="2040" height="1536" alt="000" src="https://github.com/user-attachments/assets/87d53eb7-b133-4034-8c3f-8e09b10345ff" />
<img width="2040" height="1536" alt="0000" src="https://github.com/user-attachments/assets/d5cd7ab0-0ade-44ac-b82f-055cc9633e8c" />




