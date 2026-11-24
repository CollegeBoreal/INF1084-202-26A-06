 INF1084 - IDE et SSH

**Nom :** Mohamed Bayrem Ben Salah  
**Identifiant Boréal :** 300151863  
**Cours :** INF1084  
**Établissement :** Collège Boréal  
**Activité :** Installation IDE et configuration SSH

 Objectifs

- Découvrir les premières commandes Git.
- Cloner un dépôt GitHub.
- Créer un répertoire personnel.
- Créer et modifier un fichier README.md.
- Configurer Git avec ses informations personnelles.
- Générer une clé SSH ed25519.
- Configurer SSH pour GitHub.
- Envoyer les modifications vers GitHub.

 Commandes Git utilisées

```bash
git status
git add 300151863
git commit --message ":star: Mon premier commentaire"
git pull --no-edit
git push
```

 Configuration SSH

Une clé SSH ed25519 est utilisée pour sécuriser la connexion avec GitHub.
mkdir Developer
cd Developer
git clone https://github.com/CollegeBoreal/INF1084-202-26A-06.git
cd INF1084-202-26A-06/1.Programmation/1.IDE
mkdir 300151863
cd 300151863
nano README.md
cd ..
git add 300151863
git status
git config --global core.editor "nano"
git config --global --edit
[core]
    editor = nano

[user]
    name = Mohamed Bayrem Ben Salah
    email = beyrembensalah@gmail.com
    git commit --message ":star: Mon premier commentaire"
git pull --no-edit
ssh-keygen -t ed25519 -C "beyrembensalah@gmail.com"
cd ~/.ssh
mv id_ed25519 ma_cle.pk
mv id_ed25519.pub ma_cle.pub
nano config
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/ma_cle.pk
    cat ~/.ssh/ma_cle.pub
    cd ~/Developer/INF1084-202-26A-06/1.Programmation/1.IDE
    git remote set-url origin git@github.com:CollegeBoreal/INF1084-202-26A-06.git
git remote --verbose
git push


**IDE :** Visual Studio Code

