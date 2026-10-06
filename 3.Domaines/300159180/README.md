Installation Active Directory – Windows Server 2022
Objectif
Installer un contrôleur de domaine Active Directory avec PowerShell.
Configuration
- Serveur : DC300159180
- Domaine : DC300159180.local
- NetBIOS : DOM300159180
Étapes principales
1. Renommer le serveur :
Rename-Computer -NewName "SRV300159180" -Restart

2. Installer AD DS :
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools

3. Créer le domaine :
Install-ADDSForest -DomainName "DC300159180.local" -DomainNetbiosName "DOM300159180" -InstallDns:$true -Force

4. Le serveur redémarre automatiquement.
5. Vérifier l’installation :
Get-ADDomain
Get-ADForest
Get-ADDomainController
Get-Service NTDS
<img width="564" height="474" alt="image" src="https://github.com/user-attachments/assets/0b7c2dc3-e03e-4241-9f2a-c85523bea98e" />
<img width="557" height="479" alt="image" src="https://github.com/user-attachments/assets/80c08175-0000-41d6-89a0-3e7fe60d4622" />
<img width="563" height="475" alt="image" src="https://github.com/user-attachments/assets/7afddc86-b3ea-44ee-ac56-3d6ba0854320" />
<img width="560" height="395" alt="image" src="https://github.com/user-attachments/assets/e1ee6e51-e80a-47bb-b829-f2356bb7f73a" />



