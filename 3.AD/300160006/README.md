# 300160006

## Laboratoire 3 - Active Directory
### But
Dans ce travail pratique, je vais installer et configurer Active Directory sur un serveur Windows Server 2022. L’objectif est de créer un domaine Active Directory, de configurer le serveur comme contrôleur de domaine et de mettre en place le service DNS nécessaire au fonctionnement du domaine. Pour réaliser cette configuration, j’utiliserai principalement des commandes PowerShell afin d’installer les rôles nécessaires, créer la forêt Active Directory et vérifier que la configuration fonctionne correctement.

Pour commencer, j’ai renommé le serveur avec le nom demandé en utilisant la commande suivante. Le serveur sera nommé SRV300160006.

```powershell
Rename-Computer -NewName "SRV300160006" -Restart
```
Après le redémarrage du serveur, j’ai vérifié son nom avec la commande hostname afin de confirmer que le changement a bien été effectué.

```powershell
 hostname
```
Le nom du serveur est maintenant ``text
SRV300160006
```
Ensuite, j’ai installé le rôle Active Directory Domain Services (AD DS) ainsi que les outils de gestion nécessaires à l’aide de la commande suivante.

```powershell
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
```
Le résultat indique que l’installation du rôle Active Directory Domain Services s’est effectuée avec succès

```text
Success Restart Needed Exit Code      Feature Result
------- -------------- ---------      --------------
True    No             Success        {Active Directory Domain Services, Group P...
```
Après l’installation du rôle AD DS, j’ai créé une nouvelle forêt Active Directory avec le domaine DC300160006.local. J’ai également défini le nom NetBIOS du domaine, activé l’installation du DNS et configuré le mot de passe DSRM.

```powershell
Install-ADDSForest `
    -DomainName "DC300160006.local" `
    -DomainNetbiosName "DC300160006" `
    -InstallDns:$true `
    -SafeModeAdministratorPassword (ConvertTo-SecureString "MotDePasseDSRM123!" -AsPlainText -Force) `
    -Force
```
Cette commande permet de créer la forêt et le domaine Active Directory et de transformer le serveur SRV300160006 en contrôleur de domaine. Le serveur redémarre ensuite afin de terminer la configuration.

Après le redémarrage, j’ai vérifié la configuration du domaine avec la commande suivante :
