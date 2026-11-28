
TP06 – Windows : Nested

Nom et prénom : Bouzidi Ouahiba

Matricule : 300157606


Introduction


	Ce travail pratique consiste à configurer un environnement de virtualisation imbriquée avec Hyper-V, un réseau privé et un contrôleur de domaine Active Directory. L’objectif final est de joindre CLIENT01 au domaine DC300157606.local et de vérifier son inscription dans Active Directory.


Schéma de l’architecture réseau 

	Ce schéma représente l’architecture de mon environnement virtualisé sous Hyper-V. Le réseau privé 172.16.17.0/24 relie le contrôleur de domaine DC300157606, qui assure les services AD DS et DNS, à la machine CLIENT01 intégrée au domaine DC300157606.local. La passerelle NAT 172.16.17.1 permet l’accès au réseau externe.


<img width="296" height="274" alt="0" src="https://github.com/user-attachments/assets/16d42ccc-b33e-45be-b270-933346798f16" />


Configuration du laboratoire

Serveur hôte : 10.7.237.216

Réseau privé : 172.16.17.0/24

Passerelle : 172.16.17.1

Contrôleur et DNS : 172.16.17.10

CLIENT01 : 172.16.17.20

Domaine : DC300157606.local

Les photos suivantes sont présentées dans leur ordre original. Les détails qui ne sont pas lisibles ne sont pas transcrits comme des résultats certains.

Capture 01

Vérification initiale de l’environnement Hyper-V et des machines virtuelles.

<img width="2000" height="1500" alt="1" src="https://github.com/user-attachments/assets/067775d4-b8f3-410f-a25f-3b2c45b245b7" />

Explication : Cette vérification permet de connaître l’état du serveur avant de créer les machines imbriquées.


Capture 02

Création ou vérification du commutateur interne LAB.

<img width="2000" height="1500" alt="2" src="https://github.com/user-attachments/assets/08616991-51d9-4b87-9e98-91792a07e092" />

Explication : Le commutateur interne permet aux machines virtuelles de communiquer entre elles et avec leur hôte.


Capture 03

Consultation des interfaces réseau et configuration de l’adresse privée.

<img width="2000" height="1500" alt="3" src="https://github.com/user-attachments/assets/f8faeed7-60ea-43b9-bcdc-3d330f09fd08" />

Explication : L’adresse de l’interface virtuelle sert de passerelle au réseau privé du laboratoire.


Capture 04

Configuration du NAT et consultation des paramètres réseau.

<img width="2000" height="1500" alt="4" src="https://github.com/user-attachments/assets/a20d5ce5-9f1b-4ae9-a98d-6cd45cb6e95b" />

Explication : Le NAT associe le réseau interne à la connectivité du serveur hôte pour permettre les échanges vers l’extérieur.


Capture 05

Vérification complémentaire du NAT et de l’adresse du réseau LAB.

<img width="2000" height="1500" alt="5" src="https://github.com/user-attachments/assets/fd3784a2-9256-4771-bc82-7544fa531002" />

Explication : Cette consultation permet de contrôler les paramètres du NAT et de la passerelle avant de poursuivre.

Capture 06

Consultation des machines virtuelles et de leurs paramètres.

<img width="2000" height="1500" alt="6" src="https://github.com/user-attachments/assets/587c6ef5-df82-47b9-ab07-fde631531a26" />

Explication : La consultation des ressources Hyper-V permet de préparer une machine virtuelle sans modifier inutilement les machines existantes.


Capture 07

Vérification des volumes, des fichiers et de la configuration Hyper-V.

<img width="2000" height="1500" alt="7" src="https://github.com/user-attachments/assets/0d160273-9566-4c30-88b1-13f4dd90d5a5" />

Explication : Je vérifie les ressources de stockage disponibles pour accueillir le disque virtuel et les fichiers d’installation.


Capture 08

Préparation du stockage et création de la machine virtuelle du contrôleur de domaine.

<img width="2000" height="1500" alt="8" src="https://github.com/user-attachments/assets/0c22999a-09d3-4e84-adce-59e040112079" />

Explication : Le disque virtuel fournit un espace de stockage indépendant au futur contrôleur de domaine.

