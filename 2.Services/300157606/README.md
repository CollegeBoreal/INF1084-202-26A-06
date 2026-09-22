


Ouvre ma machine Windows Server 2022 et je connecte avec Administrator.

Ouvre Server Manager → Manage → Add Roles and Features.

Fais Next → Role-based or feature-based installation → Next → sélectionne ton serveur → Next.

Coche Active Directory Domain Services, puis Add Features → Next → Next → Install.

Quand l’installation termine,
Choisis Add a new forest et écris :

				DC300157606-0.local
Puis Next.

Crée ton mot de passe DSRM, puis continue avec Next → Next → Next → Install. Le serveur va redémarrer.

Après le redémarrage, ouvre PowerShell et écris:


Start-Process dsa.msc
Cela ouvre Active Directory Users and Computers.


Va dans DC300157606-0.local → Users, puis fais clic droit → New → User.

Entre :

				First name: Ouahiba
				Last name: Bouzidi
				User logon name: ouahiba
				Puis Next, crée un mot de passe et fais Finish.

Trouve Ouahiba Bouzidi → clic droit → Properties → Member Of → Add. Écris :
Domain Admins
Puis Check Names → OK → Apply → OK.

Pour vérifier, retourne dans Properties → Member Of. Tu dois voir Domain Admins.

le résultat final :

				Domaine : DC300157606-0.local
				Utilisateur : Ouahiba Bouzidi
				Login : ouahiba
				Droits : Domain Admins
