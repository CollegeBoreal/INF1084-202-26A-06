# INF1084 — Architecture Active Directory avec Hyper-V

**Numéro étudiant :** 300159203  
**Cours :** INF1084 — Administration Windows  
**Environnement :** Windows Server 2022, Hyper-V, PowerShell et Active Directory

## 1. Présentation du projet

Ce projet consiste à créer une infrastructure Windows Server virtualisée avec Hyper-V. L'environnement comprend un contrôleur de domaine Active Directory, un poste client et un partage réseau sécurisé par des permissions SMB et NTFS.

## 2. Architecture Hyper-V

Serveur hôte : `SRV300159203`

Machines virtuelles :
- `DC300159203`
- `CLIENT01`
- `SRV01`

<img width="639" height="279" alt="Screenshot 2026-11-07 191640" src="https://github.com/user-attachments/assets/1d7d6c6b-73bf-4904-a41f-0d559b4c6ebf" />


## 3. Configuration réseau

| Élément | Adresse / configuration |
|---|---|
| Réseau privé | 172.16.21.0/24 |
| Passerelle | 172.16.21.1 |
| NAT | LABNAT |
| Commutateur | LAB |

<img width="579" height="125" alt="Screenshot 2026-11-07 191721" src="https://github.com/user-attachments/assets/632390f2-222a-4e80-a7e9-dfc5225ad5c9" />


<img width="548" height="215" alt="Screenshot 2026-11-07 191808" src="https://github.com/user-attachments/assets/d6e0f45f-19f7-4ba8-ab2f-0d466c85282d" />

<img width="558" height="185" alt="Screenshot 2026-11-07 191859" src="https://github.com/user-attachments/assets/422eb19c-03df-4e48-bb94-fb38aa321d29" />

## 4. Installation du contrôleur de domaine

Nom du serveur : `DC300159203`

| Paramètre | Valeur |
|---|---|
| Adresse IP | 172.16.21.10 |
| Masque | 255.255.255.0 |
| Passerelle | 172.16.21.1 |
| DNS | 127.0.0.1 / ::1 |
| Domaine | DC300159203.local |
| NetBIOS | AD300159203 |

<img width="925" height="384" alt="Screenshot 2026-11-07 192100" src="https://github.com/user-attachments/assets/dd65f929-2bc9-4031-af35-95dd9fa1c1b1" />

<img width="908" height="221" alt="Screenshot 2026-11-07 194736" src="https://github.com/user-attachments/assets/f12bde31-36ad-40de-8ca8-77f7154730ee" />

<img width="928" height="241" alt="Screenshot 2026-11-07 194849" src="https://github.com/user-attachments/assets/1b388cf7-ff3b-48f5-8ddd-b217f4d7fd9f" />

## 5. Organisation Active Directory

Unité organisationnelle principale : `OU300159203`

Unités organisationnelles créées :
- Students
- Groups
- Workstations
- Servers
- ServiceAccounts

<img width="813" height="303" alt="Screenshot 2026-11-07 195022" src="https://github.com/user-attachments/assets/4e29b3e1-5565-417b-b7c8-cef1450b3e36" />
### Utilisateurs

Les comptes utilisateurs créés comprennent Messi, Ronaldo, Mbappé, Haaland, Salah, Benzema, Modric, Neymar, Vinicius, De Bruyne et Mahrez.

<img width="803" height="477" alt="Screenshot 2026-11-07 195156" src="https://github.com/user-attachments/assets/b1aca8e4-7478-400d-8cd1-1bf2933cc048" />
## 6. Groupes de sécurité

| Groupe | Type | Fonction |
|---|---|---|
| GG_Developers | Global | Développeurs |
| UG_ContentEditors | Universal | Éditeurs |
| DL_ProjectFolder_Modify | Domain Local | Modification |
| DL_ProjectFolder_Read | Domain Local | Lecture |

<img width="817" height="226" alt="Screenshot 2026-11-07 195234" src="https://github.com/user-attachments/assets/98ed2dd7-6745-4573-9356-f4db337c013a" />

<img width="820" height="226" alt="Screenshot 2026-11-07 195354" src="https://github.com/user-attachments/assets/213a4e55-6760-423b-b998-2c335e1c03cc" />

