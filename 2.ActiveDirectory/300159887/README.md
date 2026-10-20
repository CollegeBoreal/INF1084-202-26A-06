Dans ce laboratoire, j’ai créé un utilisateur local hammichebillal06-dot avec l’ID étudiant 300159887 sur un serveur Windows Server 2022 Datacenter à l’aide de PowerShell.

Les principales étapes réalisées sont :
   Ouvrir PowerShell en tant qu’administrateur.
   Créer le mot de passe de manière sécurisée.
   Créer l’utilisateur hammichebillal06-dot.
   Vérifier que le compte a bien été créé et activé.
   Ajouter l’utilisateur au groupe Administrators.
   Vérifier son appartenance au groupe Administrators.

La commande principale utilisée pour donner les droits administrateur est :

Add-LocalGroupMember -Group "Administrators" -Member "hammichebillal06-dot"

Conclusion : l’utilisateur hammichebillal06-dot a été créé avec succès et possède maintenant les droits d’administration sur le serveur Windows Server 2022.