Capture 09

Consultation et ajustement des paramètres de la machine virtuelle.

<img width="2000" height="1500" alt="9" src="https://github.com/user-attachments/assets/b3f1b205-75df-46ed-acc6-119b79d75d12" />

Explication : Ces réglages permettent d’adapter les ressources et le comportement de la machine virtuelle à son rôle.


Capture 10

Vérification des paramètres de démarrage et du réseau virtuel.

<img width="2000" height="1500" alt="10" src="https://github.com/user-attachments/assets/c21b082f-fb4c-4511-a676-ca60d43a42d7" />

Explication : Je contrôle les paramètres de la VM afin de préparer son démarrage et sa connexion au réseau LAB.


Capture 11

Recherche des fichiers nécessaires à l’installation du système.

<img width="2000" height="1500" alt="11" src="https://github.com/user-attachments/assets/c745f760-fd73-49ca-a352-d6cf105a090c" />

Explication : Cette étape permet de déterminer quels supports et fichiers sont disponibles avant l’installation.


Capture 12

Recherche de l’image ISO dans les dossiers du serveur.

<img width="2000" height="1500" alt="12" src="https://github.com/user-attachments/assets/97d5de32-ba6c-4bfa-9a2c-e86c57c792d3" />

Explication : La recherche du fichier ISO est nécessaire pour identifier un chemin utilisable par le lecteur DVD virtuel.


Capture 13

Tentative de préparation du support d’installation et messages PowerShell.

<img width="2000" height="1500" alt="13" src="https://github.com/user-attachments/assets/41f0c9ec-ac45-40af-8a53-7a7d20dd7449" />

Explication : Les messages affichés servent à diagnostiquer les difficultés de préparation du support avant de poursuivre.


Capture 14

Page Microsoft de téléchargement de Windows Server.

<img width="2000" height="1500" alt="14" src="https://github.com/user-attachments/assets/6e4b4aab-0607-468e-ba03-8151abd0645f" />

Explication : Le site Microsoft propose les supports d’installation du système. Je recherche une image ISO adaptée à la machine virtuelle.


Capture 15

Consultation des fichiers téléchargés dans l’Explorateur.

<img width="2000" height="1500" alt="15" src="https://github.com/user-attachments/assets/fb3335b5-04c2-466b-ae1f-a261efd8ae5c" />

Explication : Je consulte les fichiers téléchargés afin de retrouver le support d’installation sur le serveur hôte.


Capture 16

Repérage du fichier ISO d’installation.

<img width="2000" height="1500" alt="16" src="https://github.com/user-attachments/assets/f483d463-94c8-4096-a6a9-081779e08def" />

Explication : Le fichier ISO sélectionné doit être accessible à Hyper-V pour pouvoir démarrer la machine virtuelle dessus.


Capture 17

Préparation du lecteur DVD virtuel et du démarrage de la VM.

<img width="2000" height="1500" alt="17" src="https://github.com/user-attachments/assets/2d15ff1f-994f-4ca3-9325-19a89842aead" />

Explication : Le lecteur DVD virtuel permet de présenter l’image ISO à la VM et de lancer le programme d’installation.


Capture 18

Ouverture de la console de la machine virtuelle du contrôleur de domaine.

<img width="2000" height="1500" alt="18" src="https://github.com/user-attachments/assets/c9ff85d1-7fe8-4938-bae5-8a9b9123085a" />

Explication : La console Hyper-V permet de contrôler la machine virtuelle indépendamment du bureau du serveur hôte.


Capture 19

Sélection des paramètres linguistiques de l’installation.

<img width="2000" height="1500" alt="19" src="https://github.com/user-attachments/assets/b7613fb4-e884-4764-a1cf-30928603ed26" />

Explication : Je choisis la langue, les paramètres régionaux et le clavier qui seront utilisés pendant l’installation.


Capture 20

Lancement de l’installation de Windows Server.

<img width="2000" height="1500" alt="20" src="https://github.com/user-attachments/assets/ee809d2a-71a0-4883-923c-0d054ebe3952" />

Explication : Le bouton Install now démarre l’assistant d’installation du système dans la machine virtuelle.


Capture 21

Sélection de l’édition du système d’exploitation.