<img width="815" height="236" alt="Screenshot 2026-11-07 200938" src="https://github.com/user-attachments/assets/2f46e545-9449-4cb0-a7f8-3cf1a3ee9b42" />

<img width="814" height="234" alt="Screenshot 2026-11-07 201016" src="https://github.com/user-attachments/assets/073ae018-5487-4f69-b631-9b9725cd0362" />

<img width="814" height="301" alt="Screenshot 2026-11-07 201333" src="https://github.com/user-attachments/assets/01469771-c666-4dd2-8e9a-75d06339c288" />

## 7. Partage réseau et permissions

Dossier créé : `C:\ProjectFolder`

Nom du partage : `ProjectFolder`

Chemin réseau : `\\DC300159203\ProjectFolder`

### Permissions SMB

- Administrators : Full
- DL_ProjectFolder_Modify : Change
- DL_ProjectFolder_Read : Read

<img width="818" height="219" alt="Screenshot 2026-11-07 195505" src="https://github.com/user-attachments/assets/e860ac81-6342-466d-85bd-f2476721dce0" />

<img width="814" height="250" alt="Screenshot 2026-11-07 195604" src="https://github.com/user-attachments/assets/004ea903-3e99-48d6-bfd7-b0fa3fe3da8b" />

### Permissions NTFS

- DL_ProjectFolder_Modify : Modify
- DL_ProjectFolder_Read : Read & Execute

<img width="820" height="247" alt="Screenshot 2026-11-07 195643" src="https://github.com/user-attachments/assets/e7e6fe5a-b16a-45a2-afe0-c6c7f28cd476" />

## 8. Configuration du poste client

Nom : `CLIENT01`

| Paramètre | Valeur |
|---|---|
| Adresse IP | 172.16.21.20 |
| Masque | 255.255.255.0 |
| Passerelle | 172.16.21.1 |
| DNS | 172.16.21.10 |
| Domaine | DC300159203.local |

<img width="788" height="320" alt="Screenshot 2026-11-07 200139" src="https://github.com/user-attachments/assets/5ba3bdfc-551b-483b-b0d9-e4fc47f52f6d" />

<img width="639" height="253" alt="Screenshot 2026-11-07 200305" src="https://github.com/user-attachments/assets/a34fb5a8-1c64-424b-941e-6176b0c5d36b" />

## 9. Tests du partage réseau

### Accès au partage

<img width="757" height="163" alt="Screenshot 2026-11-07 200345" src="https://github.com/user-attachments/assets/fce02049-1367-4edb-afed-c9728c271d70" />

### Test de modification avec Messi

Messi, membre de GG_Developers, a réussi à créer un fichier dans le partage.

<img width="776" height="409" alt="Screenshot 2026-11-07 200556" src="https://github.com/user-attachments/assets/6cb4bace-004e-4d59-878b-edbb117b278d" />

### Refus d'accès initial avec Salah

Avant son ajout au groupe de lecture, Salah ne pouvait pas accéder au contenu du partage.

<img width="775" height="342" alt="Screenshot 2026-11-07 200738" src="https://github.com/user-attachments/assets/c8d59797-2876-4c1c-93fd-12d82b1c171d" />

### Test de lecture avec Salah

Après son ajout à DL_ProjectFolder_Read, Salah a réussi à afficher les fichiers.

<img width="765" height="391" alt="Screenshot 2026-11-07 201621" src="https://github.com/user-attachments/assets/0038f45d-1e41-4815-a7ff-3d5d36dc1046" />

### Refus de modification avec Salah

Salah a essayé de créer un fichier, mais l'opération a été refusée. Cela confirme que ses permissions sont limitées à la lecture.

<img width="788" height="479" alt="Screenshot 2026-11-07 201718" src="https://github.com/user-attachments/assets/770d6bbc-4c4a-46a5-8f09-99999d9ec30b" />

## 10. Conclusion

Ce laboratoire m'a permis de pratiquer la création d'une infrastructure virtualisée, l'installation d'Active Directory, la gestion des utilisateurs et des groupes, ainsi que la configuration des permissions SMB et NTFS.

Les tests réalisés confirment que les utilisateurs peuvent accéder aux ressources selon les permissions attribuées à leurs groupes.
