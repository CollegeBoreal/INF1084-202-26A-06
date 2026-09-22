# CREATION DE L'UTILISATEUR

## Définir le mot de passe
$Password = ConvertTo-SecureString "Ngoran225@" -AsPlainText -Force
# Créer l'utilisateur
New-LocalUser `
-Name "300157250" `
-FullName "300157250" `
-Description "Compte administrateur Windows Server 2022" `
-Password $Password `
-PasswordNeverExpires
# Ajouter au groupe Administrateurs
Add-LocalGroupMember `
-Group "Administrators" `
-Member "300157250"
# Vérifications
Get-LocalUser "300157250"
Get-LocalGroupMember "Administrators"
