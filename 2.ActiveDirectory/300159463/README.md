. Objectif du laboratoire
L’objectif de ce laboratoire est de créer un utilisateur Windows portant l’ID étudiant 300159463 et de lui attribuer les droits d’administration du serveur à l’aide de PowerShell. Les étapes ont été réalisées directement sur Windows Server 2022.

. Création de l’utilisateur local
L’utilisateur local 300159463 a ensuite été créé avec son nom complet, une description et les paramètres de mot de passe visibles dans la capture.
New-LocalUser -Name "300159463" `
    -Password $Password `
    -FullName "Hamma Hichem (ID 300159463)" `
    -Description "Admin local Rack2-U13" `
    -PasswordNeverExpires:$true `
    -UserMayNotChangePassword:$true

. Vérification de la création du compte
La commande suivante a permis de vérifier que le compte existe et qu’il est activé :
Get-LocalUser -Name "300159463"
La sortie visible dans la capture indique : Name = 300159463 et Enabled = True. La description affichée est « Admin local Rack2-U13 ».

. Ajout du compte au groupe Administrators
Pour donner les droits d’administration locale, le compte a été ajouté au groupe Administrators :
Add-LocalGroupMember -Group "Administrators" -Member "300159463"

. Vérification des droits administrateur
L’appartenance au groupe Administrators a été vérifiée avec :
Get-LocalGroupMember -Group "Administrators"
Dans la sortie PowerShell, l’utilisateur 300159463 apparaît dans le groupe Administrators avec PrincipalSource = Local. La capture montre également d’autres comptes locaux déjà membres de ce groupe.

. Vérification de la session utilisateur
Une capture de l’écran de connexion Windows montre le nom « Hamma Hichem (ID 300159463) », ce qui constitue une preuve supplémentaire de la création du compte et de son utilisation sur le serveur.
<img width="2000" height="1126" alt="WhatsApp Image 2026-09-23 at 17 23 25" src="https://github.com/user-attachments/assets/2648e039-ac4d-4b13-a48f-01f902ab724b" />
Figure 1 — Création du compte local 300159463 et résultat de la commande New-LocalUser.

<img width="2000" height="1126" alt="WhatsApp Image 2026-09-23 at 17 23 26" src="https://github.com/user-attachments/assets/5d891fae-c321-48d3-b7a6-596010a43e09" />
Figure 2 — Vérification du compte avec Get-LocalUser et ajout au groupe Administrators

<img width="2000" height="1126" alt="WhatsApp Image 2026-09-23 at 17 23 26(1)" src="https://github.com/user-attachments/assets/487ed493-ef05-41eb-ac7e-1d6d3f58ac96" />
Figure 3 — Vérification des membres du groupe Administrators avec Get-LocalGroupMember.

<img width="2000" height="1126" alt="WhatsApp Image 2026-09-23 at 17 23 26(2)" src="https://github.com/user-attachments/assets/34305631-33fd-47f5-881f-bde7dd9b4719" />
Figure 4 — Écran de connexion Windows affichant Hamma Hichem (ID 300159463).

