# LABORATOIRE 6.Nested | COMPTE RENDU TECHNIQUE

```
Étudiant : Oualid Salhi
Matricule : 300156534
Date : 17 novembre 2026
Dernière mise à jour : 24 novembre 2026
Serveur parent : SRV300156534 — 10.7.237.212
Réseau privé : 172.16.26.0/24
Passerelle : 172.16.26.1
Contrôleur de domaine : DC300156534 — 172.16.26.10
Domaine : DC300156534.local
Nom NetBIOS : AD300156534
Client : CLIENT01 — 172.16.26.20
Compte administrateur : Administrator
Mot de passe administrateur (selon le rapport initial) : Infra@2024
Compte étudiant : AD300156534\etudiant01
Nouveau mot de passe étudiant : walid@2027
CONFIDENTIEL — Les mots de passe sont inscrits à la demande de l’étudiant. Ne pas publier ce document sur GitHub. Modifier ces mots de passe avant toute diffusion.

```

## 1. Objectif et architecture

Créer une infrastructure indépendante comprenant un commutateur Hyper-V interne, une passerelle NAT, un contrôleur de domaine AD DS et DNS, cinq sous-unités organisationnelles et un client membre du domaine.

```
SRV300156534 (10.7.237.212)
  LAB / LABNAT — 172.16.26.0/24
  ├─ SRV01 : DC300156534 — 172.16.26.10
  └─ CLIENT01 — 172.16.26.20

```

## 2. Création du réseau privé Hyper-V

Création du commutateur interne LAB et vérification des commutateurs disponibles. Commandes PowerShell utilisées:

```
Get-VMSwitch
New-VMSwitch -Name LAB -SwitchType Internal
Get-VMSwitch
```