<img width="2000" height="1500" alt="21" src="https://github.com/user-attachments/assets/fa64b288-0846-4375-9ade-1ef7e6a70d5c" />

Explication : Cette étape permet de choisir l’édition de Windows Server. L’interface graphique est confirmée par les captures suivantes.


Capture 22

Sélection du type d’installation.

<img width="2000" height="1500" alt="22" src="https://github.com/user-attachments/assets/71e95eac-6d85-4c23-9a4a-18b90a3b0c56" />

Explication : L’installation personnalisée permet d’installer un nouveau système sur le disque virtuel plutôt que de mettre à niveau un système existant.


Capture 23

Sélection du disque virtuel de destination.

<img width="2000" height="1500" alt="23" src="https://github.com/user-attachments/assets/bcbe9fa2-384c-4c23-a229-d1bbc0fa3972" />

Explication : Le disque virtuel sélectionné recevra les fichiers système et les partitions nécessaires au démarrage.


Capture 24

Redémarrage du système pendant l’installation.

<img width="2000" height="1500" alt="24" src="https://github.com/user-attachments/assets/c0ab788c-175b-494f-a155-e833a6d99b86" />

Explication : Le redémarrage permet au programme d’installation de poursuivre la configuration depuis le disque virtuel.


Capture 25

Configuration du compte Administrator local.

<img width="2000" height="1500" alt="25" src="https://github.com/user-attachments/assets/8f374620-4def-4abb-9894-f22af3323498" />

Explication : Je définis le mot de passe du compte administrateur local pour sécuriser le premier accès au système.


Capture 26

Écran de connexion du contrôleur de domaine.

<img width="2000" height="1500" alt="26" src="https://github.com/user-attachments/assets/5108831c-0e2d-48a1-9a9e-2c0d6269255a" />

Explication : L’écran de connexion montre que le système a atteint la phase d’authentification après son installation.


Capture 27

Démarrage de Server Manager.

<img width="2000" height="1500" alt="27" src="https://github.com/user-attachments/assets/116f6d69-9d73-4c84-8d74-4f99b273e077" />

Explication : Le lancement de Server Manager confirme que la session graphique du serveur est accessible.


Capture 28

Affichage du tableau de bord Server Manager.

<img width="2000" height="1500" alt="28" src="https://github.com/user-attachments/assets/660f8e35-2972-42c9-be9c-9ac9c03efaa2" />

Explication : Le tableau de bord permet d’administrer les rôles, les fonctionnalités et les paramètres du serveur.


Capture 29

Ouverture de la console de commandes dans la machine virtuelle.

<img width="2000" height="1500" alt="29" src="https://github.com/user-attachments/assets/0189b3bb-7c8f-473d-a775-3c34efaa8897" />

Explication : La console de commandes permet de préparer les opérations d’administration et les vérifications du système.


Capture 30

Affichage de la session Windows Server et d’une boîte de dialogue.

<img width="2000" height="1500" alt="30" src="https://github.com/user-attachments/assets/ae1b4c39-ccd3-424d-8213-617a0c02eb26" />

Explication : Cette capture montre la session graphique et une boîte de dialogue ; son contenu exact est difficile à lire.


Capture 31

Reconnexion et consultation de la configuration réseau du contrôleur.

<img width="2000" height="1500" alt="31" src="https://github.com/user-attachments/assets/fc846b89-9922-4f4b-86c9-1b148ba38e8c" />

Explication : La reconnexion permet de poursuivre les vérifications depuis la console PowerShell après une interruption de session.


Capture 32

Configuration de l’adresse IP et du DNS du contrôleur.

<img width="2000" height="1500" alt="32" src="https://github.com/user-attachments/assets/abf45d74-75ec-449c-9ab3-7fb5591a3375" />

Explication : Je prépare l’adresse fixe 172.16.17.10/24 et le DNS du contrôleur, nécessaires pour que les clients puissent retrouver le domaine.


Capture 33

Vérification IP et test ping vers la passerelle.

<img width="2000" height="1500" alt="33" src="https://github.com/user-attachments/assets/84ce52c9-01d2-458e-8273-f057ac72bd7a" />

