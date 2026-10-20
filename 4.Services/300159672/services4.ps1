Stop-Service -Name DFSR
(Get-Service -name DFSR).status
Start-Service -Name DFSR