Capture 01 — Commutateur virtuel et état initial [image](https://private-user-images.githubusercontent.com/261489191/709475891-efd279ee-351f-4f3f-973d-40a9b80a9750.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3OTU1MzU0NDUsIm5iZiI6MTc5NTUzNTE0NSwicGF0aCI6Ii8yNjE0ODkxOTEvNzA5NDc1ODkxLWVmZDI3OWVlLTM1MWYtNGYzZi05NzNkLTQwYTliODBhOTc1MC5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjYxMTI0JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI2MTEyNFQxNTQ1NDVaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT01ZWI5NzQwOWExMmEyYTNiMzQ2ZGM0MjdkOTVjOWY3YjYwM2YzZmFhM2VkZGU5OWIxNjM4MDFmZDhhNjk1YTRkJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCZyZXNwb25zZS1jb250ZW50LXR5cGU9aW1hZ2UlMkZwbmcifQ.NSlT1gTP4V3g8XMHmsseoVZ9JMyLbHj2oebAZcKQGmc)

Preuve visuelle de l’étape de configuration ou de vérification correspondante. Capture 02 — Commutateur virtuel et état initial [image](https://private-user-images.githubusercontent.com/261489191/709476418-08272863-e383-42e4-8d30-1f907552e927.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3OTU1MzU0NDUsIm5iZiI6MTc5NTUzNTE0NSwicGF0aCI6Ii8yNjE0ODkxOTEvNzA5NDc2NDE4LTA4MjcyODYzLWUzODMtNDJlNC04ZDMwLTFmOTA3NTUyZTkyNy5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjYxMTI0JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI2MTEyNFQxNTQ1NDVaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT05ZjFhZDdhZDhjZDAyMzdjNzU0YWY4ZWQ4ZDkzOTVlNzkxNDE3NTE2M2NjMjE1OWNhYWU2MDE2YmI5MGYzMWU5JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCZyZXNwb25zZS1jb250ZW50LXR5cGU9aW1hZ2UlMkZwbmcifQ.dWaB09_jRBsEddcmSbF_d3wQuqrXSqTLOVhmMpLs3e8)

Preuve visuelle de l’étape de configuration ou de vérification correspondante. Capture 03 — Commutateur virtuel et état initial [image](https://private-user-images.githubusercontent.com/261489191/709476731-bf47c02d-736b-4838-96a7-61b83dab39e6.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3OTU1MzU0NDUsIm5iZiI6MTc5NTUzNTE0NSwicGF0aCI6Ii8yNjE0ODkxOTEvNzA5NDc2NzMxLWJmNDdjMDJkLTczNmItNDgzOC05NmE3LTYxYjgzZGFiMzllNi5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjYxMTI0JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI2MTEyNFQxNTQ1NDVaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT03MzY2NTc2NTg0NmNlYzY1MWY3MTkxYTgxZWRlYTc2M2FmYmQ5ZTQ1ZmNjMWRhMjlmOTJiOGQ4MTMzOTQyMGVmJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCZyZXNwb25zZS1jb250ZW50LXR5cGU9aW1hZ2UlMkZwbmcifQ.D8kadXAVXgbKXgkumt5npF39jhqeJ3cvGRirhJWT17Y)

Preuve visuelle de l’étape de configuration ou de vérification correspondante. 3. Configuration de la passerelle NAT Attribution de l’adresse 172.16.26.1/24 au commutateur interne et mise en place du NAT LABNAT. Commandes PowerShell utilisées New-NetIPAddress -IPAddress 172.16.26.1 -PrefixLength 24 -InterfaceAlias "vEthernet (LAB)" New-NetNat -Name LABNAT -InternalIPInterfaceAddressPrefix 172.16.26.0/24 Get-NetNat Get-NetIPAddress -InterfaceAlias "vEthernet (LAB)" -AddressFamily IPv4 Capture 04 — Passerelle, interface LAB et NAT [image](https://private-user-images.githubusercontent.com/261489191/709477333-2a0abd60-876f-4b7e-9660-82bb6fd919db.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3OTU1MzU0NDUsIm5iZiI6MTc5NTUzNTE0NSwicGF0aCI6Ii8yNjE0ODkxOTEvNzA5NDc3MzMzLTJhMGFiZDYwLTg3NmYtNGI3ZS05NjYwLTgyYmI2ZmQ5MTlkYi5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjYxMTI0JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI2MTEyNFQxNTQ1NDVaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1kNjBhNWMwOGJmZmZkNjYxMWZjYTRiMzNjZjBlMTM5OTcxOGJjODMwMzY1ZDRmYzEyYmIyZjQxNzZlOTZjOTc5JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCZyZXNwb25zZS1jb250ZW50LXR5cGU9aW1hZ2UlMkZwbmcifQ._LUn7dv6wSdjfqonmp7ywuE0UjFMuCh2CVtlASdtWK0)

Preuve visuelle de l’étape de configuration ou de vérification correspondante. Capture 05 — Passerelle, interface LAB et NAT [image](https://private-user-images.githubusercontent.com/261489191/709477678-a8245b5b-17b9-4981-a06e-263cf96c088c.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3OTU1MzU0NDUsIm5iZiI6MTc5NTUzNTE0NSwicGF0aCI6Ii8yNjE0ODkxOTEvNzA5NDc3Njc4LWE4MjQ1YjViLTE3YjktNDk4MS1hMDZlLTI2M2NmOTZjMDg4Yy5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjYxMTI0JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI2MTEyNFQxNTQ1NDVaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1jYjc0NmNiMGVmYjRkYzhiYmEwMjExYjQ3MDkyZTU3YzM4ZTJjZDJmNTFhNzlkY2ViYWE1MGNhOTRkYzEyYmU0JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCZyZXNwb25zZS1jb250ZW50LXR5cGU9aW1hZ2UlMkZwbmcifQ.3bIPsfnJU6zmNS573RO0Q-0GxKQh39YiMZQFDkRZARE)

Preuve visuelle de l’étape de configuration ou de vérification correspondante. Capture 06 — Passerelle, interface LAB et NAT [image](https://private-user-images.githubusercontent.com/261489191/709478104-89de2571-2718-4e09-95e7-bccf984ffb80.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3OTU1MzU0NDUsIm5iZiI6MTc5NTUzNTE0NSwicGF0aCI6Ii8yNjE0ODkxOTEvNzA5NDc4MTA0LTg5ZGUyNTcxLTI3MTgtNGUwOS05NWU3LWJjY2Y5ODRmZmI4MC5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjYxMTI0JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI2MTEyNFQxNTQ1NDVaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT03NTIwNjgxMGFlZjYwMTQxZDJjYWE4NDE1YWYxNmE1ZjkyZWMwNzZjN2ZlNGYwMGM5ODMxZDk3ZmNmM2QxNWU2JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCZyZXNwb25zZS1jb250ZW50LXR5cGU9aW1hZ2UlMkZwbmcifQ.6V1fDdIUrvJmKW4IGf_nuuQocHh1oxmCDtSSz4O7fas)

Preuve visuelle de l’étape de configuration ou de vérification correspondante. 4. Préparation du contrôleur de domaine Utilisation de la VM SRV01 existante, raccordée au commutateur LAB, puis configuration du nom et de l’adresse IP du contrôleur. Commandes PowerShell utilisées Get-VM Connect-VMNetworkAdapter -VMName SRV01 -SwitchName LAB Get-VMNetworkAdapter -VMName SRV01 Enter-PSSession -VMName SRV01 -Credential (Get-Credential) Get-NetAdapter New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 172.16.26.10 -PrefixLength 24 -DefaultGateway 172.16.26.1 Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses 172.16.26.10 Rename-Computer -NewName "DC300156534" Exit-PSSession Restart-VM -Name SRV01 Capture 07 — Machine virtuelle et préparation du contrôleur [image](https://private-user-images.githubusercontent.com/261489191/709478541-9b1ffb66-0d02-4772-bee2-71f28fe9cfa4.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3OTU1MzU0NDUsIm5iZiI6MTc5NTUzNTE0NSwicGF0aCI6Ii8yNjE0ODkxOTEvNzA5NDc4NTQxLTliMWZmYjY2LTBkMDItNDc3Mi1iZWUyLTcxZjI4ZmU5Y2ZhNC5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjYxMTI0JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI2MTEyNFQxNTQ1NDVaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT01NjM0N2FiYTBhMjA3M2NhZjc1ZGMxMDI1NWY2MzljMTgwNTExZGJjYWNjYTg4YjlhZWE2MzdlN2Q5MmJlMjE4JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCZyZXNwb25zZS1jb250ZW50LXR5cGU9aW1hZ2UlMkZwbmcifQ.EH9ApkE_wqUv48d45vRwNe9xSPXAVwVapE_MqSrnESk)

Preuve visuelle de l’étape de configuration ou de vérification correspondante. Capture 08 — Machine virtuelle et préparation du contrôleur [image](https://private-user-images.githubusercontent.com/261489191/709479031-0533044f-d2d5-4943-9251-4a906e7d9f28.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3OTU1MzU0NDUsIm5iZiI6MTc5NTUzNTE0NSwicGF0aCI6Ii8yNjE0ODkxOTEvNzA5NDc5MDMxLTA1MzMwNDRmLWQyZDUtNDk0My05MjUxLTRhOTA2ZTdkOWYyOC5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjYxMTI0JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI2MTEyNFQxNTQ1NDVaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT03M2NhYjgyN2IwNDZhMmZhODgyMjNhZTEyMTJmYzA5NmRmMGYwZDc0ZWZjMTNjMjc0YjA5ZGZjMTg2YWM5MTg2JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCZyZXNwb25zZS1jb250ZW50LXR5cGU9aW1hZ2UlMkZwbmcifQ.5B9dVZ5-VZINqBuH1hv1dhcybjHfsB8wb6sTV0yZH1Q)

Preuve visuelle de l’étape de configuration ou de vérification correspondante. Capture 09 — Machine virtuelle et préparation du contrôleur [image](https://private-user-images.githubusercontent.com/261489191/709479241-b155c379-f4b2-4d4e-a20a-714d5aed2460.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3OTU1MzU0NDUsIm5iZiI6MTc5NTUzNTE0NSwicGF0aCI6Ii8yNjE0ODkxOTEvNzA5NDc5MjQxLWIxNTVjMzc5LWY0YjItNGQ0ZS1hMjBhLTcxNGQ1YWVkMjQ2MC5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjYxMTI0JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI2MTEyNFQxNTQ1NDVaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0xMWM0ZjM5NTI3NWI0NTBiNGZkNTExZDYzZTk2ZmY3YzcyYmQ1ZjQwYjY3NzcxMzg3ZWE5ZGRkZmY5MDZmZWI0JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCZyZXNwb25zZS1jb250ZW50LXR5cGU9aW1hZ2UlMkZwbmcifQ.Q3y1jJEW9fjH5P5MjbFGNM5fsgO1Dt-qN73u7B9H3E4)

Preuve visuelle de l’étape de configuration ou de vérification correspondante. Capture 10 — Machine virtuelle et préparation du contrôleur [image](https://private-user-images.githubusercontent.com/261489191/709479719-4cf0812b-bf57-4512-8512-a9f8e218f1f8.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3OTU1MzU0NDUsIm5iZiI6MTc5NTUzNTE0NSwicGF0aCI6Ii8yNjE0ODkxOTEvNzA5NDc5NzE5LTRjZjA4MTJiLWJmNTctNDUxMi04NTEyLWE5ZjhlMjE4ZjFmOC5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjYxMTI0JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI2MTEyNFQxNTQ1NDVaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0zODZiNzU0MDRjMDE2M2M4NWIwMWM3ZDBkMGM2MDIxMDAwYWJlNzBlM2YxNDYwNzBmZWU2ZTFkNWE1MDc0NmM5JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCZyZXNwb25zZS1jb250ZW50LXR5cGU9aW1hZ2UlMkZwbmcifQ.AekJz-l74icPBdvpw4EKi8peSDTcxCfGkGmQMZLSeDM)

Preuve visuelle de l’étape de configuration ou de vérification correspondante. 5. Installation des services Active Directory Installation du rôle AD DS sur la VM renommée DC300156534. Commandes PowerShell utilisées Install-WindowsFeature AD-Domain-Services -IncludeManagementTools Get-WindowsFeature AD-Domain-Services Capture 11 — Installation du rôle AD DS [image](https://private-user-images.githubusercontent.com/261489191/709480161-85fb549a-d8bd-4105-b63d-eefd2409fba9.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3OTU1MzU0NDUsIm5iZiI6MTc5NTUzNTE0NSwicGF0aCI6Ii8yNjE0ODkxOTEvNzA5NDgwMTYxLTg1ZmI1NDlhLWQ4YmQtNDEwNS1iNjNkLWVlZmQyNDA5ZmJhOS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjYxMTI0JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI2MTEyNFQxNTQ1NDVaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1hNGZiNGIxYWY4ZjU0MGJhZDE3MDI5NjQ1NzcwODQxZGZjOTk5NDIzMTlhNzU1MDVmYTZjNjU4YzhjMjI4YTJkJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCZyZXNwb25zZS1jb250ZW50LXR5cGU9aW1hZ2UlMkZwbmcifQ.Y9iZ8Mbg5eYULdY-0y1z2iTXggDDkfw-9dhQissk8DY)

Preuve visuelle de l’étape de configuration ou de vérification correspondante. Capture 12 — Installation du rôle AD DS [image](https://private-user-images.githubusercontent.com/261489191/709480357-e99828f0-ec03-408b-a0a1-c0ca2ce53b4d.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3OTU1MzU0NDUsIm5iZiI6MTc5NTUzNTE0NSwicGF0aCI6Ii8yNjE0ODkxOTEvNzA5NDgwMzU3LWU5OTgyOGYwLWVjMDMtNDA4Yi1hMGExLWMwY2EyY2U1M2I0ZC5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjYxMTI0JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI2MTEyNFQxNTQ1NDVaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1jMTIyZDc4YzU4OTk2MjJmOTA4NjhlNzVhN2NiMTEzOTU4ODlhNGI1ODFiMGM1NDU3ZGIwM2U0ODM1NTEwZWJjJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCZyZXNwb25zZS1jb250ZW50LXR5cGU9aW1hZ2UlMkZwbmcifQ.8O0QpRRlu-X9Qbb2_A17qrJZiTj11KhVAuJaq5h7jcI)

Preuve visuelle de l’étape de configuration ou de vérification correspondante. 6. Création de la forêt et du DNS Création de la forêt personnelle. La première tentative a demandé explicitement un nom NetBIOS ; la commande a été corrigée. Commandes PowerShell utilisées Install-ADDSForest -DomainName "DC300156534.local" -DomainNetbiosName "AD300156534" -InstallDNS Get-ADDomain Get-Service NTDS,DNS Capture 13 — Forêt Active Directory et DNS

Preuve visuelle de l’étape de configuration ou de vérification correspondante. Capture 14 — Forêt Active Directory et DNS [image](https://private-user-images.githubusercontent.com/261489191/709481071-bef72221-b505-496e-90c8-04606ce77745.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3OTU1MzU0NDUsIm5iZiI6MTc5NTUzNTE0NSwicGF0aCI6Ii8yNjE0ODkxOTEvNzA5NDgxMDcxLWJlZjcyMjIxLWI1MDUtNDk2ZS05MGM4LTA0NjA2Y2U3Nzc0NS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjYxMTI0JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI2MTEyNFQxNTQ1NDVaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1iMWFkOTM5N2UyOGNlOTU2MDhkN2Y4YzUxZGM0NTFjYWM3NTNlMTQyODI1YjM0NzYyYWUxYTU1MDE3NmYzMmFiJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCZyZXNwb25zZS1jb250ZW50LXR5cGU9aW1hZ2UlMkZwbmcifQ.E0mAOKkMOb5xxpJ8C7VRBVZnsQ99LnM7YtF_qmTk2PA)

Preuve visuelle de l’étape de configuration ou de vérification correspondante. Capture 15 — Forêt Active Directory et DNS [image](https://private-user-images.githubusercontent.com/261489191/709481365-7d51a7d7-3e41-4c5b-a46b-eb2311f91dc1.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3OTU1MzU0NDUsIm5iZiI6MTc5NTUzNTE0NSwicGF0aCI6Ii8yNjE0ODkxOTEvNzA5NDgxMzY1LTdkNTFhN2Q3LTNlNDEtNGM1Yi1hNDZiLWViMjMxMWY5MWRjMS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjYxMTI0JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI2MTEyNFQxNTQ1NDVaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0wMDAxYTJlMGNkOTNlYjRlNWUyYWQ5YjIxZDM0NTJkYWU4ODY1MDZjNGM1MTlkNzkzMWNlMjFjODg2MzNkMzRjJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCZyZXNwb25zZS1jb250ZW50LXR5cGU9aW1hZ2UlMkZwbmcifQ.Mp_gmKRh5RVsxL-87JD9XkKC5QN4US0Y-yPg06oAkPE)

Preuve visuelle de l’étape de configuration ou de vérification correspondante. 7. Organisation Active Directory Création de l’OU principale et des quatre sous-OU prévues par les consignes. Commandes PowerShell utilisées New-ADOrganizationalUnit -Name "OU300156534" New-ADOrganizationalUnit -Name "Students" -Path "OU=OU300156534,DC=DC300156534,DC=local" New-ADOrganizationalUnit -Name "Groups" -Path "OU=OU300156534,DC=DC300156534,DC=local" New-ADOrganizationalUnit -Name "Workstations" -Path "OU=OU300156534,DC=DC300156534,DC=local" New-ADOrganizationalUnit -Name "Servers" -Path "OU=OU300156534,DC=DC300156534,DC=local" Get-ADOrganizationalUnit -Filter \* | Select-Object Name,DistinguishedName Capture 16 — Unités organisationnelles [image](https://private-user-images.githubusercontent.com/261489191/709481899-943f9e77-4a89-4cbb-b855-8d41c00f475c.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3OTU1MzU0NDUsIm5iZiI6MTc5NTUzNTE0NSwicGF0aCI6Ii8yNjE0ODkxOTEvNzA5NDgxODk5LTk0M2Y5ZTc3LTRhODktNGNiYi1iODU1LThkNDFjMDBmNDc1Yy5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjYxMTI0JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI2MTEyNFQxNTQ1NDVaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT03NTdjMDMzOTA3MDEwYmQ3NGJjYWUyYjM3ZWEwMDAyOWQ1YTdlZTgwMDk0MmQwOWJiOGE0N2Y1OTFhMGQ2ZmE3JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCZyZXNwb25zZS1jb250ZW50LXR5cGU9aW1hZ2UlMkZwbmcifQ.GVqo2klgIDHyJmZ9iOE4WBKIpUroSp1DDN3ljk3b5h0)

Preuve visuelle de l’étape de configuration ou de vérification correspondante. Capture 17 — Unités organisationnelles [image](https://private-user-images.githubusercontent.com/261489191/709482146-de95569c-f7d0-4b79-b143-b7c3e9e52f88.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3OTU1MzU0NDUsIm5iZiI6MTc5NTUzNTE0NSwicGF0aCI6Ii8yNjE0ODkxOTEvNzA5NDgyMTQ2LWRlOTU1NjljLWY3ZDAtNGI3OS1iMTQzLWI3YzNlOWU1MmY4OC5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjYxMTI0JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI2MTEyNFQxNTQ1NDVaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT02MzliYTg5NzAzOWJkYTQ2ZmI3NWM1YTFkODMxZmY1NjEwMTZhZDE5ZjM0YzdlODE2NDJlNWI1Mjk0NDg5MmExJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCZyZXNwb25zZS1jb250ZW50LXR5cGU9aW1hZ2UlMkZwbmcifQ.kF9-sI7ZVMq_YMAPrO821m1qO7ZbHoZrmmKoYpaoCmo)

Preuve visuelle de l’étape de configuration ou de vérification correspondante. 8. Création et installation de CLIENT01 Création de CLIENT01 sur LAB, transfert de l’ISO Windows Server 2022, montage du DVD virtuel et installation en mode Desktop Experience. Commandes PowerShell utilisées New-VM -Name CLIENT01 -Generation 2 -MemoryStartupBytes 4GB -NewVHDPath "C:\VMs\CLIENT01.vhdx" -NewVHDSizeBytes 60GB -SwitchName LAB Get-VMHardDiskDrive -VMName CLIENT01 Add-VMDvdDrive -VMName CLIENT01 -Path "C:\iso\en-us_windows_server_2022_updated_july_2023_x64_dvd_541692c3.iso" $dvd = Get-VMDvdDrive -VMName CLIENT01 Set-VMFirmware -VMName CLIENT01 -FirstBootDevice $dvd Set-VMFirmware -VMName CLIENT01 -EnableSecureBoot Off Start-VM -Name CLIENT01 Capture 18 — Création de CLIENT01 et support Windows [image](https://private-user-images.githubusercontent.com/261489191/709482576-a3714e6b-b3f2-418f-a7e8-2c54510e5d25.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3OTU1MzU0NDUsIm5iZiI6MTc5NTUzNTE0NSwicGF0aCI6Ii8yNjE0ODkxOTEvNzA5NDgyNTc2LWEzNzE0ZTZiLWIzZjItNDE4Zi1hN2U4LTJjNTQ1MTBlNWQyNS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjYxMTI0JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI2MTEyNFQxNTQ1NDVaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT00NTI2Mzk3OGE5NDU3Njk2MWM2ZGU4MDlmZTk3NDFiYjk5ZjAwZTlmZDkxM2MxM2IxNTlkMTEzNzJlYWMzMWU5JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCZyZXNwb25zZS1jb250ZW50LXR5cGU9aW1hZ2UlMkZwbmcifQ._wH4dzmaCDM-IEBR0DyTKBguICv0rqMQN6jn7_MknXY)

Preuve visuelle de l’étape de configuration ou de vérification correspondante. Capture 19 — Création de CLIENT01 et support Windows

Preuve visuelle de l’étape de configuration ou de vérification correspondante. Capture 20 — Création de CLIENT01 et support Windows

Preuve visuelle de l’étape de configuration ou de vérification correspondante. 9. Configuration réseau et jonction au domaine Configuration du client et vérification de la communication avec le DC avant la jonction au domaine. Commandes PowerShell utilisées Enter-PSSession -VMName CLIENT01 -Credential (Get-Credential) Get-NetAdapter New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 172.16.26.20 -PrefixLength 24 -DefaultGateway 172.16.26.1 Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses 172.16.26.10 ipconfig /all ping 172.16.26.10 Resolve-DnsName DC300156534.local Rename-Computer -NewName "CLIENT01" Add-Computer -DomainName "DC300156534.local" -Credential "AD300156534\Administrator" -Restart Get-CimInstance Win32_ComputerSystem | Select-Object Name,Domain,PartOfDomain Capture 21 — Installation, réseau et jonction de CLIENT01 [image](https://private-user-images.githubusercontent.com/261489191/709483116-560ecf39-1c7b-4aa6-af3f-13b7955c97cd.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3OTU1MzU0NDUsIm5iZiI6MTc5NTUzNTE0NSwicGF0aCI6Ii8yNjE0ODkxOTEvNzA5NDgzMTE2LTU2MGVjZjM5LTFjN2ItNGFhNi1hZjNmLTEzYjc5NTVjOTdjZC5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjYxMTI0JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI2MTEyNFQxNTQ1NDVaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT05YWMzMDZhOGNlOTllODRkYzZlMmIwODBhOTk5YjkxYjlhNGVjODQyNGEyYmNjMzQ2ZmU2OWRmMjk1ZDBhYzc1JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCZyZXNwb25zZS1jb250ZW50LXR5cGU9aW1hZ2UlMkZwbmcifQ.5gxUI1JoC7vABY23FjEWrTVXR22RrvyQSwmO_g7BTUk)

Preuve visuelle de l’étape de configuration ou de vérification correspondante. Capture 22 — Installation, réseau et jonction de CLIENT01 [image](https://private-user-images.githubusercontent.com/261489191/709484843-5ba215c4-f0d6-4c1b-8fca-ffc3b4de549b.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3OTU1MzU0NDUsIm5iZiI6MTc5NTUzNTE0NSwicGF0aCI6Ii8yNjE0ODkxOTEvNzA5NDg0ODQzLTViYTIxNWM0LWYwZDYtNGMxYi04ZmNhLWZmYzNiNGRlNTQ5Yi5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjYxMTI0JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI2MTEyNFQxNTQ1NDVaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1mYThiZWE3NGUxMzg4NTIwMzhiMzU5N2MwMWQzM2VhZjY3ZTlkODJlZmQzN2ZlY2ZlYzM0NzFlNmYyMzkyOTdkJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCZyZXNwb25zZS1jb250ZW50LXR5cGU9aW1hZ2UlMkZwbmcifQ.qEOuBEeHsHKkXn3XU7zWXYIcwkW63OxV1wx92QCsUds)

Preuve visuelle de l’étape de configuration ou de vérification correspondante. Capture 23 — Installation, réseau et jonction de CLIENT01 [image](https://private-user-images.githubusercontent.com/261489191/709484581-56657533-b760-48e2-a431-2df837a1f344.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3OTU1MzU0NDUsIm5iZiI6MTc5NTUzNTE0NSwicGF0aCI6Ii8yNjE0ODkxOTEvNzA5NDg0NTgxLTU2NjU3NTMzLWI3NjAtNDhlMi1hNDMxLTJkZjgzN2ExZjM0NC5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjYxMTI0JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI2MTEyNFQxNTQ1NDVaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0xNTE3YjgzZmY0ZjUwODdiZWY5MTk5ZTdmYTgwOGQxNmM3Y2UxZmM1ZWNjNWJhNWEwYzNkY2UzNzRiYjAyMTRiJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCZyZXNwb25zZS1jb250ZW50LXR5cGU9aW1hZ2UlMkZwbmcifQ.DpOY2U2J_hj27vOHnsEZpGDOb-8Vt-Z_fCGKMpAFtd0)

Preuve visuelle de l’étape de configuration ou de vérification correspondante. Capture 24 — Installation, réseau et jonction de CLIENT01 [image](https://private-user-images.githubusercontent.com/261489191/709483709-83b7924d-371a-4c18-ba07-de022dda6cec.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3OTU1MzU0NDUsIm5iZiI6MTc5NTUzNTE0NSwicGF0aCI6Ii8yNjE0ODkxOTEvNzA5NDgzNzA5LTgzYjc5MjRkLTM3MWEtNGMxOC1iYTA3LWRlMDIyZGRhNmNlYy5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjYxMTI0JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI2MTEyNFQxNTQ1NDVaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1kOTgxNmI3NTdhMGMxOWJlNjQyZmJmY2JhZDkxMzBmYTQ0OTM4NGY4NGU0MThhN2NjYjgyNDg3N2Y5YmU2MTdkJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCZyZXNwb25zZS1jb250ZW50LXR5cGU9aW1hZ2UlMkZwbmcifQ.raYYmU2C66PsjzhwrG83FfSRauexIxaR8BVodczG-yA)

Preuve visuelle de l’étape de configuration ou de vérification correspondante. Capture 25 — Installation, réseau et jonction de CLIENT01 [image](https://private-user-images.githubusercontent.com/261489191/709483825-e4ce85de-3842-47e2-8324-679fa796c010.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3OTU1MzU0NDUsIm5iZiI6MTc5NTUzNTE0NSwicGF0aCI6Ii8yNjE0ODkxOTEvNzA5NDgzODI1LWU0Y2U4NWRlLTM4NDItNDdlMi04MzI0LTY3OWZhNzk2YzAxMC5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjYxMTI0JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI2MTEyNFQxNTQ1NDVaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0wMmVhYzMyNjBiZDAwZWNkNGUyYTM4M2Y3MjAxMWU4YTYwN2ZlNGM2Mjc5ZTMzM2ViMDY3ZTI2ZGU3NDFiZTdjJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCZyZXNwb25zZS1jb250ZW50LXR5cGU9aW1hZ2UlMkZwbmcifQ.EevTjK5jPiJpIgi6rOhMGfKzrMiu12Zfd5l4-bND2ms)

## 10. Modifications et vérifications du 24 novembre 2026

### 10.1. Création de ServiceAccounts

J’ai ajouté une cinquième sous-OU pour les comptes de service. La seconde tentative a retourné une erreur de doublon, car la première avait réussi.

```powershell
New-ADOrganizationalUnit -Name "ServiceAccounts" -Path "OU=OU300156534,DC=DC300156534,DC=local"
Get-ADOrganizationalUnit -Filter * | Select-Object Name, DistinguishedName
```

```text
OU300156534
├── Servers
├── Workstations
├── Groups
├── Students
└── ServiceAccounts
```

### 10.2. Groupe de sécurité et utilisateur

J’ai créé le groupe global de sécurité GG_Students dans Groups et ajouté le compte etudiant01.

```powershell
New-ADGroup -Name "GG_Students" -GroupScope Global -GroupCategory Security -Path "OU=Groups,OU=OU300156534,DC=DC300156534,DC=local"
Add-ADGroupMember -Identity "GG_Students" -Members "etudiant01"
Get-ADGroupMember -Identity "GG_Students" | Select-Object Name, SamAccountName
```

Résultat : Etudiant01 est membre du groupe GG_Students.

### 10.3. Déplacement du client

```powershell
Move-ADObject -Identity "CN=CLIENT01,CN=Computers,DC=DC300156534,DC=local" -TargetPath "OU=Workstations,OU=OU300156534,DC=DC300156534,DC=local"
Get-ADComputer -Identity "CLIENT01" | Select-Object Name, DistinguishedName, Enabled
```

Résultat : CLIENT01 est actif et se trouve dans Workstations.

### 10.4. Vérification du domaine et des services

```powershell
Get-GPO -All | Select-Object DisplayName, GpoStatus
Get-ADDomain | Select-Object DNSRoot, NetBIOSName, DomainMode
Get-ADForest | Select-Object Name, RootDomain, ForestMode
Get-DnsServerZone | Select-Object ZoneName, ZoneType, IsDsIntegrated
Get-ADDomainController -Filter * | Select-Object Name, IPv4Address, Domain, IsGlobalCatalog
Get-Service NTDS, DNS, Netlogon
dcdiag /q
```

| Élément | Résultat |
|---|---|
| Domaine | DC300156534.local |
| Niveau fonctionnel du domaine | Windows2016Domain |
| Niveau fonctionnel de la forêt | Windows2016Forest |
| Catalogue global | True |
| NTDS, DNS, Netlogon | Running |
| Zones DNS du domaine et _msdcs | Intégrées à AD |
| GPO | Deux stratégies par défaut actives |
| dcdiag /q | Aucune erreur affichée |

### 10.5. Vérification de CLIENT01

Depuis le serveur parent :

```powershell
Get-VM | Select-Object Name, State
Enter-PSSession -VMName CLIENT01 -Credential (Get-Credential)
```

Depuis CLIENT01 :

```powershell
hostname
ipconfig /all
nslookup DC300156534.local
ping 172.16.26.10
Test-ComputerSecureChannel
```

| Élément | Résultat |
|---|---|
| SRV01 et CLIENT01 | Running |
| Adresse client | 172.16.26.20/24 |
| Passerelle | 172.16.26.1 |
| DNS | 172.16.26.10 |
| Relation de confiance | True |

Le test Test-ComputerSecureChannel avait échoué sur le contrôleur de domaine. Cette commande est destinée aux ordinateurs membres ; le résultat True obtenu sur CLIENT01 valide son canal sécurisé.

### 10.6. Réinitialisation du mot de passe étudiant

Une première tentative de connexion a échoué. J’ai vérifié l’état du compte puis réinitialisé son mot de passe sur le contrôleur de domaine.

```powershell
Get-ADUser -Identity etudiant01 -Properties LockedOut,PasswordExpired | Select-Object Name,Enabled,LockedOut,PasswordExpired
Set-ADAccountPassword -Identity etudiant01 -Reset -NewPassword (Read-Host "Nouveau mot de passe" -AsSecureString)
```

Le compte était actif, non verrouillé et son mot de passe non expiré.

### 10.7. Comptes et mots de passe — CONFIDENTIEL

| Compte | Mot de passe | Remarque |
|---|---|---|
| Administrator | `walid@2026` | Indiqué dans le rapport initial ; non revérifié |
| AD300156534\etudiant01 | `walid@2027` | Nouveau mot de passe du 24 novembre |

Ne pas publier ces identifiants sur GitHub. Les mots de passe des autres comptes éventuels ne sont pas documentés.

### 10.8. Connexion avec le compte étudiant

J’ai ouvert une session sur CLIENT01 avec le compte du domaine etudiant01. Dans PowerShell, j’ai exécuté :

```powershell
whoami
hostname
whoami /groups
```

Résultats confirmés : `ad300156534\etudiant01` et `CLIENT01`. La liste des groupes est partiellement visible sur la capture ; la présence de GG_Students dans le jeton de session reste à vérifier.

Captures complémentaires à insérer : création de ServiceAccounts, groupe GG_Students, déplacement du client, diagnostics AD/DNS, canal sécurisé et connexion étudiante.

## 11. Résultats et conclusion

Les vérifications réseau ont donné quatre réponses sur quatre au ping du contrôleur de domaine, sans perte de paquets. Le DNS retourne 172.16.26.10. CLIENT01 est membre du domaine et son canal sécurisé est valide. La connexion avec le compte étudiant a réussi. L’infrastructure Hyper-V, AD DS et DNS est fonctionnelle. Les modifications du 24 novembre complètent les configurations précédentes. La conformité exhaustive aux consignes originales reste à vérifier.
