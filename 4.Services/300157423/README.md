
# TP – Services Windows et Active Directory

## Introduction

Dans ce travail, j’ai utilisé PowerShell pour vérifier les services Active Directory, consulter les événements, exporter les événements dans un fichier CSV et arrêter puis redémarrer le service DFSR.

---

## Capture 1 – Vérification des services Active Directory

![Capture 1](images/Capture1.png)

Cette capture montre la vérification des principaux services Active Directory. Les services NTDS, ADWS, DFSR, KDC, Netlogon et IsmServ sont en état **Running**.

---

## Capture 2 – Affichage des événements Active Directory

![Capture 2](images/Capture2.png)

Cette capture montre les événements du journal **Directory Service**. La commande PowerShell permet d’afficher les informations concernant le fonctionnement d’Active Directory.

---

## Capture 3 – Création du dossier Logs

![Capture 3](images/Capture3.png)

Cette capture montre la création du dossier **C:\Logs**. Ce dossier est utilisé pour enregistrer le fichier contenant les événements Active Directory.



 Capture 4 – Exportation des événements dans un fichier CSV

![Capture 4](images/Capture4.png)

Cette capture montre l’exportation des événements Active Directory dans le fichier **ADLogs.csv**. Le fichier est enregistré dans le dossier **C:\Logs**.

---

## Capture 5 – Arrêt et redémarrage du service DFSR

![Capture 5](images/Capture5.png)

Cette capture montre l’arrêt du service **DFSR** avec l’état **Stopped**, puis son redémarrage avec l’état **Running**.

---

## Conclusion

Ce travail m’a permis d’utiliser PowerShell pour vérifier les services Active Directory, consulter les événements, les enregistrer dans un fichier CSV et gérer le service DFSR.
