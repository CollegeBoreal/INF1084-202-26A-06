# INF1084 — Laboratoire 5 : Objects

**Collège Boréal — Technique des systèmes informatiques**  
**Numéro étudiant :** 300160733  
**Serveur :** SRV300160733  
**Domaine :** DC300160733.local  
**Environnement :** Windows Server 2022, Active Directory, PowerShell et stratégies de groupe (GPO)



## 1. Domaine Active Directory, utilisateurs et groupe Students

J'ai vérifié le domaine `DC300160733.local`, le groupe **Students** et les comptes **Etudiant1** et **Etudiant2**. Les commandes `Get-ADGroupMember` et `Get-ADObject` permettent de voir les objets présents dans l'OU Students.

<img width="1111" height="444" alt="01_domaine_et_groupe" src="https://github.com/user-attachments/assets/f6dbe371-71f9-4b62-81ff-799bded7e35a" />


<img width="1077" height="1031" alt="02_partage_et_groupe" src="https://github.com/user-attachments/assets/15965ec9-41d9-44b2-afde-a3d31746f988" />


<img width="975" height="927" alt="03_objets_ou_students" src="https://github.com/user-attachments/assets/92867ca3-7804-4bb9-9476-b935e0c47eb4" />


## 2. Dossier partagé et autorisations

Le dossier `C:\SharedResources` a été créé sur le serveur et partagé sous le nom **SharedResources**. J'ai vérifié les autorisations SMB et NTFS à l'aide de PowerShell. Le groupe Students possède les droits configurés pour accéder au partage.

<img width="1060" height="1052" alt="04_permissions_smb" src="https://github.com/user-attachments/assets/7fc73805-7bc2-4cd6-9037-9abd54bfd729" />


<img width="1096" height="1046" alt="05_permissions_ntfs" src="https://github.com/user-attachments/assets/68447d39-ca8e-4391-bc7e-1c6dc1f37b33" />


<img width="1062" height="1036" alt="06_verification_compte_serveur" src="https://github.com/user-attachments/assets/871910a8-7142-4383-bfd9-ef490685fefc" />


## 3. GPO MapSharedFolder et lecteur Z:

J'ai configuré la GPO **MapSharedFolder** pour lancer la connexion du lecteur réseau `Z:` à l'ouverture de session. Le chemin utilisé est `\\SRV300160733\SharedResources`. J'ai ensuite consulté le rapport HTML et vérifié que la GPO était liée à l'OU Students.

<img width="1920" height="866" alt="07_rapport_gpo_map" src="https://github.com/user-attachments/assets/3e62e606-50ea-4dad-bcb9-d3c3fee4f2a3" />


<img width="1920" height="866" alt="07_rapport_gpo_map" src="https://github.com/user-attachments/assets/3c06944f-91c1-4c2f-b980-0c64becca233" />


<img width="1920" height="831" alt="08_configuration_lecteur_z" src="https://github.com/user-attachments/assets/7dccfc2e-1b2a-427e-95f2-1fffc0c8ab7a" />


<img width="1044" height="1019" alt="09_gpo_et_liens_ou" src="https://github.com/user-attachments/assets/35428236-df42-456b-88c5-9611ba62ddd2" />



## 4. GPO Allow-RDP-Students

La GPO **Allow-RDP-Students** a été créée pour préparer l'accès Bureau à distance. Le rapport montre la règle **Autoriser RDP TCP**, utilisant le protocole TCP et le port **3389**. Le groupe **Students** est aussi ajouté au groupe local **Remote Desktop Users** dans les préférences de stratégie.

<img width="1920" height="980" alt="10_gpo_rdp_regle" src="https://github.com/user-attachments/assets/1d8a2be5-ac8e-422c-895e-0037c2b512be" />


<img width="1917" height="1040" alt="11_gpo_rdp_parametres" src="https://github.com/user-attachments/assets/f0a82635-16f7-4379-9031-76b2d22bba15" />


<img width="1920" height="1073" alt="12_gpo_rdp_groupe" src="https://github.com/user-attachments/assets/d070926f-a916-466c-b52a-9e34a486c4e0" />


