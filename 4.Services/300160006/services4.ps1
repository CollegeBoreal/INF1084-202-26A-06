Stop-Service -Name DFSR
(Get-Service -Name DFSR).Status
Start-Service -Name DFSR