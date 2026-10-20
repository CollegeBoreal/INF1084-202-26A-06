### Vérification du serveur et du rôle AD DS :

Cette capture confirme que le serveur porte le nom `SRV300160733`. Le rôle **Active Directory Domain Services (AD DS)** est également installé correctement sur Windows Server.

<img width="1050" height="996" alt="image" src="https://github.com/user-attachments/assets/53da22ec-be51-4ce5-894e-8f74f765deb5" />

### Vérification du domaine Active Directory :

La commande `Get-ADDomain` permet de vérifier la configuration du domaine. On confirme ici que le domaine `DC300160733.local` est correctement configuré et associé au serveur `SRV300160733`.

<img width="1049" height="1020" alt="image" src="https://github.com/user-attachments/assets/d9788bb8-6106-488d-8a0a-00e17b22d327" />

### Vérification de la forêt Active Directory :

La commande `Get-ADForest` affiche les informations de la forêt Active Directory. La forêt principale est `DC300160733.local` et le serveur `SRV300160733` est utilisé comme contrôleur de domaine.

<img width="1049" height="1005" alt="image" src="https://github.com/user-attachments/assets/f8930fce-2ecb-469d-a82d-8c16a90fdc2d" />

### Ouverture de la console Active Directory :

La commande `Start-Process dsa.msc` permet d’ouvrir la console **Active Directory Users and Computers**. Le domaine `DC300160733.local` apparaît correctement dans la console.

<img width="1158" height="1047" alt="image" src="https://github.com/user-attachments/assets/79371bd5-34a1-44d9-bfab-dbd472a27a86" />

### Affichage de la structure du domaine :

Cette capture montre les principaux conteneurs du domaine `DC300160733.local`, notamment **Computers**, **Domain Controllers** et **Users**.

<img width="1182" height="1013" alt="image" src="https://github.com/user-attachments/assets/2a5ea045-d561-44cb-8563-e66e53221599" />

### Vérification du contrôleur de domaine

Dans le dossier **Domain Controllers**, le serveur `SRV300160733` est présent. Cela confirme qu’il est correctement configuré comme contrôleur du domaine `DC300160733.local`.

<img width="1292" height="1059" alt="image" src="https://github.com/user-attachments/assets/2743471e-2b5e-4564-9338-d0dc7942eb61" />

