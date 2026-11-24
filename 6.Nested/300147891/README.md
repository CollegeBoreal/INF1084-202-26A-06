**INF1084 – Laboratoire Nested Hyper-V**

**Nom** : BARRY

**Prénom** : Amadou

**ID** : 300147891

1. **Présentation du laboratoire**

L'objectif de ce laboratoire est de mettre en place un environnement Active Directory à l'aide de la virtualisation Hyper-V.

Sur mon serveur parent SRV300147891, j'ai utilisé deux machines virtuelles :

**SRV01** : contrôleur de domaine qui permet de gérer les utilisateurs, les ordinateurs et le service DNS.
**CLIENT01** : machine cliente utilisée pour tester l'intégration au domaine et la connexion à distance.

Les deux machines communiquent sur un réseau privé grâce au commutateur virtuel LAB. Le NAT leur permet d'accéder au réseau extérieur.

Le domaine DC300147891.local permet de centraliser la gestion des utilisateurs et des ordinateurs du laboratoire.



2. **Création du réseau privé et du NAT**

Sur le serveur parent :

```powershell
New-VMSwitch -Name LAB -SwitchType Internal
<img width="1296" height="412" alt="image" src="https://github.com/user-attachments/assets/e828a7c4-59f2-4356-9d0c-e7526f94c4aa" />


New-NetIPAddress -IPAddress 172.16.18.1 -PrefixLength 24 -InterfaceAlias "vEthernet (LAB)"

New-NetNat -Name LABNAT -InternalIPInterfaceAddressPrefix "172.16.18.0/24"
```
<img width="1062" height="406" alt="image" src="https://github.com/user-attachments/assets/88766286-2a39-4eda-8a58-87ddb3f2a3cc" />


Vérification :

```powershell
Get-VMSwitch
Get-NetNat
```


## 3. Installation d'Active Directory et création de la forêt

**Sur SRV01 :**

```powershell
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools

Install-ADDSForest -DomainName "DC300147891.local" -InstallDNS
```

Vérification après redémarrage :

```powershell
Get-ADDomain
Get-ADForest
Get-Service DNS
```

<img width="685" height="520" alt="image" src="https://github.com/user-attachments/assets/5834a615-5d7e-4158-8e45-8aba24c68cb0" />




4. **Création des unités organisationnelles**

**Sur le SRV01** :

```powershell
New-ADOrganizationalUnit -Name "OU300147891"

New-ADOrganizationalUnit -Name "Students" -Path "OU=OU300147891,DC=DC300147891,DC=local"

New-ADOrganizationalUnit -Name "Groups" -Path "OU=OU300147891,DC=DC300147891,DC=local"

New-ADOrganizationalUnit -Name "Workstations" -Path "OU=OU300147891,DC=DC300147891,DC=local"

New-ADOrganizationalUnit -Name "Servers" -Path "OU=OU300147891,DC=DC300147891,DC=local"
```

**Vérification** :

```powershell
Get-ADOrganizationalUnit -Filter * | Select-Object Name
```
<img width="656" height="406" alt="image" src="https://github.com/user-attachments/assets/257fa9b9-1b6f-415d-a81f-df8c5f31d67c" />


<img width="752" height="422" alt="image" src="https://github.com/user-attachments/assets/4aa29843-9877-42d5-a38c-30e29a2c672b" />


5. **Création de CLIENT01**

Sur le serveur parent :

```powershell
New-VM -Name CLIENT01 `
    -Generation 2 `
    -MemoryStartupBytes 4GB `
    -NewVHDPath "C:\VMs\CLIENT01.vhdx" `
    -NewVHDSizeBytes 60GB `
    -SwitchName LAB
```

Installation de Windows Server 2022 Datacenter avec interface graphique.

<img width="725" height="512" alt="image" src="https://github.com/user-attachments/assets/71844ea1-97a3-4ad0-88a0-9399a6fb4ab5" />


**Configuration réseau sur CLIENT01 :**

```powershell
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 172.16.18.20 -PrefixLength 24 -DefaultGateway 172.16.18.1

Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses 172.16.18.10
```

6. **Intégration du client au domaine**

Sur CLIENT01 :

```powershell
Add-Computer -DomainName "DC300147891.local" -Credential "Administrator@DC300147891.local" -Restart
```

Vérification après redémarrage :

```powershell
Test-ComputerSecureChannel
```

Résultat : True

<img width="760" height="603" alt="image" src="https://github.com/user-attachments/assets/dff84809-3d08-445b-9399-41d108ed015e" />


**Sur SRV01 :**

```powershell
Get-ADComputer -Filter * | Select-Object Name, DNSHostName

Get-ADComputer CLIENT01 | Move-ADObject -TargetPath "OU=Workstations,OU=OU300147891,DC=DC300147891,DC=local"
```

7. Création de l'utilisateur Etudiant1

Sur SRV01 :

```powershell
New-ADUser -Name "Etudiant1" `
    -SamAccountName "Etudiant1" `
    -UserPrincipalName "Etudiant1@DC300147891.local" `
    -Path "OU=Students,OU=OU300147891,DC=DC300147891,DC=local" `
    -AccountPassword (Read-Host "Mot de passe" -AsSecureString) `
    -Enabled $true
```

8. Configuration et test RDP

Sur CLIENT01 :

```powershell
Add-LocalGroupMember -Group "Remote Desktop Users" -Member "Etudiant1@DC300147891.local"

Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0

Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
```

**Depuis le serveur parent :**

```powershell
mstsc /v:172.16.18.20
```

Connexion avec Etudiant1, puis vérification :

```powershell
whoami
whoami /groups
```
<img width="710" height="555" alt="image" src="https://github.com/user-attachments/assets/bee0b2f3-12a1-41f1-9879-f07a2e6cbc3e" />


La connexion à distance avec l'utilisateur du domaine a été réalisée avec succès.

## 9. Conclusion

J'ai mis en place un environnement Active Directory indépendant avec un réseau privé, un contrôleur de domaine et une machine cliente. CLIENT01 est correctement intégré au domaine et l'utilisateur Etudiant1 peut se connecter à distance.
