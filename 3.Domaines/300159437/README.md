# Installation d'Active Directory Domain Services (AD DS)

## Configuration du serveur

L'installation d'Active Directory Domain Services a été réalisée sur une machine virtuelle utilisant **Windows Server 2022**.

Configuration utilisée :

| Paramètre | Valeur |
|---|---|
| Nom du serveur | `SRV300159437` |
| Adresse IP | `10.7.237.223` |
| Système | Windows Server 2022 |
| NetBIOS | `DC300159437` |
| Service | Active Directory Domain Services (AD DS) |
| DNS | Installé avec Active Directory |

---

## 1. Installation du rôle AD DS

Le rôle **Active Directory Domain Services (AD DS)** a été installé sur le serveur avec la commande PowerShell suivante :

```powershell
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
```

L'installation du rôle s'est terminée avec succès.

---

## 2. Création de la forêt Active Directory

Après l'installation du rôle AD DS, la commande `Install-ADDSForest` a été utilisée pour créer une nouvelle forêt Active Directory et promouvoir le serveur en contrôleur de domaine.

```powershell
Install-ADDSForest `
    -DomainName "DC300159437.local" `
    -DomainNetbiosName "DC300159437" `
    -InstallDns:$true `
    -SafeModeAdministratorPassword (ConvertTo-SecureString "********" -AsPlainText -Force) `
    -Force
```

Cette commande permet de :

- créer une nouvelle forêt Active Directory ;
- créer le domaine `DC300159437.local` ;
- utiliser `DC300159437` comme nom NetBIOS ;
- installer le service DNS ;
- promouvoir `SRV300159437` en contrôleur de domaine.

### Installation de la forêt

![Installation ADDS Forest](images/photo1.jpeg)

---

## 3. Vérification des prérequis

Pendant l'installation, Windows Server vérifie automatiquement les prérequis nécessaires à la création du contrôleur de domaine.

Le message suivant confirme que les vérifications ont été effectuées avec succès :

```text
All tests completed successfully
Installing new forest
Starting
```

Certains avertissements concernant la configuration DNS et les paramètres de sécurité de Windows Server 2022 peuvent également apparaître. Ils n'empêchent pas l'installation de continuer dans le cadre de ce laboratoire.

![Vérification des prérequis](images/photo2.jpeg)

---

## 4. Redémarrage et vérification d'Active Directory

Après l'installation, le serveur redémarre automatiquement.

La connexion au domaine peut ensuite être effectuée avec :

```text
DC300159437\Administrator
```

Pour vérifier la configuration du domaine, les commandes suivantes sont utilisées :

```powershell
Get-ADDomain
```

et :

```powershell
Get-ADForest
```

Ces commandes permettent de vérifier les informations concernant le domaine et la forêt Active Directory.

![Vérification Active Directory](images/photo3.jpeg)

---

## 5. Résultat

Le serveur `SRV300159437` est maintenant configuré comme **contrôleur de domaine Active Directory**.

La configuration finale est :

```text
Serveur             : SRV300159437
Adresse IP          : 10.7.237.223
Domaine             : DC300159437.local
Nom NetBIOS         : DC300159437
Système             : Windows Server 2022
Service             : Active Directory Domain Services
DNS                 : Installé
Rôle                 : Contrôleur de domaine
```

L'installation d'Active Directory permet maintenant de gérer de manière centralisée les utilisateurs, les ordinateurs, les groupes et les différentes ressources du domaine.
