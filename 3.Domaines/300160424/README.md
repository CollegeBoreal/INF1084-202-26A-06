Installation et configuration d’un domaine Active Directory (AD DS)
1. Objectif du laboratoire
L’objectif est de préparer et vérifier un contrôleur de domaine Active Directory sous Windows Server 2022, à l’aide de PowerShell, et de confirmer le fonctionnement du domaine, du DNS, des services et de la console d’administration.
Remarque : au moment des vérifications, le rôle AD DS et le domaine étaient déjà installés. Les captures démontrent leur état et leur fonctionnement, mais pas une nouvelle promotion du serveur.
2. Étapes de réalisation
Étape 1 — Vérification du nom du serveur et du réseau
Rename-Computer -NewName "SRV300160424" -Restart
hostname
ipconfig /all
Le renommage n’a pas été effectué, car le serveur portait déjà le nom SRV300160424. La carte Ethernet principale présente l’adresse IPv4 statique 10.7.237.229, le masque 255.255.254.0 et la passerelle 10.7.237.1. D’autres interfaces présentent des adresses automatiques 169.254.x.x : elles méritent une vérification réseau distincte.
 <img width="952" height="473" alt="image" src="https://github.com/user-attachments/assets/1908e4df-6e8f-4e0b-b79e-fa197fc0eebd" />

Figure 1 — Configuration IP relevée avec ipconfig /all.
Étape 2 — Installation du rôle Active Directory Domain Services
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
La commande a retourné Success = True, Restart Needed = No et Exit Code = NoChangeNeeded. Cela confirme que le rôle AD DS et les outils de gestion sont présents, sans nouvelle installation nécessaire.
 <img width="711" height="625" alt="image" src="https://github.com/user-attachments/assets/b31a8e1c-03dc-4844-8ce5-332518ac32b7" />
Figure 2 — Vérification du rôle AD DS.
Étape 3 — Promotion du serveur et création de la forêt
Install-ADDSForest -DomainName "DC300160424.local" -DomainNetbiosName "DC300160424" -InstallDns:$true
Cette commande correspond à la création d’une nouvelle forêt, mais elle n’a pas été relancée dans ce laboratoire, car le domaine existait déjà. Aucune capture ne prouve ici une nouvelle promotion ni son redémarrage.
Étape 4 — Vérification du domaine et de la forêt
Get-ADDomain
Get-ADForest
Get-ADDomain confirme le domaine DC300160424.local et son contrôleur SRV300160424.DC300160424.local. Get-ADForest confirme le domaine racine, le catalogue global et le mode Windows2016Forest.
 <img width="608" height="698" alt="image" src="https://github.com/user-attachments/assets/0c14c4c5-e214-484c-85a6-5e449da74dd6" />
Figure 3 — Résultat de Get-ADDomain.
 <img width="617" height="698" alt="image" src="https://github.com/user-attachments/assets/6b01a4fc-58da-414f-a4a6-6cd8ec8bb8ef" />
Figure 4 — Résultat de Get-ADForest.
Étape 5 — Vérification des services et des partages réseau AD
Get-Service NTDS,DNS,Netlogon,KDC
net share
Les services NTDS, DNS, Netlogon et KDC affichent tous Running. En revanche, la commande net share n’a pas été documentée : la présence des partages SYSVOL et NETLOGON reste à confirmer.
 <img width="744" height="587" alt="image" src="https://github.com/user-attachments/assets/6088f692-dc04-4d67-bf0c-184fda8d8f74" />
Figure 5 — État des quatre services Active Directory.
Étape 6 — Diagnostic DNS et dossier SYSVOL
nslookup DC300160424.local
Test-Path "C:\Windows\SYSVOL\sysvol\DC300160424.local"
La résolution DNS de DC300160424.local retourne 10.7.237.229. Le serveur DNS est affiché Unknown (::1), ce qui n’empêche pas cette résolution. Le test du dossier SYSVOL n’a pas été exécuté dans les preuves fournies et reste à vérifier.
 <img width="743" height="510" alt="image" src="https://github.com/user-attachments/assets/65176a75-0baf-4fd7-82c4-87bbc3a06d1b" />
Figure 6 — Résolution du domaine par nslookup.
Étape 7 — Ouverture de la console d’administration
Start-Process dsa.msc
La console Utilisateurs et ordinateurs Active Directory s’ouvre correctement. Le domaine DC300160424.local et les conteneurs Builtin, Computers, Domain Controllers et Users sont visibles.
 <img width="718" height="538" alt="image" src="https://github.com/user-attachments/assets/919ecb03-187b-4f8c-8861-ae1844d443e8" />
Figure 7 — Console Active Directory et dossiers du domaine.

3. Conclusion 
Le serveur SRV300160424 possède un domaine Active Directory fonctionnel nommé DC300160424.local. Les commandes de vérification du domaine et de la forêt ont réussi, les quatre services principaux sont en cours d’exécution, la résolution DNS fonctionne et la console d’administration s’ouvre correctement.

