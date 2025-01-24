#DON'T USE. TESTING FAILED
# Get the username of the currently logged-in user
$user = $env:USERNAME

# Enable all firewall profiles (Domain, Public, Private) with logging
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True -DefaultInboundAction Block -DefaultOutboundAction Allow -NotifyOnListen True -AllowUnicastResponseToMulticast True -LogFileName "%SystemRoot%\System32\LogFiles\Firewall\pfirewall.log" -LogAllowed True -LogBlocked True

# Import custom firewall rules if the file exists
if (Test-Path "C:\Users\$user\Desktop\Win10Firewall.wfw") {
    netsh advfirewall import "C:\Users\$user\Desktop\Win10Firewall.wfw"
}

# Disable Remote Assistance rules
netsh advfirewall firewall set rule name="Remote Assistance (DCOM-In)" new enable=no
netsh advfirewall firewall set rule name="Remote Assistance (PNRP-In)" new enable=no
netsh advfirewall firewall set rule name="Remote Assistance (RA Server TCP-In)" new enable=no
netsh advfirewall firewall set rule name="Remote Assistance (SSDP TCP-In)" new enable=no
netsh advfirewall firewall set rule name="Remote Assistance (SSDP UDP-In)" new enable=no
netsh advfirewall firewall set rule name="Remote Assistance (TCP-In)" new enable=no

# Disable other unneeded rules for remote access and management
netsh advfirewall firewall set rule name="Telnet Server" new enable=no
netsh advfirewall firewall set rule name="netcat" new enable=no
netsh advfirewall firewall set rule name="Remote Registry" new enable=no
netsh advfirewall firewall set rule name="File and Printer Sharing" new enable=no
netsh advfirewall firewall set rule group="Network Discovery" new enable=No

# Block common insecure services and protocols
New-NetFirewallRule -DisplayName "Block RDP (3389)" -Direction Inbound -LocalPort 3389 -Protocol TCP -Action Block
New-NetFirewallRule -DisplayName "Block SSH (22)" -Direction Inbound -LocalPort 22 -Protocol TCP -Action Block
New-NetFirewallRule -DisplayName "Block FTP (21)" -Direction Inbound -LocalPort 21 -Protocol TCP -Action Block
New-NetFirewallRule -DisplayName "Block Telnet (23)" -Direction Inbound -LocalPort 23 -Protocol TCP -Action Block
New-NetFirewallRule -DisplayName "Block SMTP (25)" -Direction Inbound -LocalPort 25 -Protocol TCP -Action Block
New-NetFirewallRule -DisplayName "Block POP3 (110)" -Direction Inbound -LocalPort 110 -Protocol TCP -Action Block
New-NetFirewallRule -DisplayName "Block SNMP (161)" -Direction Inbound -LocalPort 161 -Protocol TCP -Action Block

# Block WinRM (Windows Remote Management) services
New-NetFirewallRule -DisplayName "Block WinRM HTTP (5985)" -Direction Inbound -LocalPort 5985 -Protocol TCP -Action Block
New-NetFirewallRule -DisplayName "Block WinRM HTTPS (5986)" -Direction Inbound -LocalPort 5986 -Protocol TCP -Action Block

# Optional: Block ICMP to prevent ping requests (use with caution)
# New-NetFirewallRule -DisplayName "Block ICMP" -Direction Inbound -Protocol ICMPv4 -Action Block
