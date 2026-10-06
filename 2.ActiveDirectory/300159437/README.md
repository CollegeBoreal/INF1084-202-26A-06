# 🖥️ Création d'un utilisateur administrateur — Windows Server 2022
🎯 Objectif

Créer l'utilisateur 300159437 sur Windows Server 2022 et lui attribuer les droits d'administration à l'aide de PowerShell.

## Résumé

Ce laboratoire consiste à créer un nouvel utilisateur nommé **300159437** sur **Windows Server 2022** à l’aide de **PowerShell**.

La première étape permet de créer un mot de passe sécurisé avec la commande `Read-Host` et l’option `-AsSecureString`.

Ensuite, la commande `New-LocalUser` est utilisée pour créer le compte **300159437** avec le mot de passe défini précédemment et la description **« Compte administrateur du laboratoire »**.

L’objectif final est de donner à cet utilisateur les **droits d’administration** afin qu’il puisse effectuer des tâches administratives sur le serveur.

# 1. Créer le mot de passe
$password = Read-Host "Entrer le mot de passe" -AsSecureString
# 2. Créer l'utilisateur
New-LocalUser -Name "300159437" `
-Password $password `
-Description "Compte administrateur du laboratoire"
# 3. Ajouter l'utilisateur au groupe Administrators
Add-LocalGroupMember -Group "Administrators" -Member "300159437"
# 4. Vérifier la création de l'utilisateur
Get-LocalUser -Name "300159437"
# 5. Vérifier les droits administrateur
Get-LocalGroupMember -Group "Administrators"

L'utilisateur 300159437 doit apparaître dans la liste des membres du groupe Administrators.

✅ Résultat
<img src="images/WhatsApp%20Image%202026-09-26%20at%2020.45.06%20(1).jpeg" width="50%" height="50%">

L'utilisateur 300159437 a été créé sur Windows Server 2022 et ajouté au groupe Administrators. Il possède maintenant les privilèges administratifs locaux sur le serveur.
