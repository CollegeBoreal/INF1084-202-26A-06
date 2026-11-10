INF1084 – Objets gérables par Active Directory

RAPPORT DE LABORATOIRE

Étudiant : 300156534
Serveur : SRV300156534
Domaine : DC300156534.local
Nom NetBIOS : DC300156534
Adresse IP : 10.7.237.212
Système d’exploitation : Windows Server 2022
1. Introduction
L’objectif de ce laboratoire est de gérer des objets dans Active Directory et de configurer des ressources accessibles selon les autorisations. Les tâches réalisées comprennent la vérification du domaine, la création d’une unité d’organisation, d’un groupe et de comptes utilisateurs, la création d’un partage SMB, la configuration d’une GPO et les tests d’accès RDP.
2. Environnement et vérification d’Active Directory
Le serveur utilisé est SRV300156534. Le domaine Active Directory est DC300156534.local et le nom NetBIOS est DC300156534. Les commandes suivantes ont permis de vérifier l’identité du serveur, le domaine et la forêt :
hostname
Get-ADDomain
Get-ADForest
Figure 1 – Vérification du nom du serveur, du domaine et de la forêt
 <img width="915" height="987" alt="image" src="https://github.com/user-attachments/assets/d72def99-f358-4c6d-8f8e-0fd870ce2343" />

3. Préparation du dossier de travail et du script bootstrap
Le dossier de travail C:\300156534 a été créé. Le script bootstrap.ps1 initialise les informations du domaine et demande les identifiants de l’administrateur de façon sécurisée.
New-Item -Path C:\300156534 -ItemType Directory -Force
Set-Location C:\300156534
notepad bootstrap.ps1
. .\bootstrap.ps1
$cred.UserName
$netbiosName
$domainName
Le mot de passe administrateur est saisi par la fenêtre d’identification sécurisée et n’est pas inscrit directement dans le script.
Figure 2 – Création du dossier de travail
 <img width="915" height="1006" alt="image" src="https://github.com/user-attachments/assets/b1e23e0b-844e-48e9-9f93-2457cbb116ed" />

Figure 3 – Exécution du script bootstrap.ps1 et vérification des variables
 <img width="915" height="943" alt="image" src="https://github.com/user-attachments/assets/00b54223-f736-4318-934b-ec87cbe0468c" />

4. Création de l’unité d’organisation Students
L’unité d’organisation Students a été créée dans le domaine DC300156534.local.
New-ADOrganizationalUnit -Name "Students" -Path "DC=DC300156534,DC=local"
Get-ADOrganizationalUnit -Filter "Name -eq 'Students'"
Figure 4 – Création et vérification de l’unité d’organisation Students
 <img width="915" height="376" alt="image" src="https://github.com/user-attachments/assets/b387c253-e7d8-4f02-ace2-46ab50ce4f24" />

5. Création du groupe de sécurité Students
Un groupe de sécurité global nommé Students a été créé dans l’OU Students.
New-ADGroup -Name "Students" -SamAccountName "Students" -GroupScope Global -GroupCategory Security -Path "OU=Students,DC=DC300156534,DC=local" -Description "Users allowed RDP and shared folder access"
Get-ADGroup -Identity Students
Figure 5 – Création et vérification du groupe Students
 <img width="915" height="913" alt="image" src="https://github.com/user-attachments/assets/8d1cfa8a-4d66-4eac-adda-8bdbcaa3eee4" />

6. Création et vérification des utilisateurs
Les comptes Etudiant1 et Etudiant2 ont été créés dans l’OU Students. Les mots de passe ont été demandés avec Read-Host -AsSecureString, puis les comptes ont été ajoutés au groupe Students.
Identifiants des comptes étudiants
$Users = @("Etudiant1", "Etudiant2")
$OU = "OU=Students,DC=DC300156534,DC=local"
foreach ($user in $Users) {
    $Password = Read-Host "Mot de passe pour $user" -AsSecureString
    New-ADUser -Name $user -SamAccountName $user -Path $OU -AccountPassword $Password -Enabled $true
    Add-ADGroupMember -Identity "Students" -Members $user
}
Get-ADUser -Filter * -SearchBase "OU=Students,DC=DC300156534,DC=local" | Format-Table Name,SamAccountName,Enabled
Get-ADGroupMember -Identity Students
Figure 6 – Exécution du script de création des deux utilisateurs
 <img width="915" height="906" alt="image" src="https://github.com/user-attachments/assets/bc9262dc-4adf-4629-a3a3-6b60b829f8f3" />

Figure 7 – Vérification des comptes et des membres du groupe Students
 <img width="915" height="949" alt="image" src="https://github.com/user-attachments/assets/da46b1e2-9d8b-4365-8892-70491139a289" />

7. Création du dossier partagé SharedResources
Le dossier C:\SharedResources a été créé. Les permissions NTFS ont été accordées au groupe Students et un partage SMB nommé SharedResources a été publié.
$SharedFolder = "C:\SharedResources"
New-Item -Path $SharedFolder -ItemType Directory -Force
icacls C:\SharedResources /grant "DC300156534\Students:(OI)(CI)M"
New-SmbShare -Name "SharedResources" -Path "C:\SharedResources" -FullAccess "DC300156534\Students"
Get-SmbShare -Name SharedResources
Get-SmbShareAccess -Name SharedResources
La capture de vérification montre l’autorisation Full pour DC300156534\Students au niveau du partage SMB.
Figure 8 – Création du dossier et du partage réseau
 <img width="915" height="969" alt="image" src="https://github.com/user-attachments/assets/8d95664b-5b32-477f-a8b3-7f03909eddc9" />

