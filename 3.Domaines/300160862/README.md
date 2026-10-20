# Installation et configuration d’un domaine Active Directory

Nom : Yamna Cherif
Numéro étudiant : 300160862
Cours : INF1084 – Administration Windows
Date : 13 octobre 2026

## Introduction

Ce laboratoire consiste à installer et configurer un domaine Active Directory sur Windows Server 2022. L’objectif est de créer un domaine avec le service DNS et de vérifier son installation avec PowerShell et les outils d’administration.

## 1. Vérification de la forêt

La commande Get-ADForest affiche les informations de la forêt DC300160862.local, notamment le domaine racine et le catalogue global.

<img width="1080" height="1440" alt="IMG_52923916-A536-413F-933C-1731191A3ED1" src="https://github.com/user-attachments/assets/b478a026-8413-4ccd-8108-510b8e2507bf" />


## 2. Vérification du domaine

La commande Get-ADDomain affiche les propriétés du domaine DC300160862.local. Le résultat confirme que le domaine est créé.

<img width="1080" height="1440" alt="IMG_56BE5E02-DCCB-460C-BCED-1F0B1EED1581" src="https://github.com/user-attachments/assets/c7f0cdc0-54ea-4444-a719-1a169871704f" />


## 3. Ouverture du gestionnaire DNS

Le gestionnaire DNS affiche le serveur DC300160862. Le service DNS permet aux ordinateurs de trouver les services du domaine Active Directory.

<img width="1080" height="1440" alt="IMG_52923916-A536-413F-933C-1731191A3ED1 (1)" src="https://github.com/user-attachments/assets/3408877e-743c-4529-9ace-84df751a2e98" />


## 4. Vérification du contrôleur de domaine

La commande Start-Process dsa.msc ouvre la console Utilisateurs et ordinateurs Active Directory.

Dans le dossier Domain Controllers, le serveur DC300160862 apparaît avec le type GC, ce qui signifie catalogue global.

<img width="1080" height="1440" alt="IMG_52923916-A536-413F-933C-1731191A3ED1 (1)" src="https://github.com/user-attachments/assets/36ea6c26-adc4-4d01-a1bf-91b40afdba0c" />


## Conclusion

Ce laboratoire m’a permis de configurer le domaine DC300160862.local sur Windows Server 2022. Les commandes Get-ADDomain et Get-ADForest ont confirmé la création du domaine et de la forêt. J’ai également vérifié la présence de mon serveur dans le dossier Domain Controllers.






































































