## 5. Essais sur le poste client

J'ai utilisé un poste Windows 10 pour vérifier la connexion réseau et essayer de joindre le domaine. Le test `ping` vers le serveur a répondu. J'ai aussi testé la résolution du nom de domaine. La jonction au domaine a toutefois rencontré un problème d'identifiants, et je n'ai pas confirmé de test final réussi du lecteur `Z:` ni de connexion RDP depuis ce client.

<img width="816" height="745" alt="13_client_ping" src="https://github.com/user-attachments/assets/a8aa0566-4a96-40ce-9f55-64e81cddf623" />


<img width="592" height="700" alt="14_client_dns" src="https://github.com/user-attachments/assets/d7a23abe-aa7f-4617-b01d-8f01b4a262d2" />


<img width="990" height="698" alt="15_client_jointure_erreur" src="https://github.com/user-attachments/assets/1a013dd5-a423-41c5-a62f-1fa2479b81ff" />


## 6. Scripts PowerShell

J'ai préparé les scripts **`utilisateurs1.ps1`** et **`utilisateurs2.ps1`** et conservé `bootstrap.ps1`. Le premier sert à préparer ou vérifier le groupe Students et le partage. Le second vérifie la GPO MapSharedFolder et génère un rapport HTML. Je n'ai pas relancé les scripts de création sur les objets déjà configurés.

<img width="1051" height="1024" alt="16_script_1" src="https://github.com/user-attachments/assets/17f8b4a3-cd3b-425a-88d0-93e4305fdf69" />


<img width="1050" height="1044" alt="17_script_2" src="https://github.com/user-attachments/assets/9af39bcb-eb79-4e15-b0e4-184bb347203c" />


## 7. Vérification des fichiers et envoi sur GitHub

J'ai enregistré mon travail dans le dossier `5.Objects/300160733`. L'envoi a demandé plusieurs vérifications à cause de chemins incompatibles avec Windows dans le dépôt partagé. J'ai finalement créé un commit contenant uniquement les fichiers de mon laboratoire et réussi à l'envoyer sur GitHub.

<img width="1146" height="911" alt="18_fichiers_laboratoire" src="https://github.com/user-attachments/assets/4f38d6b5-a4e9-4cbf-a4e3-5cd3002b829b" />


<img width="1064" height="337" alt="19_commit_neuf_fichiers" src="https://github.com/user-attachments/assets/206bed23-832e-4b65-8552-3a17300f8c6e" />


<img width="1134" height="431" alt="20_push_github_reussi" src="https://github.com/user-attachments/assets/3927dc97-9344-45cc-b5a4-02fc10e65ec6" />


## 8. Difficultés rencontrées

J'ai eu des difficultés avec la connexion du poste Windows 10 au domaine, certains paramètres réseau et les identifiants de connexion. J'ai aussi rencontré des erreurs Git pendant la récupération du dépôt, car certains noms de fichiers du dépôt partagé ne sont pas compatibles avec Windows. Avec les commandes de vérification, j'ai pu conserver mes fichiers et réussir l'envoi de mon travail.

## Conclusion

Ce laboratoire m'a permis de mieux comprendre Active Directory, les utilisateurs, les groupes, les permissions de partage et les GPO. J'ai appris à vérifier les résultats dans PowerShell et à présenter mes preuves avec des captures d'écran. Les configurations principales sont faites et mon travail est publié sur GitHub. Les tests finaux du lecteur Z: et du Bureau à distance sur un client restent à confirmer.

## Rapports et scripts

- [GPO MapSharedFolder](GPO_MapSharedFolder.html)
- [GPO Allow-RDP-Students](GPO_Allow-RDP-Students.html)
- [Rapport de vérification MapSharedFolder](Verification_MapSharedFolder.html)
- [Rapport de vérification RDP](Verification_RDP.html)
- [Script utilisateurs1.ps1](utilisateurs1.ps1)
- [Script utilisateurs2.ps1](utilisateurs2.ps1)
