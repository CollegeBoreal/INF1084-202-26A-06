1. Objectifs du laboratoire

Lister les principaux services associés à Active Directory et vérifier leur état.

Consulter les événements du journal « Directory Service » et les événements liés à Netlogon.

Exporter les événements Active Directory dans un fichier CSV pour conservation et analyse.

Arrêter puis redémarrer le service DFS Replication (DFSR) et confirmer son retour à l’état Running.

Effectuer une vérification finale des scripts, des services et du fichier de journal exporté.

2. Contexte technique

Active Directory Domain Services repose sur plusieurs services Windows qui travaillent ensemble. NTDS fournit le service d’annuaire principal et gère la base de données Active Directory. ADWS permet l’administration à distance, DFSR assure notamment la réplication de SYSVOL, KDC fournit les tickets Kerberos, Netlogon participe à l’authentification et à la localisation des contrôleurs de domaine, et IsmServ intervient dans la messagerie intersite. La disponibilité de ces services est essentielle au bon fonctionnement du domaine.

3. Capture 1 – Création du dossier et vérification des services AD

La première capture montre la préparation du laboratoire dans Windows PowerShell ISE exécuté avec les privilèges administrateur. Le dossier C:\LabServices est créé afin de regrouper les scripts PowerShell du laboratoire. Le script services1.ps1 est ensuite créé puis exécuté.

Le résultat du script affiche les principaux services associés à Active Directory : NTDS, ADWS, DFSR, IsmServ, KDC et Netlogon. Tous apparaissent avec l’état « Running ». Cette vérification est importante, car elle confirme que la machine utilisée est bien un contrôleur de domaine opérationnel et que les composants essentiels d’AD DS sont disponibles.

NTDS représente le cœur d’Active Directory Domain Services. ADWS permet l’utilisation d’outils d’administration à distance. DFSR est utilisé pour la réplication de données telles que SYSVOL. KDC assure la distribution des tickets Kerberos nécessaires à l’authentification. Netlogon participe à l’authentification et à la découverte du contrôleur de domaine, tandis qu’IsmServ prend en charge certaines communications intersites. Cette capture valide donc le premier objectif du laboratoire : identifier les services AD et vérifier leur état.




<img width="2048" height="1153" alt="001" src="https://github.com/user-attachments/assets/fb8cedeb-c9cd-4b0b-8069-27b71d9f8e5b" />



4. Capture 2 – Consultation des événements Active Directory

La deuxième capture présente le script services2.ps1 ainsi que son exécution. Le script utilise les commandes Get-EventLog et Get-WinEvent afin de consulter les journaux Windows liés à Active Directory. Il récupère notamment les vingt événements les plus récents du journal « Directory Service » et recherche également les événements associés à Netlogon dans le journal System.

Le résultat affiché contient plusieurs événements provenant de NTDS General et NTDS ISAM. On peut voir des événements de type Information ainsi qu’un avertissement. Les messages affichés concernent entre autres des opérations internes de maintenance de la base Active Directory, notamment la défragmentation en ligne.

Cette étape démontre l’utilité des journaux d’événements pour l’administration d’un contrôleur de domaine. En cas de problème d’authentification, de réplication ou de fonctionnement d’Active Directory, ces journaux constituent une source essentielle d’information pour identifier l’origine d’une erreur. La capture confirme donc que le script services2.ps1 peut consulter correctement les événements du service d’annuaire.



<img width="2048" height="1153" alt="002" src="https://github.com/user-attachments/assets/c001f63b-0c92-4203-81ed-db549ccd4af4" />




5. Capture 3 – Exportation des événements dans ADLogs.csv

La troisième capture montre la préparation et l’exécution du script services3.ps1. Avant l’exportation, le dossier C:\Logs est créé. Le script récupère les cinquante événements les plus récents du journal « Directory Service » à l’aide de Get-WinEvent, puis les exporte au format CSV dans le fichier C:\Logs\ADLogs.csv.

Après l’exécution, la commande Get-Item C:\Logs\ADLogs.csv confirme que le fichier existe. La capture affiche également sa taille, ce qui démontre que des données ont réellement été écrites dans le fichier. Les premières lignes du fichier sont ensuite consultées avec Get-Content.