Explication : La configuration IP et le ping vers 172.16.17.1 permettent de vérifier la communication avec la passerelle du laboratoire.


Capture 34

Vérification des services et du rôle du contrôleur de domaine.

<img width="2000" height="1500" alt="34" src="https://github.com/user-attachments/assets/6b64a92c-324e-4a41-9b6a-6d5b628c2252" />

Explication : Les services AD DS, DNS, ADWS et Netlogon ainsi que le rôle de domaine permettent de vérifier le fonctionnement du contrôleur après promotion.


Capture 35

Consultation des informations de la forêt et vérifications DNS.

<img width="2000" height="1500" alt="35" src="https://github.com/user-attachments/assets/889b7c3b-e66a-46bf-a2d6-1f83152fb8c6" />

Explication : La consultation de la forêt et des enregistrements DNS permet de contrôler l’existence du domaine DC300157606.local.


Capture 36

Commandes de gestion des unités organisationnelles et résultats.

<img width="2000" height="1500" alt="36" src="https://github.com/user-attachments/assets/6c4c3080-d54b-4966-969a-18a83a61584c" />

Explication : Les commandes Active Directory servent à organiser les objets du domaine. Une tentative de création répétée ne signifie pas nécessairement que l’OU est absente.


Capture 37

Liste des unités organisationnelles et de leurs chemins LDAP.

<img width="2000" height="1500" alt="37" src="https://github.com/user-attachments/assets/ab49b135-d86a-46c9-85c6-b92dc5ac6b2e" />

Explication : La liste des chemins LDAP permet de vérifier la présence de l’OU principale et des sous-unités Students, Groups, Workstations et Servers.


Capture 38

Préparation de CLIENT01 et recherche du support ISO.

<img width="2000" height="1500" alt="38" src="https://github.com/user-attachments/assets/d7518f97-5f7b-4fe9-a9d2-a2ddd2214ad2" />

Explication : Je prépare la deuxième machine virtuelle et repère le fichier ISO nécessaire à son installation.


Capture 39

Vérification de la machine cliente et du fichier d’installation.

<img width="2000" height="1500" alt="39" src="https://github.com/user-attachments/assets/9fc48899-91de-4267-835a-0f916807ab81" />

Explication : Je vérifie les ressources de CLIENT01 et le support d’installation avant de démarrer la machine.


Capture 40

Démarrage de CLIENT01 depuis le support DVD.

<img width="2000" height="1500" alt="40" src="https://github.com/user-attachments/assets/15e5a1e0-a045-4f41-b4e7-134214d641bc" />

Explication : Le message Press any key to boot from CD or DVD permet de lancer le programme d’installation depuis le lecteur virtuel.


Capture 41

Lancement de l’installation Windows Server sur CLIENT01.

<img width="2000" height="1500" alt="41" src="https://github.com/user-attachments/assets/9e03aa3f-16dd-4c22-baae-30e345829346" />

Explication : Je lance l’installation du système sur CLIENT01 en utilisant le bouton Install now.


Capture 42

Préparation des fichiers d’installation à 97 %.

<img width="2000" height="1500" alt="42" src="https://github.com/user-attachments/assets/893ecd90-6107-4b6c-a6c4-c9a08f920ec9" />

Explication : La préparation des fichiers atteint 97 %. L’installation est encore en cours à ce stade.


Capture 43

Redémarrage automatique pour poursuivre l’installation.

<img width="2000" height="1500" alt="43" src="https://github.com/user-attachments/assets/ffa6e1f1-9f31-466f-8ee2-daf81f25cf9d" />

Explication : Le programme annonce un redémarrage nécessaire pour continuer l’installation du système client.


Capture 44

Configuration du mot de passe Administrator local.

<img width="2000" height="1500" alt="44" src="https://github.com/user-attachments/assets/b0365793-0ce5-4d85-ba6b-2d0a2443315b" />

Explication : Je configure le mot de passe du compte Administrator local, sans le divulguer dans le rapport.


Capture 45

Ouverture de la connexion à CLIENT01.

<img width="2000" height="1500" alt="45" src="https://github.com/user-attachments/assets/ba5832e9-899a-488b-9fd9-4047a48c2719" />

