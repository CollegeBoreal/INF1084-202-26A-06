# 300160006

`Rename-Computer -NewName "SRV300160006" -Restart
`


``PS C:\Users\Administrator> hostname
SRV300160006``


``Install-WindowsFeature AD-Domain-Services -IncludeManagementTools``

``PS C:\Users\Administrator> Install-WindowsFeature AD-Domain-Services -IncludeManagementTools

Success Restart Needed Exit Code      Feature Result
------- -------------- ---------      --------------
True    No             Success        {Active Directory Domain Services, Group P...``

``Install-ADDSForest `
    -DomainName "DC300160006.local" `
    -DomainNetbiosName "DC300160006" `
    -InstallDns:$true `
    -SafeModeAdministratorPassword (ConvertTo-SecureString "MotDePasseDSRM123!" -AsPlainText -Force) `
    -Force``
