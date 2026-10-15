Capture 1 (services1.ps1) : Affiche la liste de tous les services essentiels liés à Active Directory (tels que NTDS, ADWS, DFSR, Kdc, Netlogon et IsmServ) ainsi que leur état d'exécution actuel (Running).<img width="899" height="219" alt="Capture 1" src="https://github.com/user-attachments/assets/4f03f8c3-ab8f-42a4-a93d-3dbd71b11adc" />
Capture 2 (services2.ps1) : Interroge et affiche les événements récents du journal du service d'annuaire (Directory Service) sous forme de tableau détaillé (incluant la date, l'ID, le niveau et le message de l'événement).<img width="889" height="384" alt="Capture 2" src="https://github.com/user-attachments/assets/3c4e188e-5032-4dde-b82f-156c2690ad4b" />
Capture 3 (services3.ps1) : Exporte les journaux d'événements AD vers un fichier CSV (C:\Logs\ADLogs.csv), vérifie la présence du fichier avec Test-Path, puis lit et affiche les 5 premières lignes du fichier exporté.<img width="931" height="216" alt="Capture 3" src="https://github.com/user-attachments/assets/f77ae56a-6675-47ec-81e2-d665c9defda0" />
Capture 4 : Affiche le contenu du répertoire de travail (C:\Laboratoire3001577727) listant l'ensemble de vos scripts (services1.ps1 à services4.ps1) avec leur taille et date de modification.<img width="881" height="203" alt="Capture 4" src="https://github.com/user-attachments/assets/571f4c01-e643-41d1-96d4-575a1c1e4567" />
Capture 5 (services4.ps1) : Ouvre le script de gestion d'état du service DFSR (DFS Replication), qui permet de vérifier son état initial, de l'arrêter (Stop-Service), de vérifier son arrêt, de le redémarrer (Start-Service), puis de confirmer son bon redémarrage<img width="1160" height="638" alt="Capture 5" src="https://github.com/user-attachments/assets/56da277c-6554-492d-b2db-48d4d504a629" />






