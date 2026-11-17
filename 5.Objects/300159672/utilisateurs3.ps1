# Autoriser RDP sur la machine
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0

# Autoriser le firewall RDP
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

# Le groupe Students peut se connecter en RDP
Add-ADGroupMember -Identity "Remote Desktop Users" -Members "Students"

# Droit "Allow log on through Remote Desktop Services" (SeRemoteInteractiveLogonRight)
# secedit /export echoue sur ce serveur : la ligne est ajoutee directement dans GptTmpl.inf
$f = "C:\Windows\SYSVOL\domain\Policies\{6AC1786C-016F-11D2-945F-00C04FB984F9}\MACHINE\Microsoft\Windows NT\SecEdit\GptTmpl.inf"
Copy-Item $f C:\GptTmpl.inf.bak
$sid = (Get-ADGroup Students).SID.Value
$lines = Get-Content $f
$i = [array]::IndexOf($lines, "[Privilege Rights]")
$new = "SeRemoteInteractiveLogonRight = *S-1-5-32-544,*$sid"
$lines = $lines[0..$i] + $new + $lines[($i+1)..($lines.Count-1)]
Set-Content -Path $f -Value $lines -Encoding Unicode

# Monter la version de la GPO pour qu'elle soit appliquee
$ini = "C:\Windows\SYSVOL\domain\Policies\{6AC1786C-016F-11D2-945F-00C04FB984F9}\GPT.INI"
(Get-Content $ini) -replace "Version=1","Version=2" | Set-Content $ini
Set-ADObject -Identity "CN={6AC1786C-016F-11D2-945F-00C04FB984F9},CN=Policies,CN=System,DC=DC300159672,DC=local" -Replace @{versionNumber=2}
gpupdate
