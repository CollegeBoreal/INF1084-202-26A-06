Laboratoire 3 -Domaine :
Amadou BARRY
300147891
1-Objectif:

Installer et configurer un contrôleur de domaine Active Directory avec DNS intégré sur Windows Server 2022 en utilisant PowerShell.

2. Environnement

* Système : Windows Server 2022 Datacenter
* Adresse IP : 10.7.237.204
* Nom du serveur : SRV300147891
* Domaine : DC300147891.local
* Outil : PowerShell (Administrateur)
  <img width="615" height="667" alt="Capture d&#39;écran 2026-10-13 122353" src="https://github.com/user-attachments/assets/32fcec6e-79ce-410b-9476-c2ceb1f3c3a2" />


3. Étapes réalisées

Étape 1 : Installation du rôle AD DS

J’ai installé le rôle Active Directory Domain Services avec la commande :

Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
L’installation s’est terminée avec succès.

Étape 2 : Création du domaine

J’ai créé une nouvelle forêt Active Directory avec le domaine DC300147891.local à l’aide de la commande Install-ADDSForest.

Le serveur a redémarré automatiquement après l’installation.

<img width="1015" height="672" alt="Capture d&#39;écran 2026-10-13 122407" src="https://github.com/user-attachments/assets/55055b54-b524-4a44-aaa0-f286edcd08ac" />


Étape 3 : Vérification du domaine

J’ai utilisé la commande :Get-ADDomain
<img width="712" height="703" alt="Capture d&#39;écran 2026-10-13 122432" src="https://github.com/user-attachments/assets/f40c5a9a-6412-491c-961b-d32f71d06939" />


Cette commande m’a permis de vérifier que mon domaine était correctement créé.

Étape 4 : Vérification de la forêt

J’ai exécuté : Get-ADForest

<img width="725" height="733" alt="Capture d&#39;écran 2026-10-13 122445" src="https://github.com/user-attachments/assets/5808f5d6-255c-4a55-9b14-96f3b6a7c20a" />


Le résultat confirme que la forêt DC300147891.local est créée et que le serveur fonctionne comme contrôleur de domaine.

4. Conclusion

J’ai réussi à installer et configurer Active Directory sur Windows Server 2022 avec PowerShell. Les commandes de vérification confirment que le domaine et la forêt fonctionnent correctement.
