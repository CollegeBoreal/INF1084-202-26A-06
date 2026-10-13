function Test-RDPSession {
    param(
        [Parameter(Mandatory=$true)]
        [string]$ComputerName,

        [Parameter(Mandatory=$true)]
        [string]$Username,

        [Parameter(Mandatory=$true)]
        [string]$Password
    )

    # UTF-8 output (optional)
    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8

    Write-Host "Testing RDP connection to $ComputerName with $Username" -ForegroundColor Cyan

    # Add credential for MSTSC
    cmdkey /generic:"$ComputerName" /user:"$Username" /pass:"$Password" | Out-Null

    # Launch RDP GUI
    $proc = Start-Process "mstsc.exe" -ArgumentList "/v:$ComputerName /admin" -PassThru

    # Wait for the window to appear
    Start-Sleep -Seconds 5

    # Look for the RDP window
    $rdpWindow = Get-Process | Where-Object { $_.MainWindowTitle -like "*$ComputerName*" }

    # Remove stored credential
    cmdkey /delete:"$ComputerName" | Out-Null

    Write-Host "Test completed" -ForegroundColor Yellow

    if ($rdpWindow) {
        Write-Host "RDP SUCCESS: Window detected" -ForegroundColor Green
        $rdpWindow | Stop-Process -Force
        return $true
    }
    else {
        Write-Host "RDP FAILED: Wrong password or RDP disabled" -ForegroundColor Red
        return $false
    }

}
