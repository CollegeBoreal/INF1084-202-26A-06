Stop-Service -Name DFSR -ErrorAction Stop; try { Get-Service DFSR } finally { Start-Service DFSR }; Get-Service DFSR
