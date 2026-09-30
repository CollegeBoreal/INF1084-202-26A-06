Cette capture d’écran montre Windows PowerShell sur un serveur Windows. La commande Install-WindowsFeature AD-Domain-Services -IncludeManagementTools a été exécutée avec succès.
<img width="890" height="605" alt="661424340-d2daee8d-592a-4892-99e8-d7ddf0da0c85" src="https://github.com/user-attachments/assets/2b4e7f78-8def-41f7-b14e-ba044a413694" />
La configuration du domaine Active Directory est en cours. PowerShell vérifie les prérequis nécessaires à la création du contrôleur de domaine et affiche un avertissement concernant un paramètre de sécurité compatible avec Windows NT 4.0. Cet avertissement n’empêche pas la poursuite de l’installation.
<img width="867" height="627" alt="661423070-768cce16-beb2-486c-b25b-8c1420df2bb4" src="https://github.com/user-attachments/assets/98b04319-c4ce-4b20-97b2-18d53c19aad5" />
La commande confirme que le domaine DC300159693.local a été créé correctement. Elle affiche les informations du domaine, notamment le nom DNS, le nom NetBIOS, la forêt, le contrôleur de domaine et les différents conteneurs Active Directory.
<img width="1536" height="2048" alt="37e52f1a-61e3-4143-b050-f295ee887a98" src="https://github.com/user-attachments/assets/e4e6cccc-5913-4e73-a235-c70b5f662bfc" />
La commande confirme que la forêt DC300159693.local est correctement configurée. Elle affiche notamment le nom de la forêt, le domaine, le catalogue global et le contrôleur de domaine.
<img width="1536" height="2048" alt="c386f115-6dd1-4068-a9a6-dd1b0bbb0ec9" src="https://github.com/user-attachments/assets/0d648ba6-8faa-44e2-a63b-ef7efd1d4562" />
La commande confirme que le serveur SRV300159693 fonctionne comme contrôleur de domaine du domaine DC300159693.local. Elle affiche notamment son adresse IP, le système Windows Server 2022 Datacenter, le catalogue global et les rôles Active Directory.
<img width="1536" height="2048" alt="1df5a146-0d27-4e81-89d4-177b195c5261" src="https://github.com/user-attachments/assets/b4eb4a57-b855-4e6c-80ad-14deaf5ce242" />
Le service Netlogon est en état Running (en cours d’exécution). Cela confirme que le service nécessaire au fonctionnement et à l’authentification du domaine Active Directory est actif.
<img width="1536" height="2048" alt="6a63febb-6608-4d63-a10e-f0210c7e4f87" src="https://github.com/user-attachments/assets/1b784620-be9f-4dd2-9b51-4956966a826c" />
les partages réseau du serveur sont présents, notamment NETLOGON et SYSVOL, nécessaires au fonctionnement d’Active Directory.
<img width="1536" height="2048" alt="1aa3d3a5-b46b-41cf-bb1f-585f2b5ec854" src="https://github.com/user-attachments/assets/cf8e49a4-73da-4e74-84c0-173e7db530b9" />
Le diagnostic confirme que plusieurs tests Active Directory sont réussis, notamment la connectivité, l’annonce du contrôleur de domaine, les événements FRS et la vérification de SYSVOL. Un avertissement apparaît au test DFSR, indiquant des événements liés à la réplication SYSVOL au cours des dernières 24 heures.
<img width="1536" height="2048" alt="4f2f9a05-43ee-4072-a410-15eedba828e7" src="https://github.com/user-attachments/assets/65749be3-6541-4fd4-a17e-4bf3a7c78e12" />
<img width="1536" height="2048" alt="eab2ad16-104f-47be-b8fe-abefd253a1a6" src="https://github.com/user-attachments/assets/032f9669-4b58-4361-b82e-55a2348951e1" />
<img width="1536" height="2048" alt="19548bc1-2033-4664-80f4-60d2edc3f6aa" src="https://github.com/user-attachments/assets/563000de-f5bf-4e7a-8410-badfeeb604c6" />
<img width="1536" height="2048" alt="39fd0925-cf13-4368-b220-cc8a1b83cd9a" src="https://github.com/user-attachments/assets/5d2b47f2-b25e-4a04-9da1-5871da0dcd43" />
La commande confirme que tous les contrôleurs de domaine ont effectué correctement la migration vers l’état global « Eliminated » et que la migration est dans un état cohérent sur tous les contrôleurs de domaine. Le résultat indique Succeeded.
<img width="1536" height="2048" alt="9fbadcc2-07f5-44ec-9082-8cd0425faa9e" src="https://github.com/user-attachments/assets/aaf1ca7d-46d2-4961-ab76-58ad1a1ae5eb" />
