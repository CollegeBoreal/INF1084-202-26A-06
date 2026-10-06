Rapport de laboratoire — Installation et configuration d’Active Directory
<img width="824" height="711" alt="E" src="https://github.com/user-attachments/assets/b5ad4513-0640-48a6-9988-4983b102799f" />
<img width="824" height="711" alt="E" src="https://github.com/user-attachments/assets/ff0c75ef-4e5e-4388-b9d4-68dcb041c6ad" />
 Objectif
L’objectif de ce laboratoire était d’installer et de configurer un domaine Active Directory Domain Services (AD DS) sur Windows Server 2022, puis de vérifier le bon fonctionnement du contrôleur de domaine, du DNS et de SYSVOL.

Configuration réalisée
Le serveur a été configuré avec les informations suivantes :
•	Nom du serveur : SRV300159463
•	Nom du domaine : DC300159463.local
•	Nom NetBIOS : DC300159463
•	Adresse IPv4 : 10.7.237.224
•	Système d’exploitation : Windows Server 2022 Datacenter
Le rôle Active Directory Domain Services ainsi que le service DNS ont été installés. Une nouvelle forêt et un nouveau domaine DC300159463.local ont ensuite été créés.



<img width="871" height="687" alt="A" src="https://github.com/user-attachments/assets/d030a6a0-82d1-4f0c-934c-363964a4c813" />


 Vérification du domaine
La commande suivante a été utilisée :
Get-ADDomain
Le résultat confirme que le domaine DC300159463.local existe et que le contrôleur de domaine SRV300159463 est correctement associé au domaine.
Le niveau fonctionnel du domaine est :
Windows2016Domain



<img width="850" height="691" alt="C" src="https://github.com/user-attachments/assets/3f063dcf-dd2c-430a-92ab-241e0655a5eb" />



Vérification des services
La commande suivante a été exécutée :
Get-Service NTDS,DNS,Netlogon
Les trois services sont en état Running :
DNS       Running
Netlogon  Running
NTDS      Running
Cela confirme que les principaux services nécessaires au fonctionnement d'Active Directory sont actifs.



<img width="824" height="711" alt="E" src="https://github.com/user-attachments/assets/503487b2-62c3-4c35-9699-1ee26d0fbe42" />


Vérification du DNS
La résolution du domaine a été testée avec :
Resolve-DnsName "DC300159463.local"
Le domaine est correctement résolu vers l'adresse :
10.7.237.224
Un enregistrement SRV a également été vérifié :
Resolve-DnsName -Type SRV "_ldap._tcp.dc._msdcs.DC300159463.local"
Le contrôleur srv300159463.dc300159463.local est correctement retourné avec l'adresse 10.7.237.224.
Cette vérification confirme que le DNS permet aux clients de localiser les services Active Directory.


Conclusion:

Les différentes vérifications effectuées montrent que le domaine DC300159463.local a été correctement installé et configuré sur Windows Server 2022.
Le contrôleur de domaine SRV300159463, les services AD DS, DNS et Netlogon, la résolution DNS ainsi que le dossier SYSVOL fonctionnent correctement.
L'environnement Active Directory est donc prêt pour les prochaines étapes du laboratoire, telles que la création d'utilisateurs, de groupes et d'unités d'organisation (OU).














