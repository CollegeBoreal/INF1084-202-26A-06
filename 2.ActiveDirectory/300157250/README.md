# CREATION DE L'UTILISATEUR

Définir le mot de passe<br>
$Password = ConvertTo-SecureString "Ngoran225@" -AsPlainText -Force<br>
Créer l'utilisateur<br>
New-LocalUser `<br>
-Name "300157250" `<br>
-FullName "300157250" `<br>
-Description "Compte administrateur Windows Server 2022" `<br>
-Password $Password `<br>
-PasswordNeverExpires<br>
Ajouter au groupe Administrateurs<br>
Add-LocalGroupMember `<br>
-Group "Administrators" `<br>
-Member "300157250"<br>
Vérifications<br>
Get-LocalUser "300157250"<br>
Get-LocalGroupMember "Administrators"<br>
