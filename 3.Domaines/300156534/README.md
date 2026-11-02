LABORATOIRE – INSTALLATION ET CONFIGURATION
D’UN DOMAINE ACTIVE DIRECTORY (AD DS)

Nom : Oualid Salhi
ID : 300156534
Système : Windows Server 2022 Datacenter
Serveur : SRV300156534
Domaine : DC300156534.local
Introduction et objectif
L’objectif de ce laboratoire est de préparer, installer et vérifier un contrôleur de domaine Active Directory sous Windows Server 2022. Le travail porte sur le rôle AD DS, la création d’un domaine et d’une forêt, l’intégration du DNS et la vérification des éléments principaux de l’environnement.
Laboratoire pratique
Les étapes ci-dessous décrivent la configuration de mon serveur. Les captures jointes servent de preuves pour les opérations visibles. Une commande proposée dans la consigne ne doit pas être relancée si le domaine est déjà créé : Install-ADDSForest sert à promouvoir le serveur et à créer une nouvelle forêt.
Étape 1 – Renommer le serveur et vérifier le réseau
La commande de renommage prévue pour ce laboratoire est :
# Renommer le serveur (à exécuter seulement si le nom doit être modifié)
Rename-Computer -NewName "SRV300156534" -Restart

# Vérifier le nom du serveur
hostname

# Afficher la configuration réseau
ipconfig /all
Le nom du serveur utilisé dans ce laboratoire est SRV300156534. Aucune capture du renommage ou de ipconfig /all n’a été fournie dans les preuves reçues.
Étape 2 – Installer le rôle AD DS
Le rôle AD DS et les outils d’administration sont installés avec la commande suivante :
# Installer le rôle Active Directory Domain Services et les outils de gestion
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools

# Vérifier la présence du rôle AD DS
Get-WindowsFeature AD-Domain-Services
La capture montre Success = True et Exit Code = Success. Cela confirme que l’installation du rôle AD DS a réussi sur le serveur.
Figure 1 – Installation du rôle AD DS
 <img width="870" height="924" alt="image" src="https://github.com/user-attachments/assets/034e92fc-4f82-4457-9834-b4fbbe824b3d" />

Étape 3 – Créer le domaine et la forêt
Le domaine configuré est DC300156534.local et son nom NetBIOS est DC300156534. La commande de promotion correspondant à la consigne est présentée ci-dessous. Le domaine étant déjà créé sur mon serveur, cette commande ne doit pas être exécutée une deuxième fois sur le même contrôleur de domaine.
# Créer une nouvelle forêt et installer DNS (exemple de commande de promotion)
Install-ADDSForest `
    -DomainName "DC300156534.local" `
    -DomainNetbiosName "DC300156534" `
    -InstallDns:$true `
    -SafeModeAdministratorPassword (Read-Host "Entrez le mot de passe DSRM" -AsSecureString) `
    -Force
Le mot de passe DSRM est saisi de manière sécurisée avec Read-Host et n’est pas inscrit en clair dans le rapport. La création de la forêt entraîne normalement le redémarrage du serveur.
Étape 4 – Vérifier le domaine et la forêt
# Vérifier les informations du domaine
Get-ADDomain

# Vérifier les informations de la forêt
Get-ADForest
Les résultats visibles confirment le domaine DC300156534.local, le nom NetBIOS DC300156534 et le contrôleur de domaine SRV300156534.DC300156534.local. La forêt porte également le nom DC300156534.local.
Figure 2 – Résultat de Get-ADDomain
 <img width="870" height="875" alt="image" src="https://github.com/user-attachments/assets/c7870827-1717-4065-abf9-07160e754397" />

Figure 3 – Résultat de Get-ADForest
 <img width="870" height="996" alt="image" src="https://github.com/user-attachments/assets/67d97ab8-c3d3-4c0a-ac61-8eab2f420d11" />

Étape 5 – Vérifier DNS
DNS permet aux ordinateurs de localiser le contrôleur de domaine et les services Active Directory. Le gestionnaire DNS a été ouvert et le serveur SRV300156534 y apparaît.
# Ouvrir le gestionnaire DNS
dnsmgmt.msc

# Vérifier la résolution du nom du domaine (vérification supplémentaire)
nslookup DC300156534.local
Figure 4 – Serveur SRV300156534 visible dans DNS Manager
 <img width="870" height="953" alt="image" src="https://github.com/user-attachments/assets/a00c7c08-b61f-41c4-a6ea-ea93c3157d00" />

La capture fournie montre le serveur dans DNS Manager. Elle ne montre pas les zones DNS développées et ne constitue pas une capture de la commande nslookup.
Étape 6 – Se connecter avec le compte du domaine
Après la promotion du serveur et son redémarrage, la consigne demande d’utiliser le compte Administrator du domaine. Le format de connexion attendu pour mon domaine est :
DC300156534\Administrator
La connexion avec ce compte doit être vérifiée sur le serveur. Aucune capture de cette ouverture de session n’a été fournie parmi les quatre captures reçues.
Étape 7 – Ouvrir la console Active Directory
# Ouvrir la console Utilisateurs et ordinateurs Active Directory
Start-Process dsa.msc
Cette commande ouvre la console de gestion des utilisateurs, groupes, ordinateurs et unités d’organisation. Une capture de cette console peut être ajoutée comme preuve après son ouverture.
Résultat récapitulatif
Élément	Configuration
Système	Windows Server 2022 Datacenter
Serveur	SRV300156534
Domaine	DC300156534.local
Nom NetBIOS	DC300156534
Rôle	Active Directory Domain Services
Forêt	DC300156534.local
DNS	Serveur visible dans DNS Manager
Conclusion
Ce laboratoire m’a permis d’étudier le fonctionnement d’Active Directory et de vérifier la configuration d’un contrôleur de domaine sous Windows Server 2022. J’ai documenté l’installation du rôle AD DS, le domaine DC300156534.local, le nom NetBIOS DC300156534, ainsi que les vérifications du domaine, de la forêt et du DNS. Les captures fournies confirment l’installation du rôle AD DS, les informations retournées par Get-ADDomain et Get-ADForest, ainsi que la présence du serveur dans DNS Manager. Les vérifications supplémentaires mentionnées sans capture doivent être exécutées et documentées avant de les présenter comme réalisées.
Preuve supplémentaire – Console Active Directory
La console Utilisateurs et ordinateurs Active Directory s’ouvre correctement. Le domaine DC300156534.local est développé et les conteneurs Builtin, Computers, Domain Controllers, ForeignSecurityPrincipals, Managed Service Accounts et Users sont visibles.
Figure 5 – Console Active Directory avec le domaine développé
 <img width="870" height="903" alt="image" src="https://github.com/user-attachments/assets/99019d8e-3181-49b4-b4a3-e5fcf7a1baef" />

Preuve supplémentaire – Vérification du compte connecté
La commande whoami a été exécutée dans PowerShell. Le résultat affiché est dc300156534\administrator, ce qui confirme que la session utilise le compte Administrator du domaine DC300156534.
Figure 6 – Vérification du compte connecté avec whoami
 <img width="870" height="883" alt="image" src="https://github.com/user-attachments/assets/42dd7b80-bce0-4f32-b894-9c7f69f5cc3e" />



