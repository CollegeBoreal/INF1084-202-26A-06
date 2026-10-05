Dans ce travail, j’ai préparé mon serveur Windows Server afin d’installer et de configurer Active Directory Domain Services (AD DS). J’ai vérifié le nom du serveur, sa configuration réseau et les serveurs DNS. Ensuite, j’ai installé le rôle Active Directory et commencé la création d’un nouveau domaine.
<img width="960" height="540" alt="download" src="https://github.com/user-attachments/assets/3cd40589-7859-4d90-bbd8-806df9e509f6" />
Cette capture montre la commande hostname, utilisée pour vérifier le nom de mon serveur. Le nom affiché est SRV300157423. La commande ipconfig permet ensuite de vérifier la configuration réseau du serveur.
<img width="1918" height="1080" alt="image" src="https://github.com/user-attachments/assets/31ce3866-45f6-454a-b642-b7ce822369a8" />
Cette capture montre les informations réseau obtenues avec ipconfig. L’interface Ethernet utilise l’adresse IPv4 10.7.237.215, le masque 255.255.254.0 et la passerelle par défaut 10.7.237.1.
<img width="1904" height="1080" alt="image" src="https://github.com/user-attachments/assets/5ae1c65f-ad9d-4b59-9470-4f1bebb50ef5" />
J’ai utilisé la commande Get-DnsClientServerAddress -AddressFamily IPv4 pour vérifier les serveurs DNS configurés sur les interfaces réseau. Les adresses DNS affichées sont 10.7.237.3 et 8.8.8.8.
<img width="959" height="540" alt="download" src="https://github.com/user-attachments/assets/91383b7e-516d-40e9-8321-93c8c9a2006e" />
Cette capture montre l’installation du rôle Active Directory Domain Services avec la commande Install-WindowsFeature AD-Domain-Services -IncludeManagementTools. Le résultat Success confirme que l’installation du rôle et de ses outils de gestion a réussi.
<img width="960" height="540" alt="download" src="https://github.com/user-attachments/assets/e070cbe6-a8e2-4a16-b225-5f6bc21b8c57" />
Après l’installation d’AD DS, j’ai lancé la création d’une nouvelle forêt Active Directory avec la commande Install-ADDSForest -DomainName "DC300157423-0.local" -InstallDNS. Le système demande ensuite de créer et de confirmer le mot de passe du mode de restauration Active Directory.

<img width="1912" height="1080" alt="image" src="https://github.com/user-attachments/assets/bb235175-e8c3-45ee-9155-57050437f602" />
Cette capture montre la confirmation avant la configuration du serveur comme contrôleur de domaine. Après avoir saisi le même mot de passe deux fois, le système demande si je souhaite continuer l’opération.
<img width="1913" height="1076" alt="image" src="https://github.com/user-attachments/assets/9eda50f4-94c1-4b28-87e2-69aeaa633b80" />
J’ai répondu Y (Yes) pour lancer la configuration. Le serveur commence alors la vérification des prérequis nécessaires à la création du contrôleur de domaine. Le message jaune affiché est un avertissement de Windows Server et non une erreur d’installation.
Conclusion

Dans ce travail, j’ai vérifié la configuration réseau et DNS de mon serveur, installé le rôle Active Directory Domain Services et lancé la création du domaine DC300157423-0.local. Ces étapes permettent de transformer le serveur en contrôleur de domaine et de préparer l’environnement pour la gestion des utilisateurs, des ordinateurs et des ressources du réseau.
