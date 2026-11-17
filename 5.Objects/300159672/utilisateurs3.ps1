
# Autoriser RDP sur la machine
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0

# Autoriser le firewall RDP
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

# Le groupe Students peut se connecter en RDP
Add-ADGroupMember -Identity "Remote Desktop Users" -Members "Students"

# Droit "Allow log on through Remote Desktop Services" (SeRemoteInteractiveLogonRight)
# secedit /export echoue sur ce serveur : la ligne est ajoutee directement dans GptTmpl.inf
$f = "C:\Windows\SYSVOL\domain\Poli
