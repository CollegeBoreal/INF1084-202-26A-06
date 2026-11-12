ActiveDirectory
## Laboratoire — Gestion des utilisateurs Windows Server 2022

**Identifiant étudiant :** 300147253

**Machine virtuelle :** VM01

**Objectif :** Créer un utilisateur local et lui attribuer les droits d'administration sur Windows Server 2022 à l'aide de PowerShell.

J'ai ouvert PowerShell en mode administrateur sur ma machine virtuelle VM01. J'ai créé un utilisateur nommé 300147253 à l'aide de la commande `New-LocalUser`.

Ensuite, j'ai ajouté cet utilisateur au groupe local Administrators avec la commande `Add-LocalGroupMember`.

Enfin, j'ai utilisé la commande `net localgroup Administrators` pour vérifier les membres du groupe. Le résultat confirme que l'utilisateur 300147253 possède les droits d'administration locaux.

**Conclusion :** Le compte utilisateur 300147253 a été créé avec succès et ajouté au groupe des administrateurs de Windows Server 2022.
