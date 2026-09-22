# 🖥️ Création d'un utilisateur administrateur — Windows Server 2022
🎯 Objectif

Créer l'utilisateur 300159437 sur Windows Server 2022 et lui attribuer les droits d'administration à l'aide de PowerShell.

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

L'utilisateur 300159437 a été créé sur Windows Server 2022 et ajouté au groupe Administrators. Il possède maintenant les privilèges administratifs locaux sur le serveur.