Explication : La fenêtre Connect to CLIENT01 permet de choisir la résolution de la session virtuelle avant de se connecter.


Capture 46

Écran d’authentification Administrator.

<img width="2000" height="1500" alt="46" src="https://github.com/user-attachments/assets/055b03ac-a42e-424a-9560-7502c457ae17" />

Explication : L’écran Administrator permet de saisir le mot de passe local défini précédemment.


Capture 47

Démarrage de Server Manager sur CLIENT01.

<img width="2000" height="1500" alt="47" src="https://github.com/user-attachments/assets/21ac53b8-db2f-4e25-8a30-95dd1a7dfd5f" />

Explication : Le lancement de Server Manager confirme que l’interface graphique de CLIENT01 est accessible.


Capture 48

PowerShell Direct : hostname retourne CLIENT01 et Ethernet est Up.

<img width="2000" height="1500" alt="48" src="https://github.com/user-attachments/assets/1fb5d035-a171-402f-89de-a170cfb67328" />

Explication : Enter-PSSession ouvre une session PowerShell Direct. hostname retourne CLIENT01 et Get-NetAdapter affiche Ethernet avec le statut Up.


Capture 49

Configuration de l’adresse 172.16.17.20/24, de la passerelle et du DNS.

<img width="2000" height="1500" alt="49" src="https://github.com/user-attachments/assets/a501a732-b100-4b5b-921b-307b67cb0a7e" />

Explication : New-NetIPAddress configure 172.16.17.20/24 avec la passerelle 172.16.17.1. Set-DnsClientServerAddress définit le DNS 172.16.17.10. La capture suivante confirme le résultat opérationnel.


Capture 50

Vérification IP, ping vers 172.16.17.10 sans perte et résolution DNS réussie.

<img width="2000" height="1500" alt="50" src="https://github.com/user-attachments/assets/57a6e47a-fc00-4931-8c82-bf61434299b4" />

Explication : Get-NetIPConfiguration confirme les paramètres. Le ping vers 172.16.17.10 reçoit quatre réponses sans perte et Resolve-DnsName retourne cette même adresse pour le domaine.


Capture 51

Résolution de l’enregistrement LDAP SRV (port 389) et demande d’identifiants pour Add-Computer.

<img width="2000" height="1500" alt="51" src="https://github.com/user-attachments/assets/70c2f33c-270b-43b1-85b9-a8371bdc2b19" />

Explication : La requête DNS SRV retrouve le service LDAP sur le port 389. Add-Computer demande ensuite les identifiants du domaine pour joindre CLIENT01.


Capture 52

Après redémarrage, PartOfDomain = True confirme l’intégration de CLIENT01.

<img width="2000" height="1500" alt="52" src="https://github.com/user-attachments/assets/a3b98871-4949-41b6-bf47-f2a575f7a2aa" />

Explication : Get-CimInstance Win32_ComputerSystem affiche CLIENT01, DC300157606.local et PartOfDomain = True. Cela confirme que la jonction au domaine a réussi.


Capture 53

Fermeture de la session cliente et demande d’identifiants du contrôleur de domaine.

<img width="2000" height="1500" alt="53" src="https://github.com/user-attachments/assets/5b9c3198-a6be-4e9f-b549-8c2ea4a3a21e" />

Explication : Exit-PSSession ferme la session cliente. Enter-PSSession ouvre une session vers le contrôleur de domaine avec le compte administrateur du domaine.


Capture 54

Get-ADComputer confirme la présence de DC300157606 et CLIENT01 dans Active Directory.

<img width="2000" height="1500" alt="54" src="https://github.com/user-attachments/assets/d0c8d872-5300-44db-92ed-b516ec37e946" />

Explication : Get-ADComputer affiche DC300157606 et CLIENT01 avec leurs noms DNS complets. Cette vérification confirme que le client est enregistré dans Active Directory.



Conclusion


	Ce TP m’a permis de mettre en place un laboratoire Hyper-V imbriqué, de configurer un réseau privé et un domaine Active Directory. Les tests réseau et DNS sont concluants. La valeur PartOfDomain = True et la présence de CLIENT01 dans Active Directory confirment la réussite de l’intégration au domaine.
