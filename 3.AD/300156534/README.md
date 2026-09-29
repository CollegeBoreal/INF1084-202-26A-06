Installation et configuration d’Active Directory

Serveur : SRV300156534

Domaine : DC300156534.local

1. Objectif

L’objectif de ce laboratoire était d’installer et de configurer Active Directory Domain Services (AD DS) sur Windows Server 2022 afin de créer un domaine Active Directory fonctionnel.

2. Installation du rôle AD DS

J’ai installé le rôle Active Directory Domain Services avec PowerShell. Le résultat indique « Success : True », ce qui confirme que le rôle AD DS a été installé correctement.

3. Création du domaine

J’ai créé une nouvelle forêt avec le domaine DC300156534.local et le nom NetBIOS DC300156534. Le DNS a également été installé avec la création de la forêt.

4. Vérification du domaine

Après le redémarrage du serveur, j’ai utilisé la commande Get-ADDomain. Le résultat confirme que le domaine est DC300156534.local et que le contrôleur de domaine est SRV300156534.DC300156534.local.

5. Vérification de la forêt

J’ai ensuite utilisé la commande Get-ADForest. Le résultat confirme que la forêt est DC300156534.local et que SRV300156534.DC300156534.local est le contrôleur global.

6. Vérification du DNS

J’ai ouvert DNS Manager afin de vérifier la configuration DNS. Le serveur SRV300156534 apparaît dans le gestionnaire DNS.

7. Résultat

Les différentes vérifications montrent que le domaine Active Directory, la forêt et la configuration DNS ont été créés correctement.

8. Conclusion

Ce laboratoire m’a permis de pratiquer l’installation d’AD DS, la création d’un domaine et d’une forêt Active Directory, ainsi que la vérification de la configuration avec PowerShell et DNS Manager.


Captures d’écran des étapes réalisées

Capture 1 – Installation du rôle AD DS
<img width="608" height="646" alt="Screenshot 2026-09-29 114113" src="https://github.com/user-attachments/assets/5643cf89-5b82-4602-aa5a-ecf14d5fc7b4" />


Capture 2 – Vérification du domaine avec Get-ADDomain
<img width="660" height="664" alt="Screenshot 02 2026-09-29 115822" src="https://github.com/user-attachments/assets/8008d4ac-8c04-4d3e-a9ac-aa150324ae9e" />


Capture 3 – Vérification de la forêt avec Get-ADForest
<img width="670" height="767" alt="Screenshot 03 2026-09-29 120011" src="https://github.com/user-attachments/assets/bd148db1-7c52-4626-ae32-a9d6bf87e1d5" />

Capture 4 – Vérification avec DNS Manager
<img width="696" height="762" alt="Screenshot 04 2026-09-29 120740" src="https://github.com/user-attachments/assets/3cc64c55-de4a-47d2-9bf4-f9596f455d77" />




