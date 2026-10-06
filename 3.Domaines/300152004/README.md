# 300152004
# Active Directory

Étape 1 : Installation du rôle AD

<img width="3895" height="2597" alt="961154" src="https://github.com/CollegeBoreal/INF1084-202-26A-06/blob/main/3.Domaines/300152004/image/WhatsApp%20Image%202026-10-05%20at%2011.54.35%20PM.jpeg?raw=true" />  

J'ai lancé Install-WindowsFeature AD-Domain-Services -IncludeManagementTools. Le résultat indique Success.

Étape 2 : Création de la forêt 

<img width="3895" height="2597" alt="961154" src="https://github.com/CollegeBoreal/INF1084-202-26A-06/blob/main/3.Domaines/300152004/image/WhatsApp%20Image%202026-10-05%20at%2011.54.352%20PM.jpeg?raw=true" /> 

J'ai exécuté Install-ADDSForest avec le domaine DCB300152004.local, le nom NetBIOS DCB300152004, l'installation du DNS, le mot de passe DSRM et l'option -Force. 

Étape 3 : Promotion en cours 

<img width="3895" height="2597" alt="961154" src="https://github.com/CollegeBoreal/INF1084-202-26A-06/blob/main/3.Domaines/300152004/image/WhatsApp%20Image%202026-10-05%20at%2011.54.37%20PM.jpeg?raw=true" /> 

La validation se termine avec succès et la création de la forêt commence. Deux avertissements non bloquants apparaissent : l'un sur les algorithmes cryptographiques faibles, l'autre sur l'absence de délégation DNS, ce qui est normal pour une nouvelle infrastructure.

Étape 4 : Vérification du domaine

<img width="3895" height="2597" alt="961154" src="https://github.com/CollegeBoreal/INF1084-202-26A-06/blob/main/3.AD/300152004/image/WhatsApp%20Image%202026-10-05%20at%2011.54.372%20PM.jpeg" /> 

Avec Get-ADDomain, j'ai confirmé que le domaine DCB300152004.local fonctionne en niveau Windows2016Domain. Le serveur SRVB300152004 détient les rôles PDC, RID et Infrastructure Master.

Étape 5 : Vérification de la forêt (image 1)

<img width="3895" height="2597" alt="961154" src="https://github.com/CollegeBoreal/INF1084-202-26A-06/blob/main/3.AD/300152004/image/WhatsApp%20Image%202026-10-05%20at%2011.54.373%20PM.jpeg" /> 

Avec Get-ADForest, j'ai vérifié que la forêt est en niveau Windows2016Forest. 

Conclusion

J'ai installé le rôle AD DS puis créé avec succès la forêt et le domaine DCB300152004.local avec DNS intégré. Les vérifications montrent que SRVB300152004 est l'unique contrôleur de domaine et porte tous les rôles.

