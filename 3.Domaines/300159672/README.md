## Laboratoire — Installation d'un contrôleur de domaine Active Directory (Windows Server 2022)

### Objectif
Installer et configurer un contrôleur de domaine Active Directory avec DNS intégré sur Windows Server 2022, en PowerShell.

### Environnement
- **Système** : Windows Server 2022 Datacenter (machine virtuelle)
- **Host IP** : 10.7.237.225
- **Nom du serveur** : SRV300159672
- **Domaine** : DC300159672.local (nom court : DC300159672)
- **Connexion** : RDP via Windows App (Administrator)

### Étapes réalisées

**1. Renommage du serveur**
```powershell
Rename-Computer -NewName "SRV300159672" -Restart
```
Le serveur redémarre pour appliquer le nouveau nom.

**2. Installation du rôle AD DS**
  powershell
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools

<img width="1512" height="982" alt="Capture d’écran 2026-10-06 à 12 26 33" src="https://github.com/user-attachments/assets/b7885974-517f-419f-85f9-aff633e7c5f0" />


**3. Saisie sécurisée du mot de passe DSRM**
 powershell
$DSRM = Read-Host -AsSecureString -Prompt "Mot de passe DSRM"


<img width="1192" height="152" alt="Capture d’écran 2026-10-06 à 14 04 24" src="https://github.com/user-attachments/assets/de08cdaf-47f4-429b-8838-10e38a11ff66" />


**4. Création de la forêt et du domaine**
  powershell
Install-ADDSForest -DomainName "DC300159672.local" -DomainNetbiosName "DC300159672" -InstallDns:$true -SafeModeAdministratorPassword $DSRM -Force

<img width="1192" height="152" alt="Capture d’écran 2026-10-06 à 14 04 24" src="https://github.com/user-attachments/assets/b70ca14f-40ad-4c51-8515-c8fd353d9cec" />


Le serveur redémarre automatiquement à la fin de l'installation. Je me reconnecte ensuite avec le compte `DC300159672\Administrator`.

**5. Vérification de la forêt**
  powershell
Get-ADForest

<img width="943" height="767" alt="Capture d’écran 2026-10-06 à 13 54 48" src="https://github.com/user-attachments/assets/92d5c2f3-6422-4b06-801e-2df4cd1f4a10" />




### Résultat
- La forêt et le domaine `DC300159672.local` sont créés.
- Le serveur `SRV300159672.DC300159672.local` est le contrôleur de domaine : il détient les rôles de maître de schéma et de maître de nommage des domaines, et il héberge le catalogue global.
- La forêt fonctionne au niveau `Windows2016Forest`.
