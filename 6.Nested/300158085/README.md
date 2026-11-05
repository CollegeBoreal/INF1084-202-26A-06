# INF1084 - Laboratoire 6.Nested

**Nom :** Kevin Mayele  
**Numéro étudiant :** 300158085  
**Serveur :** SRV300158085  
**Adresse IP :** 10.7.237.219

## Introduction

Dans ce laboratoire, j'ai travaillé sur mon serveur du collège pour créer un petit environnement réseau avec Hyper-V et Active Directory.

Le travail consistait à créer un réseau privé, installer un contrôleur de domaine et connecter une deuxième machine à ce domaine. J'ai utilisé principalement PowerShell pour faire les configurations et vérifier que tout fonctionnait.

## 1. Création du réseau LAB

J'ai commencé par vérifier les réseaux virtuels qui existaient déjà sur mon serveur. Ensuite, j'ai créé un commutateur interne nommé LAB.

`New-VMSwitch -Name LAB -SwitchType Internal`

Au départ, j'avais créé deux commutateurs avec le même nom. Après avoir remarqué le problème, j'ai supprimé celui qui était en double et conservé un seul LAB.

![Commutateur LAB](images/01-switch-LAB-unique.jpg)

## 2. Configuration IP et NAT

Une fois le commutateur créé, je lui ai attribué l'adresse IP `172.16.18.1/24`. Cette adresse sert de passerelle aux machines de mon laboratoire.

J'ai ensuite configuré le NAT pour le réseau `172.16.18.0/24`.

```powershell
New-NetIPAddress -IPAddress 172.16.18.1 -PrefixLength 24 -InterfaceAlias "vEthernet (LAB)"

New-NetNat -Name LABNAT -InternalIPInterfaceAddressPrefix 172.16.18.0/24
```

Après les commandes, j'ai vérifié que l'adresse IP était bien enregistrée et que le NAT était actif.

![Configuration IP et NAT](images/02-IP-LAB-et-NAT.jpg)

## 3. Création du contrôleur de domaine

J'ai créé une machine virtuelle appelée `DC300158085` avec Hyper-V.

J'ai utilisé une machine de génération 2 avec 4 Go de RAM, un disque virtuel dynamique de 60 Go et le commutateur LAB.

Après sa création, j'ai vérifié que les paramètres étaient corrects.

![Création de la machine virtuelle](images/03-creation-VM-DC.jpg)

## 4. Installation de Windows Server

Pour installer Windows Server 2022, j'ai utilisé les fichiers disponibles sur le lecteur D: de mon serveur.

Comme je n'avais pas de fichier ISO directement disponible, j'ai utilisé `install.wim` pour installer Windows sur le disque virtuel.

J'ai choisi la version Windows Server 2022 Standard Evaluation avec l'interface graphique.

