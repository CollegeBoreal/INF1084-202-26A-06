# TP1 — Git et environnement de développement

**Zakaria Mamssi — 300155462 — INF1084**

## État du travail

Travail en cours : dépôt récupéré, configuration Git locale effectuée. La connexion SSH, l'installation de l'IDE et les captures restent à compléter. Ce document ne constitue pas encore un compte rendu final.

## Objectif

Utiliser Git pour récupérer le dépôt du cours, créer mon dossier, enregistrer les modifications et les envoyer sur GitHub. Configurer ensuite une connexion SSH et Visual Studio Code.

## Manipulations réalisées le 17 novembre 2026

Git disponible : `2.56.0.windows.4`. Le dépôt est placé dans `Developer/INF1084-202-26A-06`.

```powershell
git -c http.sslBackend=openssl clone --filter=blob:none https://github.com/CollegeBoreal/INF1084-202-26A-06.git Developer/INF1084-202-26A-06
```

Le téléchargement a réussi, mais l'extraction initiale a échoué : un dossier d'un autre participant contient une espace finale, incompatible avec Windows. Une extraction sélective a permis de récupérer les consignes et de travailler seulement dans mon dossier. Aucun dossier d'un autre étudiant n'a été modifié.

```powershell
git config http.sslBackend openssl
git config user.name "Zakaria Mamssi"
git config user.email "300155462@monboreal.ca"
git switch -c travaux-300155462-tp1-5
```

La configuration est limitée à ce dépôt. Le moteur TLS OpenSSL résout l'erreur Schannel rencontrée sans désactiver la vérification des certificats.

## Étapes restantes

- Créer/configurer la clé SSH et ajouter uniquement sa partie publique à GitHub.
- Tester l'authentification SSH et configurer le dépôt distant en SSH.
- Vérifier Visual Studio Code.
- Ajouter les captures réelles des commandes Git et de leur résultat.
- Vérifier la publication finale.

## Repères

`git add` prépare les modifications, `git commit` enregistre une version locale, `git pull` récupère et intègre le travail distant, et `git push` envoie les commits. Une clé privée ne doit jamais figurer dans ce dépôt.

[Consignes du TP](../README.md)
