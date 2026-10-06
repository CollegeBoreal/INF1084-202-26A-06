dans le 1er capteur J’ai installé le rôle Active Directory Domain Services (AD DS) sur Windows Server 2022 à l’aide de PowerShell. L’installation s’est terminée avec succès, comme le confirme le résultat affiché. Ce rôle permet de configurer le serveur comme contrôleur de domaine et de gérer les utilisateurs et les ordinateurs du réseau.
<img width="890" height="605" alt="Capture d&#39;écran 2026-09-29 114012" src="https://github.com/user-attachments/assets/d2daee8d-592a-4892-99e8-d7ddf0da0c85" />


J’ai exécuté la commande Install-ADDSForest pour créer une nouvelle forêt Active Directory. La première tentative a échoué parce que le nom NetBIOS DC300157 était déjà utilisé. Pour résoudre ce problème, j’ai choisi un nom NetBIOS différent, BOREAL, tout en conservant le nom DNS du domaine DC300157.local.
<img width="867" height="627" alt="Capture d&#39;écran 2026-09-29 114105" src="https://github.com/user-attachments/assets/768cce16-beb2-486c-b25b-8c1420df2bb4" />


J’ai utilisé la commande Get-ADDomain dans PowerShell pour vérifier la configuration du domaine Active Directory. Le résultat permet de confirmer le nom du domaine, le nom NetBIOS et les informations relatives au domaine créé.
<img width="814" height="589" alt="Capture d&#39;écran 2026-09-29 120428" src="https://github.com/user-attachments/assets/4a65e83d-3847-4b11-9655-a42791b03a95" />


J’ai exécuté la commande Get-ADForest afin de vérifier la création de la forêt Active Directory. Le résultat affiche les informations de la forêt et confirme sa configuration lorsque la commande s’exécute correctement.
<img width="712" height="394" alt="Capture d&#39;écran 2026-09-29 120440" src="https://github.com/user-attachments/assets/1ed75530-7d90-4769-b227-1bc7e4cdc181" />
<img width="790" height="599" alt="Capture d&#39;écran 2026-09-29 120625" src="https://github.com/user-attachments/assets/a3a39a1f-ae82-4234-93ac-255ee16705c8" />

