
Introduction

Dans ce travail, j’ai utilisé PowerShell pour vérifier les services Active Directory, consulter les événements, exporter les événements dans un fichier CSV et gérer le service DFSR.
<img width="618" height="488" alt="download" src="https://github.com/user-attachments/assets/6176d3ab-a880-44c8-9139-2e34c4b6ac2e" />
Cette capture montre la vérification des principaux services Active Directory. Les services NTDS, ADWS, DFSR, IsmServ, KDC et Netlogon sont en état Running
<img width="549" height="540" alt="download" src="https://github.com/user-attachments/assets/5169e7fc-8fd9-4ae8-b77b-ffef5a3ca2fb" />

Cette capture montre les événements du journal Directory Service avec les informations liées au fonctionnement d’Active Directory.
<img width="475" height="521" alt="download" src="https://github.com/user-attachments/assets/b67d63c0-79dd-4b51-bca2-f338d6f012f0" />
Cette capture montre la création du dossier C:\Logs, l’exportation des événements Active Directory et la présence du fichier ADLogs.csv.
<img width="957" height="540" alt="download" src="https://github.com/user-attachments/assets/4057d296-b666-4ef0-ba9f-3271c28ea118" />

Cette capture montre la vérification des principaux services Active Directory. Les services NTDS, ADWS, DFSR, IsmServ, KDC et Netlogon sont en état Running.
<img width="549" height="540" alt="download" src="https://github.com/user-attachments/assets/2ba3f131-2310-4fdb-8885-7de871166dc0" />
Cette capture montre les événements du journal Directory Service avec les informations liées au fonctionnement d’Active Directory.
<img width="475" height="521" alt="download" src="https://github.com/user-attachments/assets/8eeba202-e82e-4de3-9b5d-ce6c7a8a1dc9" />

Cette capture montre la création du dossier C:\Logs, l’exportation des événements Active Directory et la présence du fichier ADLogs.csv.
<img width="957" height="540" alt="download" src="https://github.com/user-attachments/assets/d4e8117f-9686-42d2-9cd9-280831595ffa" />
Cette capture montre l’arrêt du service DFSR avec l’état Stopped, puis son redémarrage avec l’état Running
<img width="960" height="540" alt="download" src="https://github.com/user-attachments/assets/da90bf72-1a8e-42b0-8918-13380f8282db" />
Cette capture montre la création du compte 300157423 et la vérification de sa présence dans le groupe Administrators avec la commande net localgroup Administrators.

Conclusion

Ce travail m’a permis de mieux comprendre les services Active Directory, les journaux d’événements, l’exportation des logs et la gestion de services avec PowerShell.