Figure 9 – Vérificat<img width="915" height="914" alt="image" src="https://github.com/user-attachments/assets/eeed29d5-f0c3-461d-ba74-c032bdf303df" />
ion des permissions du partage
 
8. Création et liaison de la stratégie de groupe (GPO)
Une GPO appelée MapSharedFolder a été créée et liée à l’OU Students.
Import-Module GroupPolicy
New-GPO -Name "MapSharedFolder"
New-GPLink -Name "MapSharedFolder" -Target "OU=Students,DC=DC300156534,DC=local"
Get-GPO -Name "MapSharedFolder"
Get-GPInheritance -Target "OU=Students,DC=DC300156534,DC=local"
Figure 10 – Vérification de la GPO MapSharedFolder et de son lien
 <img width="915" height="977" alt="image" src="https://github.com/user-attachments/assets/10f9f1e9-8e5f-469a-b0f1-40f4182e2f76" />

9. Configuration du mappage du lecteur réseau Z:
Dans l’éditeur de gestion des stratégies de groupe, une préférence Drive Maps a été configurée sous User Configuration > Preferences > Windows Settings > Drive Maps. Le lecteur utilise l’action Update, la lettre Z:, l’emplacement \\SRV300156534\SharedResources et l’option Reconnect.
La capture ci-dessous montre l’entrée de mappage créée dans la GPO. Elle prouve la configuration, mais pas encore que le lecteur a été monté sur un poste client.
Figure 11 – Préférence Drive Maps pour le lecteur Z:
 <img width="915" height="958" alt="image" src="https://github.com/user-attachments/assets/35456c66-ed6f-43c2-aede-3ea97efb4784" />

10. Activation et vérification de RDP
Le groupe Students a été ajouté au groupe Remote Desktop Users. L’accès RDP a ensuite été activé dans le Registre et les règles du pare-feu Remote Desktop ont été activées.
Add-ADGroupMember -Identity "Remote Desktop Users" -Members "Students"
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
Get-ADGroupMember -Identity "Remote Desktop Users"
Get-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name fDenyTSConnections
Figure 12 – Activation de RDP et vérification du groupe Remote Desktop Users
 <img width="915" height="748" alt="image" src="https://github.com/user-attachments/assets/3dad3b2f-f628-42db-94ce-8b66cc2d6caa" />

Get-NetFirewallRule -DisplayGroup "Remote Desktop" | Format-Table DisplayName,Enabled,Profile
Figure 13 – Vérification des règles du pare-feu Remote Desktop
 <img width="915" height="818" alt="image" src="https://github.com/user-attachments/assets/7e46a435-a66d-43fa-8688-a03ed9e4444c" />

11. Mise à jour et vérification des stratégies de sécurité
La commande gpupdate /force a été exécutée. Les stratégies ordinateur et utilisateur ont été mises à jour avec succès.
gpupdate /force
Figure 14 – Résultat de gpupdate /force
 
La stratégie de sécurité locale a ensuite été exportée pour vérifier les droits d’ouverture de session à distance. Le résultat affiché inclut Students, Administrators et Remote Desktop Users dans SeRemoteInteractiveLogonRight.
secedit /export /cfg C:\secpol-check.cfg
Select-String "SeDenyRemoteInteractiveLogonRight" C:\secpol-check.cfg
Select-String "SeRemoteInteractiveLogonRight|SeDenyRemoteInteractiveLogonRight" C:\secpol-check.cfg
Figure 15 – Vérification du droit RDP et du compte UserTest
 <img width="915" height="940" alt="image" src="https://github.com/user-attachments/assets/953a11cb-d310-419e-9901-0b9853fc26eb" />

12. Test de connexion RDP avec un utilisateur autorisé
Une connexion Bureau à distance a été effectuée vers 10.7.237.212 avec le compte DC300156534\Etudiant1. Le bureau Windows du serveur s’est affiché : le test de connexion autorisée a réussi.
•	Ordinateur distant : 10.7.237.212
•	Compte utilisé : DC300156534\Etudiant1
•	Résultat : connexion réussie
Figure 16 – Bureau du serveur après la connexion RDP réussie avec Etudiant1
 <img width="915" height="320" alt="image" src="https://github.com/user-attachments/assets/218a3a69-05cf-4239-baa7-eb6d43421954" />

13. Test de connexion RDP avec un utilisateur non autorisé
Le compte UserTest a été créé séparément et vérifié. Son attribut MemberOf est vide : il n’appartient à aucun groupe. La tentative de connexion RDP a été refusée par Windows.
New-ADUser -Name "UserTest" -SamAccountName "UserTest" -AccountPassword (Read-Host "Mot de passe" -AsSecureString) -Enabled $true
Get-ADUser UserTest -Properties MemberOf | Select-Object Name,Enabled,MemberOf
Message affiché : “The connection was denied because the user account is not authorized for remote login.”
Figure 17 – Refus de connexion RDP pour UserTest
 <img width="915" height="786" alt="image" src="https://github.com/user-attachments/assets/1391d575-e707-4538-87aa-d80f8124cf44" />

14. Conclusion
Ce laboratoire a permis de créer et de vérifier des objets Active Directory, de configurer un partage SMB et une GPO de mappage de lecteur, puis d’activer et de tester l’accès RDP. Les tests montrent qu’Etudiant1 peut se connecter à distance, tandis que UserTest, qui n’appartient à aucun groupe, se voit refuser la connexion. Le mappage Z: est configuré dans la GPO; son application effective sur un poste client reste à confirmer si le cours exige une capture du lecteur monté.
Utilisateur	Mot de passe
Etudiant1	walid@2026
Etudiant2	walid@2026



 
