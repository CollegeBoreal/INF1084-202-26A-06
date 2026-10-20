# Laboratoire 2 – Active Directory

**Nom : Yamna Cherif  
**Matricule : 300160862

## Objectif

Créer un utilisateur avec PowerShell dans Active Directory et lui attribuer les droits d’administration sur Windows Server 2022.

## Configuration du serveur

| Élément | Valeur |
|---|---|
| Système | Windows Server 2022 |
| Adresse IP | 10.7.237.232 |
| Domaine | DC300160862.local |
| Utilisateur créé | 300160862 |

## 1. Vérification du domaine

J’ai ouvert Windows PowerShell en tant qu’administrateur, puis exécuté les commandes suivantes :

```powershell
Import-Module ActiveDirectory
Get-ADDomain
```

La première commande charge le module Active Directory. La deuxième affiche les informations du domaine DC300160862.local.

## 2. Préparation des informations

J’ai défini l’identifiant de l’utilisateur et récupéré les informations du domaine. J’ai ensuite saisi le mot de passe de manière masquée.

```powershell
$identifiant = "300160862"
$domaine = Get-ADDomain
$motdepasse = Read-Host "Saisir le mot de passe du nouveau compte" -AsSecureString
```

## 3. Création de l’utilisateur

J’ai créé le compte avec mon matricule comme identifiant :

```powershell
New-ADUser -Name $identifiant -DisplayName "Yamna Cherif" -GivenName "Yamna" -Surname "Cherif" -SamAccountName $identifiant -UserPrincipalName "$identifiant@$($domaine.DNSRoot)" -AccountPassword $motdepasse -Enabled $true -ChangePasswordAtLogon $true
```

Cette commande crée le compte, renseigne mon nom et active l’utilisateur. Elle impose également un changement de mot de passe à la première connexion.

## 4. Vérification de la création

```powershell
Get-ADUser -Identity $identifiant
```

Le résultat confirme les informations suivantes :

| Propriété | Résultat |
|---|---|
| Name | 300160862 |
| GivenName | Yamna |
| Surname | Cherif |
| SamAccountName | 300160862 |
| Enabled | True |
| UserPrincipalName | 300160862@DC300160862.local |

La valeur `Enabled : True` confirme que le compte est activé.

### Capture 1 – Création et activation du compte

<img width="1080" height="1440" alt="WhatsApp Image 2026-10-20 at 15 01 00" src="https://github.com/user-attachments/assets/2cf970e6-baff-4d79-92d6-3c6a718b67d0" />


Cette capture montre la commande de création et le résultat de la vérification du compte dans Active Directory.

## 5. Attribution des droits d’administration

J’ai récupéré le groupe Administrateurs du domaine à partir de son identifiant de sécurité, puis ajouté mon utilisateur à ce groupe :

```powershell
$groupeAdmin = Get-ADGroup -Identity "$($domaine.DomainSID.Value)-512"
Add-ADGroupMember -Identity $groupeAdmin -Members $identifiant
```

Le suffixe `512` identifie le groupe Administrateurs du domaine. L’appartenance à ce groupe attribue au compte des droits d’administration dans le domaine.

## 6. Vérification des droits

J’ai affiché les membres du groupe avec la commande suivante :

```powershell
Get-ADGroupMember -Identity $groupeAdmin | Select-Object Name, SamAccountName
```

Résultat obtenu :

```text
Name           SamAccountName
----           --------------
Administrator  Administrator
300160862      300160862
```

La présence du compte 300160862 confirme son ajout au groupe.

### Capture 2 – Appartenance au groupe Administrateurs du domaine

<img width="1080" height="1440" alt="WhatsApp Image 2026-10-20 at 15 01 00" src="https://github.com/user-attachments/assets/be0a89c4-db9f-4742-8ffb-875817433f38" />


Cette capture montre les commandes d’ajout au groupe et la liste des membres, qui contient mon utilisateur 300160862.

## 7. Test de connexion à distance

J’ai tenté une connexion à distance au serveur 10.7.237.232 avec le compte suivant :

```text
300160862@DC300160862.local
```

Windows a indiqué que le mot de passe devait être changé avant la première connexion. L’ouverture de session à distance a donc été bloquée à cette étape.

La tentative de reconnexion avec Administrator a également échoué. L’aide du professeur a été demandée pour rétablir l’accès et terminer le test.

## Conclusion

Ce laboratoire m’a permis de créer et d’activer un utilisateur Active Directory avec PowerShell, puis de l’ajouter au groupe Administrateurs du domaine.

Les résultats obtenus confirment la création du compte 300160862 et son appartenance au groupe d’administration. Le test de connexion à distance reste à terminer.
