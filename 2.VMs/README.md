# Réseau Hyper‑V et accès RDP

| #️⃣ | Participations |
|-|-|
| 1️⃣ | [:tada: Participation](.scripts/Participation-group1.md) |
| 2️⃣ | [:tada: Participation](.scripts/Participation-group2.md) |
| 3️⃣ | [:tada: Participation](.scripts/Participation-group3.md) |
| 4️⃣ | [:tada: Participation](.scripts/Participation-group4.md) |

## 🗄️ Rack 2️⃣ - 📇 42U

| Rack | U#️⃣| 🏙️ Serveurs | 🏷️  | S/N #️⃣        | Host IP                    | RAM  | CPU | HD      | Comments                             |
| ---- | -:| ------------| --- | ------------ | --------------------------- | ---: | ---:| ------- | ------------------------------------ |
| 2️⃣   | 27 | 🅰️ G7️⃣      | S28 | MXQ1370MCG✅ | 10.7.237.7                  | 64GB | 16  | 273.4G  | $\color{green}\text{1TBNVMe}$  $\color{red}\text{E:}$
| 2️⃣   | 26 | 🅰️ G7️⃣      | S26 | MXQ1170T6R✅ | 10.7.237.35                 | 64GB | 16  | 273.4G  | $\color{green}\text{1TBNVMe}$  $\color{green}\text{D:}$
| 2️⃣   | 25 | 🅰️ G6️⃣      | S25 | MXQ016001V✅ | 10.7.237.24                 | 64GB | 16  | 273.4G  | $\color{green}\text{1TBNVMe}$  $\color{red}\text{E:}$  
| 2️⃣   | 24 | 🅰️ G6️⃣      | S13 | MXQ0030BLP✅ | 10.7.237.28                 | 64GB | 16  | 273.4G  | $\color{green}\text{1TBNVMe}$  $\color{green}\text{D:}$

## Objectifs

Chaque étudiant doit :

✅ Configurer une adresse IP statique  
✅ Configurer le DNS et la passerelle  
✅ Vérifier la connectivité réseau  
✅ Activer le Bureau à distance (RDP)  
✅ Se connecter à sa VM via RDP

***

# 1. Vérifier le nom de la VM

```powershell
hostname
```

***

# 2. Vérifier la configuration actuelle

```powershell
Get-NetIPConfiguration
```

ou

```powershell
ipconfig /all
```

***

# 3. Configurer une adresse IP statique

Exemple :

| Paramètre  | Valeur        |
| ---------- | ------------- |
| IP         | 10.7.237.x    |
| Masque     | 255.255.255.0 |
| Passerelle | 10.7.237.1    |
| DNS        | 10.7.237.3    |

Identifier l'interface :

```powershell
Get-NetAdapter
```

Configuration :

```powershell
New-NetIPAddress `
-InterfaceAlias "Ethernet" `
-IPAddress 10.7.237.x `
-PrefixLength 23 `
-DefaultGateway 10.7.237.1
```

Configurer le DNS :

```powershell
Set-DnsClientServerAddress `
-InterfaceAlias "Ethernet" `
-ServerAddresses 10.7.237.3
```

Vérification :

```powershell
ipconfig
```

***

# 4. Tester la connectivité

Passerelle :

```powershell
ping 10.7.237.1
```

Internet :

```powershell
ping 8.8.8.8
```

DNS :

```powershell
ping google.ca
```

***

# 5. Activer RDP

Activer le Bureau à distance :

```powershell
Set-ItemProperty `
-Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" `
-Name "fDenyTSConnections" `
-Value 0
```

Autoriser les règles de pare-feu :

```powershell
Enable-NetFirewallRule `
-DisplayGroup "Remote Desktop"
```

Vérifier que RDP écoute :

```powershell
Get-NetTCPConnection -LocalPort 3389
```

ou

```powershell
netstat -an | findstr 3389
```

***

# 6. Vérifier le compte Administrateur

```powershell
whoami
```

ou

```powershell
Get-LocalUser
```

***

# 7. Tester RDP

Depuis le poste physique :

```text
Win + R
mstsc
```

Entrer l'adresse IP de la VM :

```text
10.7.237.x
```

Connexion :

```text
Utilisateur : Administrator
Mot de passe : ********
```

***

# 8. Vérifier que la VM reçoit la connexion

Dans la VM :

```powershell
quser
```

ou

```powershell
query user
```

Les étudiants verront leur session RDP active.

***

# 9. Test entre étudiants

Chaque étudiant tente :

```powershell
ping 10.7.237.202
```

Puis :

```text
mstsc
```

vers l'adresse IP d'un voisin (si autorisé pour l'exercice).

***

# Dépannage

### RDP ne fonctionne pas

Vérifier :

```powershell
Get-NetFirewallRule -DisplayGroup "Remote Desktop"
```

### Adresse IP

```powershell
ipconfig
```

### Port RDP

```powershell
Test-NetConnection localhost -Port 3389
```

Résultat attendu :

```text
TcpTestSucceeded : True
```

***

# Cheat Sheet finale

```powershell
hostname

Get-NetAdapter

Get-NetIPConfiguration

New-NetIPAddress `
-InterfaceAlias "Ethernet" `
-IPAddress 10.7.237.x `
-PrefixLength 23 `
-DefaultGateway 10.7.237.1

Set-DnsClientServerAddress `
-InterfaceAlias "Ethernet" `
-ServerAddresses 10.7.237.3

ping 10.7.237.1

ping 8.8.8.8

ping google.ca

Set-ItemProperty `
-Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" `
-Name "fDenyTSConnections" `
-Value 0

Enable-NetFirewallRule `
-DisplayGroup "Remote Desktop"

Test-NetConnection localhost -Port 3389

query user
```

### Remise suggérée

Chaque étudiant fournit :

1. Nom de la VM (`hostname`)
2. Adresse IP statique
3. Capture d'écran de `ipconfig`
4. Résultat de `ping 10.7.237.3`
5. Résultat de `ping google.ca`
6. Capture d'écran d'une connexion RDP réussie à sa VM

Ce laboratoire couvre IPv4, DNS, passerelle, pare-feu, RDP et administration à distance en une seule séance, ce qui est une excellente transition vers DHCP, DNS et Active Directory.

