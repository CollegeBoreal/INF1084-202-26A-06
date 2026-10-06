# Laboratoire 3 - Installation et configuration d’un domaine Active Directory

**Nom :** Touadjni Islem  
**ID :** 300159195  

## Objectif

Installer et configurer **Active Directory Domain Services (AD DS)** sur Windows Server 2022 à l’aide de PowerShell, créer un nouveau domaine avec DNS intégré, puis vérifier le fonctionnement du domaine et de la forêt.

---

## 1. Renommer le serveur

La première étape consiste à renommer le serveur avec l’identifiant étudiant.

```powershell
Rename-Computer -NewName "DC300159195" -Restart
```

Après le redémarrage, la commande suivante a été utilisée pour vérifier le nom de la machine :

```powershell
hostname
```

Résultat obtenu : `DC300159195`.

<img width="1536" height="1152" alt="01_hostname_dc300159195" src="https://github.com/user-attachments/assets/2d59d1dc-c960-4a25-aeeb-3bc4bd113bc1" />

**Résultat :** le serveur a bien été renommé en `DC300159195`.

---

## 2. Installer le rôle Active Directory Domain Services

Le rôle **AD DS** et les outils de gestion ont été installés avec la commande suivante :

```powershell
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
```

<img width="1536" height="1152" alt="02_installation_ad_ds" src="https://github.com/user-attachments/assets/b5315574-9802-44b4-9d1f-64c64d203597" />

**Résultat :** l’installation s’est terminée avec `Success : True`.

---

## 3. Première tentative de création du domaine

La création de la forêt a d’abord été lancée avec :

```powershell
Install-ADDSForest `
-DomainName "DC300159195.local" `
-DomainNetbiosName "DC300159195" `
-InstallDns:$true `
-SafeModeAdministratorPassword (ConvertTo-SecureString "MotDePasseDSRM123!" -AsPlainText -Force) `
-Force
```

La vérification des prérequis a retourné l’erreur suivante :

```text
The NetBIOS name DC300159195 is already in use.
```

<img width="1536" height="1152" alt="03_erreur_netbios" src="https://github.com/user-attachments/assets/b5740bb5-80de-4a84-aa9e-b32ce5fa5a73" />

**Explication :** le nom de la machine et le nom NetBIOS du domaine étaient identiques. Windows Server a donc détecté un conflit.

---

## 4. Corriger le conflit NetBIOS

Pour conserver `DC300159195` comme nom NetBIOS du domaine, le serveur a été renommé :

```powershell
Rename-Computer -NewName "SRV300159195" -Restart
```

Après le redémarrage, la commande suivante a été exécutée :

```powershell
hostname
```

<img width="1536" height="1152" alt="04_hostname_srv300159195" src="https://github.com/user-attachments/assets/7f0f9e73-7fef-4f54-a5e6-90c56e99a49f" />

**Résultat :** le nom de la machine est maintenant `SRV300159195`.

La configuration utilisée devient donc :

- **Serveur :** `SRV300159195`
- **Domaine DNS :** `DC300159195.local`
- **Nom NetBIOS :** `DC300159195`

---

## 5. Créer la forêt et le domaine Active Directory

La commande de création de la forêt a ensuite été exécutée de nouveau :

```powershell
Install-ADDSForest `
-DomainName "DC300159195.local" `
-DomainNetbiosName "DC300159195" `
-InstallDns:$true `
-SafeModeAdministratorPassword (ConvertTo-SecureString "MotDePasseDSRM123!" -AsPlainText -Force) `
-Force
```

Cette commande :

- crée une nouvelle forêt Active Directory ;
- crée le domaine `DC300159195.local` ;
- installe et configure DNS ;
- configure le mot de passe DSRM ;
- transforme le serveur en contrôleur de domaine.

<img width="1536" height="1152" alt="05_creation_domaine_reussie" src="https://github.com/user-attachments/assets/09b49b8c-15bd-4c93-9343-6b2f18b0c5ff" />

**Résultat :** l’opération s’est terminée avec le statut `Success` et le serveur a redémarré automatiquement.

---

## 6. Connexion au domaine

Après le redémarrage, la connexion au serveur est effectuée avec le compte administrateur du nouveau domaine :

```text
DC300159195\Administrator
```

Le même mot de passe Administrator du serveur est utilisé pour la connexion normale au domaine.

> Le mot de passe DSRM configuré pendant l’installation est réservé au mode de restauration Active Directory.

---

## 7. Vérifier le domaine et la forêt

Après la connexion, les commandes suivantes ont été utilisées :

```powershell
Get-ADDomain
Get-ADForest
```

<img width="1536" height="1152" alt="06_verification_domaine_foret" src="https://github.com/user-attachments/assets/43634666-db4c-4dc7-888d-69cb1f7d6b44" />

Les informations obtenues confirment notamment :

```text
Domaine     : DC300159195.local
Forêt       : DC300159195.local
Serveur DC  : SRV300159195.DC300159195.local
```

**Résultat :** le domaine et la forêt Active Directory sont correctement créés et fonctionnels.

---

## 8. Ouvrir Active Directory Users and Computers

La console **Active Directory Users and Computers** a été ouverte avec :

```powershell
Start-Process dsa.msc
```

<img width="1152" height="1536" alt="07_active_directory_users_computers" src="https://github.com/user-attachments/assets/da0ecb5c-d45f-45bb-a500-f943cb4f4f75" />

La console affiche correctement le domaine :

```text
DC300159195.local
```

ainsi que les conteneurs Active Directory principaux, notamment :

- `Builtin`
- `Computers`
- `Domain Controllers`
- `ForeignSecurityPrincipals`
- `Managed Service Accounts`
- `Users`

---


## 9. Vérifier le service DNS

La console **DNS Manager** a été ouverte afin de vérifier que le service DNS a bien été installé avec Active Directory.

```powershell
dnsmgmt.msc
```

<img width="709" height="1536" alt="08_dns_manager" src="https://github.com/user-attachments/assets/0b94b8fe-defb-4b75-a58a-fdd0b16f79ed" />

La console DNS affiche le serveur :

```text
SRV300159195
```

**Résultat :** le rôle DNS est installé et le serveur DNS est disponible sur le contrôleur de domaine.

---

## Résultat final

L’installation et la configuration d’Active Directory ont été réalisées avec succès.

Configuration finale :

```text
Nom du serveur       : SRV300159195
Domaine Active Directory : DC300159195.local
Nom NetBIOS          : DC300159195
DNS                  : Installé
Contrôleur de domaine: Fonctionnel
```

Les commandes `Get-ADDomain`, `Get-ADForest`, la console `dsa.msc` et la console DNS confirment que l’environnement Active Directory est opérationnel.
