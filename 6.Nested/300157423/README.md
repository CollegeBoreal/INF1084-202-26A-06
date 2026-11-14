# INF1084 — Architecture Active Directory avec Hyper-V

**Nom :** Gaya Mahroug  
**Matricule :** 300157423  
**Cours :** INF1084 – Administration Windows  
**Environnement :** Windows Server 2022, Hyper-V, PowerShell et Active Directory Domain Services

## Objectif

Ce laboratoire consiste à administrer un environnement Active Directory dans une machine virtuelle Hyper-V, à gérer les comptes utilisateurs et groupes, à configurer un partage réseau et à vérifier l'application d'une stratégie de groupe (GPO).

## Architecture finale

```text
SRV300157423 — DC300157423-0.local
└── Hyper-V : SRV01
    ├── OU Students
    │   ├── Juba
    │   └── Jugurtha
    ├── Groupe Students : Juba, Jugurtha
    ├── Partage C:\SharedResources
    └── GPO MapSharedFolder → lecteur Z:
```

## Plan de configuration

| Élément | Configuration vérifiée |
|---|---|
| Serveur | SRV300157423 |
| Domaine | DC300157423-0.local |
| Machine virtuelle | SRV01 |
| OU / Groupe | Students |
| Utilisateurs | Juba et Jugurtha |
| Partage | C:\SharedResources |
| GPO | MapSharedFolder |
| Lecteur réseau | Z: |

## 1. Vérification du domaine et du service DFSR

La commande confirme l'appartenance du serveur au domaine. Le service DFSR a été arrêté puis redémarré, et son état est `Running`.

```powershell
Get-CimInstance Win32_ComputerSystem | Select-Object Name,Domain,PartOfDomain
(Get-Service -Name DFSR).Status
```

<img width="514" height="438" alt="w11" src="https://github.com/user-attachments/assets/8aad6635-bc3b-4000-92ba-691c6d2918d4" />
<img width="955" height="1080" alt="w1" src="https://github.com/user-attachments/assets/cd719594-4e96-4e33-8d48-34b850035ddc" />


## 2. Gestion des utilisateurs Active Directory

Les comptes **Juba** et **Jugurtha** ont été renommés et configurés. Les vérifications affichent `Enabled = True` pour les deux comptes.

```powershell
Get-ADUser -Filter * | Where-Object {$_.SamAccountName -in @('juba','jugurtha')} | Select-Object Name,SamAccountName,Enabled
```

<img width="961" height="1080" alt="w2" src="https://github.com/user-attachments/assets/4c4182be-5b3f-4389-ba23-561b7f60de3e" />


## 3. Vérification du groupe Students

Les deux utilisateurs apparaissent parmi les membres du groupe **Students**.

```powershell
Get-ADGroupMember -Identity 'Students' | Select-Object Name,SamAccountName
```

<img width="955" height="1080" alt="w3" src="https://github.com/user-attachments/assets/9a7b77c0-0586-4df7-b814-1aaf65f20bad" />


## 4. Vérification du dossier partagé

Le partage **SharedResources** pointe vers `C:\SharedResources`.

```powershell
Get-SmbShare -Name 'SharedResources'
```

<img width="964" height="1080" alt="w4" src="https://github.com/user-attachments/assets/0323607a-9bc3-44ed-896d-1cf62f106c69" />


## 5. Vérification des permissions du partage

Les groupes **Students** et **Domain Admins** disposent de la permission de partage `Full`.

```powershell
Get-SmbShareAccess -Name 'SharedResources'
```

<img width="958" height="1080" alt="w5" src="https://github.com/user-attachments/assets/94a40580-4201-4e72-ac58-03c1bd92d408" />


## 6. Vérification de la stratégie de groupe

La stratégie **MapSharedFolder** est liée à l'OU **Students**.

```powershell
Get-GPInheritance -Target 'OU=Students,DC=DC300157423-0,DC=local'
```

<img width="958" height="1080" alt="w6" src="https://github.com/user-attachments/assets/4d4dad85-825b-4be5-8c93-cea3c1acc129" />


## 7. Vérification de l'emplacement de Juba

Le compte Juba se trouve dans l'OU **Students**.

```powershell
Get-ADUser -Identity 'juba' -Properties DistinguishedName | Select-Object Name,DistinguishedName
```

<img width="949" height="1080" alt="w7" src="https://github.com/user-attachments/assets/8f3c6e1f-c8ea-4353-8ffb-164f2521b69c" />


## 8. Vérification de la machine virtuelle Hyper-V

La machine virtuelle **SRV01** est en état `Running`.

```powershell
Get-VM -Name 'SRV01' | Select-Object Name,State
```

<img width="950" height="1080" alt="w8" src="https://github.com/user-attachments/assets/56e5e7ed-e2db-4e7a-ab78-d61269d78aa6" />


## 9. Vérification des GPO et des comptes de l'OU

La GPO **MapSharedFolder** est activée. Les utilisateurs Juba et Jugurtha sont présents et activés dans l'OU Students. Un rapport HTML de la GPO a également été généré sur le Bureau.

```powershell
Get-GPO -All | Select-Object DisplayName,GpoStatus
Get-ADUser -Filter * -SearchBase 'OU=Students,DC=DC300157423-0,DC=local' | Select-Object Name,SamAccountName,Enabled
```

<img width="738" height="540" alt="w9" src="https://github.com/user-attachments/assets/e16f6460-eb35-4774-9579-11af8bda71e1" />


## 10. Test de connexion du lecteur réseau avec Juba

La stratégie **MapSharedFolder** est appliquée à l'utilisateur **Juba**. La commande `net use` affiche le lecteur **Z:** connecté au partage `\\SRV300157423\SharedResources`.

```powershell
net use
```

<img width="432" height="389" alt="w10" src="https://github.com/user-attachments/assets/6e96560f-d444-4ba0-8c34-e21a2c7fa714" />


## 11. Écran de connexion de la machine virtuelle

La machine virtuelle **SRV01** est en cours d'exécution et présente les comptes Juba et Jugurtha sur l'écran de connexion.

![Uploading w11.PNG…]()


## Conclusion

Ce laboratoire m'a permis de pratiquer l'administration d'Active Directory avec Windows Server 2022, Hyper-V et PowerShell. J'ai vérifié les comptes utilisateurs, leur appartenance au groupe Students, le partage de ressources, la stratégie de groupe MapSharedFolder et la connexion du lecteur réseau Z: avec Juba.

