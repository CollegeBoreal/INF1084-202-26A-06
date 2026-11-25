TP – Objets gérables par Active Directory

Collège Boréal | INF1084 – Administration Windows

Étudiant : Youcef Laziz

Matricule : 300160424

1. Introduction et environnement
   
Le but de ce TP est de gérer les utilisateurs et les groupes Active Directory, de configurer un dossier partagé, un lecteur réseau Z: et les accès au Bureau à distance. J’ai utilisé Windows Server 2022 et PowerShell. Mon serveur est SRV300160424 (10.7.237.229) et mon domaine est DC300160424.local.

 <img width="1049" height="465" alt="image" src="https://github.com/user-attachments/assets/c9bed9ee-ea8d-46e5-8488-fdb6c31162bf" />

Figure 1 – Variables du fichier bootstrap.ps1.

 2. Groupe et utilisateurs

J’ai vérifié le groupe de sécurité global Students et les comptes Etudiant1 et Etudiant2. Les deux utilisateurs sont dans l’OU Students et sont membres du groupe.

 <img width="1130" height="495" alt="image" src="https://github.com/user-attachments/assets/81b6ae62-b874-4bdd-be39-76a8929dd6cd" />

Figure 2 – Groupe Students et compte Etudiant1.

 <img width="1129" height="495" alt="image" src="https://github.com/user-attachments/assets/0699e788-aa6b-4630-a251-6de0c5732be8" />

Figure 3 – Membres du groupe Students.

 3. Partage SMB et permissions NTFS
    
J’ai configuré le partage SharedResources vers C:\SharedResources. Le groupe Students et les administrateurs ont le contrôle total sur le partage SMB. La commande icacls confirme le droit de modification (M) pour Students sur le dossier.

 <img width="990" height="364" alt="image" src="https://github.com/user-attachments/assets/ea11d3d6-94d6-4964-a7a3-5d3a02db71b7" />

Figure 4 – Permissions du partage SMB.

 <img width="1105" height="555" alt="image" src="https://github.com/user-attachments/assets/f8d608b8-390f-4a4d-b351-2ce4d1b7c42e" />

Figure 5 – Membres du groupe et permissions NTFS.

 4. Stratégie de groupe et lecteur Z:

J’ai lié la GPO MapSharedFolder à l’OU Students. Dans les préférences utilisateur, j’ai configuré le lecteur Z: vers \\SRV300160424\SharedResources avec l’action Mettre à jour et l’option Reconnecter.

 <img width="1099" height="405" alt="image" src="https://github.com/user-attachments/assets/1c1b1dbb-2726-4592-b50e-7301d341d5c2" />

Figure 6 – Configuration du lecteur réseau dans la GPO.

 <img width="1001" height="600" alt="image" src="https://github.com/user-attachments/assets/396d62e9-9ccd-4b78-9b5e-c55f0b701434" />

Figure 7 – Vérification de la GPO, de son lien et du mappage.

 5. Configuration du Bureau à distance
    
J’ai activé les règles du pare-feu RDP et ajouté Students au groupe Remote Desktop Users. La première connexion a été refusée. Pour le test sur mon contrôleur de domaine, j’ai ajouté Students au droit d’ouverture de session RDP dans Default Domain Controllers Policy, en conservant Administrators. J’ai actualisé la stratégie avec gpupdate.

 <img width="1111" height="300" alt="image" src="https://github.com/user-attachments/assets/3c472cbd-534d-4670-8759-31371cfd5e6e" />

Figure 8 – Règles du pare-feu RDP.

<img width="1081" height="675" alt="image" src="https://github.com/user-attachments/assets/af4fb3a5-69ef-4397-9cfa-986222bd8a9a" />

Figure 9 – Droit RDP accordé à Students et Administrators.

 6. Test avec Etudiant1

J’ai ouvert une session RDP sur 10.7.237.229 avec Etudiant1. La commande whoami confirme le compte utilisé et net use affiche le lecteur Z: avec le statut OK. Le dossier partagé est accessible dans l’Explorateur.

 <img width="1068" height="555" alt="image" src="https://github.com/user-attachments/assets/0bb90a28-1126-4eb0-8879-1df252e5e233" />

Figure 10 – Connexion RDP réussie et lecteur Z: connecté.

 <img width="1102" height="525" alt="image" src="https://github.com/user-attachments/assets/669a51e4-4046-493c-83ad-e899db666cb6" />

Figure 11 – Accès au dossier SharedResources (Z:).

 7. Test avec un utilisateur hors du groupe
    
J’ai utilisé le compte TestUser, qui ne fait pas partie de Students. La connexion RDP a été refusée, comme prévu.

 <img width="1078" height="510" alt="image" src="https://github.com/user-attachments/assets/d050ff5b-35ca-4baa-a956-d43b05953754" />

Figure 12 – Compte TestUser activé.

 <img width="1123" height="390" alt="image" src="https://github.com/user-attachments/assets/cdfdab69-3687-4f09-b773-809ffcbe93a0" />

Figure 13 – Refus de connexion RDP lors du test négatif.

 8. Vérification des scripts PowerShell
    
Le fichier bootstrap.ps1 contient les variables de mon environnement. Le script utilisateurs1.ps1 vérifie le dossier partagé, le groupe, les utilisateurs et les permissions SMB. Le script utilisateurs2.ps1 vérifie la GPO, son lien et le mappage du lecteur réseau.

 <img width="1132" height="555" alt="image" src="https://github.com/user-attachments/assets/2558ba0b-057e-42f9-9e4b-a58a323b7874" />

Figure 14 – Résultat de la vérification des utilisateurs et du partage.

 <img width="1094" height="300" alt="image" src="https://github.com/user-attachments/assets/41318021-18f1-4be9-b559-62798f9a7529" />

Figure 15 – Fichiers PowerShell présents dans mon dossier.

9. Conclusion
    
Dans ce TP, j’ai vérifié les objets Active Directory, les permissions du partage et la GPO. Le test RDP avec Etudiant1 a réussi et le lecteur Z: est accessible. Le test avec un utilisateur hors du groupe a été refusé. Les tests ont été réalisés sur mon contrôleur de domaine, et non sur une VM membre.

