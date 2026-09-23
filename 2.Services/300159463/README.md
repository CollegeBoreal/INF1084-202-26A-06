1. Objectif du laboratoire
L’objectif de ce laboratoire est de créer un utilisateur Windows portant l’ID étudiant 300159463 et de lui attribuer les droits d’administration du serveur à l’aide de PowerShell. Les étapes ont été réalisées directement sur Windows Server 2022.
2. Informations du serveur
Système	Windows Server 2022 Datacenter
Adresse IP	10.7.237.7
Compte utilisé pour la configuration	Administrator
Outil utilisé	Windows PowerShell
Utilisateur créé	300159463
Nom complet	Hamma Hichem (ID 300159463)
Description	Admin local Rack2-U13
Groupe administrateur	Administrators
3. Création du mot de passe
Le mot de passe du nouvel utilisateur a été demandé de manière sécurisée avec la commande suivante :
$Password = Read-Host -Prompt "Entrer le mot de passe pour 300159463" -AsSecureString
4. Création de l’utilisateur local
L’utilisateur local 300159463 a ensuite été créé avec son nom complet, une description et les paramètres de mot de passe visibles dans la capture.
New-LocalUser -Name "300159463" `
    -Password $Password `
    -FullName "Hamma Hichem (ID 300159463)" `
    -Description "Admin local Rack2-U13" `
    -PasswordNeverExpires:$true `
    -UserMayNotChangePassword:$true
5. Vérification de la création du compte
La commande suivante a permis de vérifier que le compte existe et qu’il est activé :
Get-LocalUser -Name "300159463"
La sortie visible dans la capture indique : Name = 300159463 et Enabled = True. La description affichée est « Admin local Rack2-U13 ».
6. Ajout du compte au groupe Administrators
Pour donner les droits d’administration locale, le compte a été ajouté au groupe Administrators :
Add-LocalGroupMember -Group "Administrators" -Member "300159463"
7. Vérification des droits administrateur
L’appartenance au groupe Administrators a été vérifiée avec :
Get-LocalGroupMember -Group "Administrators"
Dans la sortie PowerShell, l’utilisateur 300159463 apparaît dans le groupe Administrators avec PrincipalSource = Local. La capture montre également d’autres comptes locaux déjà membres de ce groupe.
8. Vérification de la session utilisateur
Une capture de l’écran de connexion Windows montre le nom « Hamma Hichem (ID 300159463) », ce qui constitue une preuve supplémentaire de la création du compte et de son utilisation sur le serveur.
9. Preuves photographiques
 
Figure 1 — Création du compte local 300159463 et résultat de la commande New-LocalUser.
 
Figure 2 — Vérification du compte avec Get-LocalUser et ajout au groupe Administrators.
 
Figure 3 — Vérification des membres du groupe Administrators avec Get-LocalGroupMember.
 
Figure 4 — Écran de connexion Windows affichant Hamma Hichem (ID 300159463).
10. Conclusion
Le laboratoire a été réalisé avec PowerShell. L’utilisateur local 300159463, correspondant à Hamma Hichem (ID 300159463), a été créé avec succès, activé et ajouté au groupe local Administrators. Les commandes Get-LocalUser et Get-LocalGroupMember ont permis de vérifier respectivement l’existence du compte et ses droits administratifs.

Fin du rapport
