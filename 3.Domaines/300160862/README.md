# Installation et configuration d’un domaine Active Directory

Nom : Yamna Cherif
Numéro étudiant : 300160862
Cours : INF1084 – Administration Windows
Date : 13 octobre 2026

## Introduction

Ce laboratoire consiste à installer et configurer un domaine Active Directory sur Windows Server 2022. L’objectif est de créer un domaine avec le service DNS et de vérifier son installation avec PowerShell et les outils d’administration.

## 1. Vérification de la forêt

La commande Get-ADForest affiche les informations de la forêt DC300160862.local, notamment le domaine racine et le catalogue global.

![Vérification de la forêt](images/foret.png)

## 2. Vérification du domaine

La commande Get-ADDomain affiche les propriétés du domaine DC300160862.local. Le résultat confirme que le domaine est créé.

![Vérification du domaine](images/domaine.png)

## 3. Ouverture du gestionnaire DNS

Le gestionnaire DNS affiche le serveur DC300160862. Le service DNS permet aux ordinateurs de trouver les services du domaine Active Directory.

![Gestionnaire DNS](images/dns.png)

## 4. Vérification du contrôleur de domaine

La commande Start-Process dsa.msc ouvre la console Utilisateurs et ordinateurs Active Directory.

Dans le dossier Domain Controllers, le serveur DC300160862 apparaît avec le type GC, ce qui signifie catalogue global.

![Contrôleur de domaine](images/controleur.png)

## Conclusion

Ce laboratoire m’a permis de configurer le domaine DC300160862.local sur Windows Server 2022. Les commandes Get-ADDomain et Get-ADForest ont confirmé la création du domaine et de la forêt. J’ai également vérifié la présence de mon serveur dans le dossier Domain Controllers.






































































































<img width="2048" height="1536" alt="WhatsApp Image 2026-09-29 at 10 53 34" src="https://github.com/user-attachments/assets/2652f54c-bbf3-45c6-b168-51707fe92a1a" />

<img width="2048" height="1536" alt="WhatsApp Image 2026-09-29 at 10 53 340" src="https://github.com/user-attachments/assets/9fbccef7-bc0e-46f9-ad68-0c4bfba2c8a3" />

<img width="2048" height="1152" alt="WhatsApp Image 2026-09-29 at 10 59 56" src="https://github.com/user-attachments/assets/f0c80d76-a631-4554-bd15-8cde3146c5a6" />

Captures d'écran du travail Active Directory.

Nom : Yamna Cherif  
ID : 300160862
