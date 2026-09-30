
# Installation et configuration d’un domaine Active Directory

**Nom :** Hammiche Billal
**ID étudiant :** 300159887

## Configuration du serveur

L’installation d’Active Directory Domain Services (AD DS) a été réalisée sur une machine virtuelle utilisant **Windows Server 2022 Datacenter**.

| Paramètre      | Valeur                                   |
| -------------- | ---------------------------------------- |
| Nom du serveur | `SRV300159887`                           |
| Adresse IP     | `10.7.237.227`                           |
| Système        | Windows Server 2022 Datacenter           |
| Domaine        | `300159887.local`                        |
| NetBIOS        | `BILLAL300159887`                        |
| Service        | Active Directory Domain Services (AD DS) |
| DNS            | Installé avec Active Directory           |

---

## 1. Renommage du serveur

Le serveur a été renommé avec la commande PowerShell suivante :

```powershell
Rename-Computer -NewName "SRV300159887" -Restart
```

Après le redémarrage, le nom du serveur a été vérifié avec :

```powershell
hostname
```

Le résultat obtenu était :

```text
SRV300159887
```

---

## 2. Installation du rôle AD DS

Le rôle **Active Directory Domain Services** ainsi que les outils d'administration ont été installés avec la commande :

```powershell
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
```

L'installation s'est terminée avec succès :

```text
Success : True
Restart Needed : No
Exit Code : Success
```

---

## 3. Création de la forêt Active Directory

Une nouvelle forêt Active Directory a ensuite été créée avec le domaine :

```text
300159887.local
```

La commande utilisée était :

```powershell
Install-ADDSForest `
    -DomainName "300159887.local" `
    -DomainNetbiosName "BILLAL300159887" `
    -InstallDns:$true `
    -SafeModeAdministratorPassword (ConvertTo-SecureString "********" -AsPlainText -Force) `
    -Force
```

Cette commande permet de :

* créer une nouvelle forêt Active Directory ;
* créer le domaine `300159887.local` ;
* définir `BILLAL300159887` comme nom NetBIOS ;
* installer le service DNS ;
* promouvoir le serveur en contrôleur de domaine.

Le nom NetBIOS devait contenir des lettres, car un nom composé uniquement de chiffres n'est pas accepté par Active Directory.

---

## 4. Vérification d’Active Directory
<img width="846" height="685" alt="Capture d’écran 2026-09-29 125436" src="https://github.com/user-attachments/assets/45ac4678-4bd8-4a10-bc62-b0538c35ec40" />


Après le redémarrage du serveur, la configuration du domaine a été vérifiée avec :

```powershell
Get-ADDomain
```

Le résultat confirme notamment :

```text
DNSRoot     : 300159887.local
Name        : 300159887
NetBIOSName : BILLAL300159887
```

Le contrôleur de domaine identifié est :

```text
SRV300159887.300159887.local
```

La forêt a également été vérifiée avec :

```powershell
Get-ADForest
```

Le résultat confirme :

```text
Name           : 300159887.local
RootDomain     : 300159887.local
Domains        : {300159887.local}
GlobalCatalogs : {SRV300159887.300159887.local}
```

---

 5. Configuration et vérification du DNS
  <img width="879" height="682" alt="Capture d’écran 2026-09-29 130701" src="https://github.com/user-attachments/assets/7563a646-6812-4ff8-937d-254a86c65853" />
  <img width="876" height="714" alt="Capture d’écran 2026-09-29 130746" src="https://github.com/user-attachments/assets/21a34871-2006-491f-b616-924a556e9025" />

  

Le service DNS a été installé automatiquement lors de la création de la forêt grâce à l'option :

```powershell
-InstallDns:$true
```

Le fonctionnement du service a été vérifié avec :

```powershell
Get-Service DNS
```

Le résultat obtenu était :

```text
Status   Name   DisplayName
Running  DNS    DNS Server
```

Les zones DNS ont ensuite été vérifiées avec :

```powershell
Get-DnsServerZone
```

Les principales zones obtenues sont :

```text
_msdcs.300159887.local
300159887.local
```

Les deux zones sont indiquées comme **intégrées à Active Directory** (`IsDsIntegrated : True`).

---

6. Résultat final

À la fin du laboratoire, le serveur est configuré comme **contrôleur de domaine Active Directory** avec DNS intégré.

La configuration finale est :

```text
Nom du serveur     : SRV300159887
Adresse IP         : 10.7.237.227
Domaine            : 300159887.local
Nom NetBIOS        : BILLAL300159887
Système            : Windows Server 2022 Datacenter
Service            : Active Directory Domain Services
DNS                : Installé et fonctionnel
Rôle               : Contrôleur de domaine
```

 Conclusion

Ce laboratoire a permis d'installer et de configurer un domaine Active Directory sur Windows Server 2022. Le serveur `SRV300159887` fonctionne maintenant comme contrôleur de domaine pour le domaine `300159887.local`. Le service DNS a également été installé et configuré avec Active Directory. Les commandes `Get-ADDomain`, `Get-ADForest`, `Get-Service DNS` et `Get-DnsServerZone` ont permis de confirmer que la configuration est fonctionnelle.
