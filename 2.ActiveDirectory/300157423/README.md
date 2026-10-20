Dans ce travail, l’objectif est de créer un nouvel utilisateur sur Windows Server 2022 à l’aide de PowerShell et de lui donner les droits d’administration. Les commandes utilisées permettent de créer le compte, de l’ajouter au groupe Administrators et de vérifier que la configuration a été effectuée correctement.

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/00e2b996-5b9b-4d0c-85fd-07a60a835ae3" />
Cette capture montre les commandes hostname et whoami, puis la saisie sécurisée du mot de passe. La commande New-LocalUser est utilisée pour créer l’utilisateur 300157423 avec le nom complet Gaya Mahroug et une description liée au TP Active Directory.
<img width="1433" height="1075" alt="image" src="https://github.com/user-attachments/assets/3019d8bb-ac25-4b2e-8cdd-29f8e8fba9a2" />
Cette capture confirme que le compte 300157423 a été créé avec succès. Le champ Enabled affiche True, ce qui indique que le compte est actif sur le serveur.

<img width="893" height="995" alt="image" src="https://github.com/user-attachments/assets/41d7c35a-f44a-455d-b8e7-60f5aa9445e1" />
La commande Add-LocalGroupMember ajoute l’utilisateur 300157423 au groupe Administrators. La commande Get-LocalGroupMember affiche ensuite une erreur, mais une autre méthode de vérification est utilisée avec la commande net localgroup Administrators.
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/8501f03c-0186-4563-828c-c486c80125ad" />
La commande net localgroup Administrators affiche la liste des membres du groupe Administrators. Le compte 300157423 apparaît dans cette liste, ce qui confirme qu’il possède les droits d’administration sur le serveur.
<img width="1913" height="1080" alt="image" src="https://github.com/user-attachments/assets/368d3552-c38e-4ff0-9453-529a65c24c15" />
La commande Get-LocalUser -Name "300157423" permet de vérifier le compte créé. Le résultat montre que le compte est activé (True) et que sa description est « Compte administrateur TP Active Directory ».


Ce laboratoire m’a permis d’utiliser PowerShell pour créer et gérer un utilisateur sous Windows Server 2022. Le compte 300157423 a été créé avec succès puis ajouté au groupe Administrators. Les vérifications finales confirment que le compte est actif et possède les droits d’administration nécessaires.