L’exportation en CSV est utile pour conserver une copie des événements, effectuer une analyse ultérieure, partager les résultats avec un administrateur ou ouvrir les données dans un tableur. Cette étape répond à l’objectif du laboratoire qui demande de capturer les événements d’un service Active Directory dans un fichier.


<img width="2048" height="1153" alt="003" src="https://github.com/user-attachments/assets/0197fa35-48a4-4c63-a931-38ac605fc2ed" />







6. Capture 4 – Vérification du CSV et redémarrage de DFSR

La quatrième capture poursuit la vérification du fichier ADLogs.csv. Les premières lignes montrent différentes propriétés des événements Windows, notamment le message, l’identifiant de l’événement, le niveau, le fournisseur, le nom de la machine et la date de création. Cela confirme que l’exportation réalisée par services3.ps1 contient bien des événements Active Directory exploitables.

La même capture montre ensuite la création et l’exécution du script services4.ps1. Ce script arrête le service DFSR, affiche son état « Stopped », puis le redémarre. Une commande Get-Service -Name DFSR est exécutée après le script afin de vérifier l’état final du service.

Le résultat « Running » confirme que DFS Replication a correctement redémarré. Cette vérification est particulièrement importante, car DFSR participe à la réplication de SYSVOL entre contrôleurs de domaine. Le laboratoire démontre ainsi comment un administrateur peut contrôler un service Windows avec Stop-Service, Start-Service et Get-Service tout en s’assurant que le service est opérationnel après l’intervention.



<img width="2048" height="1153" alt="004" src="https://github.com/user-attachments/assets/a5fb3997-00f2-466c-bf89-68d2c5f3e43c" />







7. Capture 5 – Présence des quatre scripts et vérification des services

La cinquième capture correspond à une vérification générale du travail réalisé. Le contenu du dossier C:\LabServices est affiché et confirme la présence des quatre fichiers demandés : services1.ps1, services2.ps1, services3.ps1 et services4.ps1. Les dates et tailles des fichiers montrent qu’ils ont bien été créés au cours du laboratoire.

La capture affiche ensuite l’état de plusieurs services Active Directory. ADWS, DFSR, IsmServ, KDC et Netlogon sont tous à l’état « Running ». Cette étape permet de vérifier qu’aucune manipulation effectuée pendant le laboratoire n’a laissé un service important à l’arrêt.

Cette vérification finale est une bonne pratique d’administration. Après avoir testé l’arrêt ou le redémarrage d’un service critique, il est nécessaire de confirmer que l’environnement est revenu à un état stable. La capture constitue donc une preuve supplémentaire que les services nécessaires au fonctionnement du domaine sont actifs.




<img width="2048" height="1153" alt="005" src="https://github.com/user-attachments/assets/5e3ae1e6-91db-4383-bc63-85aebfdc3ba6" />




8. Capture 6 – Vérification finale de NTDS et du fichier de logs

La sixième et dernière capture complète la vérification du laboratoire. Elle montre le service NTDS, identifié comme « Active Directory Domain Services », avec l’état « Running ». NTDS étant le service principal du contrôleur de domaine, son fonctionnement confirme que le service d’annuaire Active Directory est disponible.

La valeur « True » affichée à la fin correspond à la vérification de l’existence du fichier C:\Logs\ADLogs.csv. Elle confirme que le fichier d’exportation produit pendant le troisième exercice est toujours présent sur le serveur.

Avec cette dernière vérification, les éléments principaux du laboratoire sont confirmés : les quatre scripts existent, les services Active Directory sont actifs, DFSR a été redémarré correctement et le fichier contenant les événements a été créé. L’environnement est donc laissé dans un état fonctionnel à la fin des manipulations.



<img width="2048" height="1153" alt="006" src="https://github.com/user-attachments/assets/20b75f0f-8276-48c1-ac33-d835be2b1794" />




10. Conclusion

Ce laboratoire a permis de mettre en pratique l’administration des services Windows liés à Active Directory Domain Services. Les commandes PowerShell ont permis de vérifier l’état des services essentiels, d’examiner les journaux d’événements du contrôleur de domaine, d’exporter des événements vers un fichier CSV et de contrôler le service DFS Replication. Les vérifications finales montrent que les services critiques sont revenus à l’état Running et que le fichier ADLogs.csv a bien été créé. Le laboratoire est donc complété avec succès et démontre l’importance de PowerShell pour la surveillance, le diagnostic et la gestion quotidienne d’un environnement Active Directory.