![Source d'installation Windows](images/04-source-installation-Windows.jpg)

Une fois Windows installé, j'ai renommé la machine `DC300158085`, puis je l'ai redémarrée pour appliquer le nouveau nom.

![Renommage du serveur](images/05-renommage-DC.jpg)

J'ai ensuite configuré son adresse IP à `172.16.18.10`, avec la passerelle `172.16.18.1` et le DNS `172.16.18.10`.

J'ai fait un ping vers la passerelle pour vérifier la communication. Le test a réussi.

## 5. Installation d'Active Directory

Après avoir préparé le serveur, j'ai installé Active Directory Domain Services.

```powershell
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
```

L'installation s'est terminée correctement.

Ensuite, j'ai créé mon domaine `DC300158085.local`.

J'ai rencontré un problème avec le nom NetBIOS pendant cette étape. Le nom que je voulais utiliser était déjà pris. J'ai donc utilisé `BOREAL85`.

```powershell
Install-ADDSForest -DomainName "DC300158085.local" -DomainNetbiosName "BOREAL85"
```

Après le redémarrage, j'ai utilisé `Get-ADDomain` pour vérifier mon domaine. Les informations étaient correctes.

![Vérification du domaine](images/06-domaine-Active-Directory.jpg)

## 6. Création des OU

J'ai créé une OU principale appelée `OU300158085`.

À l'intérieur, j'ai ajouté les quatre OU demandées par le professeur : Students, Groups, Workstations et Servers.

J'ai ensuite affiché la liste des OU avec PowerShell pour vérifier qu'elles étaient toutes présentes au bon endroit.

![Structure des OU](images/07-unites-organisation-AD.jpg)

## 7. Création de CLIENT01

Après avoir terminé la configuration du domaine, j'ai créé une deuxième machine virtuelle nommée `CLIENT01`.

Comme pour le contrôleur de domaine, j'ai choisi la génération 2, 4 Go de RAM, un disque de 60 Go et le réseau LAB.

J'ai utilisé Windows Server 2022 avec l'interface graphique pour cette machine.

J'ai préparé les partitions du disque, puis installé Windows avec DISM et configuré le démarrage avec BCDBoot.

![Préparation du disque](images/08-partitions-EFI-Windows.jpg)

L'installation a réussi et CLIENT01 a démarré normalement.

![Installation de CLIENT01](images/09-installation-CLIENT01-DISM-UEFI.jpg)

## 8. Configuration réseau de CLIENT01

J'ai commencé par vérifier le nom de la machine avec `hostname`. Ensuite, j'ai configuré son réseau.

J'ai utilisé l'adresse `172.16.18.20/24`, la passerelle `172.16.18.1` et le serveur DNS `172.16.18.10`.

Après avoir terminé, j'ai vérifié l'adresse IP avec PowerShell. Elle apparaissait avec l'état `Preferred`.

![Adresse IP de CLIENT01](images/10-IP-CLIENT01-preferred.jpg)

## 9. Tests réseau et DNS

Avant de connecter CLIENT01 au domaine, j'ai vérifié qu'elle pouvait communiquer avec le contrôleur de domaine.

J'ai lancé un ping vers `172.16.18.10`. Les quatre paquets ont été reçus, sans aucune perte.

J'ai aussi testé le DNS pour vérifier que le nom `DC300158085.local` correspondait bien à l'adresse `172.16.18.10`.

Les deux tests ont réussi.

![Tests réseau et DNS](images/11-DNS-et-connectivite-CLIENT01.jpg)

## 10. Connexion de CLIENT01 au domaine

Pour terminer, j'ai vérifié que CLIENT01 appartenait bien au domaine `DC300158085.local`.

Lorsque j'ai essayé d'ajouter la machine au domaine, Windows m'a indiqué qu'elle en faisait déjà partie.

J'ai donc utilisé une autre commande pour vérifier son appartenance.

```powershell
Get-CimInstance Win32_ComputerSystem | Select-Object Name,Domain,PartOfDomain
```

Le résultat affichait `PartOfDomain : True`.

J'ai ensuite vérifié la relation de confiance avec le domaine.

```powershell
Test-ComputerSecureChannel -Verbose
```

Le résultat était `True`. Windows indiquait aussi que la communication sécurisée entre CLIENT01 et le domaine fonctionnait correctement.

![Vérification de la jonction au domaine](images/12-jonction-domaine-et-canal-securise.jpg)

## 11. Difficultés rencontrées

Ce laboratoire m'a demandé un peu plus de temps que prévu, surtout pendant la création des machines et la configuration du domaine.

J'ai dû corriger quelques erreurs dans mes commandes PowerShell. J'ai aussi rencontré des problèmes avec le nom NetBIOS et avec un commutateur LAB créé en double.

À chaque fois, j'ai essayé de comprendre le problème et de vérifier le résultat avant de continuer.

Ces difficultés m'ont aidé à mieux comprendre le fonctionnement de Windows Server, de PowerShell et d'Active Directory.

## Conclusion

Ce laboratoire m'a permis de mettre en pratique plusieurs notions vues en classe.

J'ai appris à préparer un réseau virtuel avec Hyper-V, à créer un contrôleur de domaine et à configurer une machine pour qu'elle communique avec Active Directory.

À la fin, les tests réseau, la résolution DNS et la relation de confiance avec le domaine ont tous fonctionné.

Ce que je retiens surtout, c'est l'importance de bien vérifier chaque configuration avant de passer à la suivante.
