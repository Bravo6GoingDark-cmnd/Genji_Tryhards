#TAKE SNAPSHOT BEFORE USING THIS!!!!!
# Ensure C:\Temp exists
if (-not (Test-Path "C:\Temp")) {
    New-Item -Path "C:\Temp" -ItemType Directory
}

# Secure Kerberos Maximum Lifetime for Service Ticket
Write-Host "Configuring Kerberos Maximum Lifetime for Service Ticket..."
Import-Module ActiveDirectory

# Set Kerberos Max Ticket Age (4 hours)
# Use Group Policy or modify krbtgt directly (instead of Set-ADKerberosPolicy)
Set-ADObject -Identity "CN=krbtgt,CN=Users,DC=YourDomain,DC=com" -Replace @{MaxTicketAge = "04:00:00"}

# Enable Audit Process Creation [Success]
Write-Host "Enabling Audit Process Creation (Success)..."
auditpol /set /subcategory:"Process Creation" /success:enable

# Include command-line data in process creation events
Write-Host "Enabling command-line data in process creation events..."
Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System\Audit" -Name "ProcessCreationIncludeCmdLine_Enabled" -Value 1

# Domain Users may not enable computer and user accounts to be trusted for delegation
Write-Host "Removing 'Enable computer and user accounts to be trusted for delegation' for Domain Users..."
secedit /export /cfg "C:\Temp\SecurityConfig.inf"
if (Test-Path "C:\Temp\SecurityConfig.inf") {
    (Get-Content "C:\Temp\SecurityConfig.inf") -replace "SeEnableDelegationPrivilege = .*", "SeEnableDelegationPrivilege = " | Set-Content "C:\Temp\SecurityConfig.inf"
    secedit /configure /db secedit.sdb /cfg "C:\Temp\SecurityConfig.inf" /areas USER_RIGHTS
} else {
    Write-Host "SecurityConfig.inf not found. Exiting script."
    exit
}

# Administrators may not act as part of the operating system
Write-Host "Disabling 'Act as part of the operating system' for Administrators..."
(Get-Content "C:\Temp\SecurityConfig.inf") -replace "SeTcbPrivilege = .*", "SeTcbPrivilege = " | Set-Content "C:\Temp\SecurityConfig.inf"
secedit /configure /db secedit.sdb /cfg "C:\Temp\SecurityConfig.inf" /areas USER_RIGHTS

# LDAP server signing requirements [Require signing]
Write-Host "Enabling LDAP server signing requirements..."
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\NTDS\Parameters" -Name "LDAPServerIntegrity" -Value 2

# Do not allow anonymous enumeration of SAM accounts and shares
Write-Host "Disabling anonymous enumeration of SAM accounts and shares..."
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name "RestrictAnonymousSAM" -Value 1

# Hardened UNC Paths configured for SYSVOL
Write-Host "Configuring Hardened UNC Paths for SYSVOL..."
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\NetworkProvider\HardenedPaths" -Name "\\*\SYSVOL" -Value "RequireMutualAuthentication=1,RequireIntegrity=1" -PropertyType String -Force

# Windows preserves zone information in file attachments
Write-Host "Enabling preservation of zone information in file attachments..."
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Attachments" -Name "SaveZoneInformation" -Value 2

# Remove Everyone full share permissions from SYSVOL
Write-Host "Removing 'Everyone' full share permissions from SYSVOL..."
$sysvolPath = "\\example.com\SYSVOL"  # Replace with your actual domain
if (Test-Path $sysvolPath) {
    $acl = Get-Acl -Path $sysvolPath
    $acl.RemoveAccessRule((New-Object System.Security.AccessControl.FileSystemAccessRule("Everyone", "FullControl", "Allow")))
    Set-Acl -Path $sysvolPath -AclObject $acl
} else {
    Write-Host "SYSVOL path not found. Exiting script."
    exit
}

# Disable AD Certificate Services (Only if installed)
Write-Host "Disabling Active Directory Certificate Services..."
if (Get-Service -Name "CertSvc" -ErrorAction SilentlyContinue) {
    Stop-Service CertSvc
    Set-Service CertSvc -StartupType Disabled
} else {
    Write-Host "Active Directory Certificate Services not found."
}

# Disable Windows Fax Service (Only if installed)
Write-Host "Disabling Windows Fax Service..."
if (Get-Service -Name "Fax" -ErrorAction SilentlyContinue) {
    Stop-Service Fax
    Set-Service Fax -StartupType Disabled
} else {
    Write-Host "Windows Fax Service not found."
}

# Chrome blocks intrusive ads (Ensure registry path exists)
Write-Host "Configuring Chrome to block intrusive ads..."
$chromePath = "HKLM:\SOFTWARE\Policies\Google\Chrome"
if (-not (Test-Path $chromePath)) {
    New-Item -Path $chromePath -Force
}
Set-ItemProperty -Path $chromePath -Name "DefaultAdsSetting" -Value 2

# Disable DNS zone transfers to any server
Write-Host "Disabling DNS zone transfers to any server..."
Set-DnsServerZoneTransferPolicy -ZoneName "YourDomainName" -PolicyType Deny  # Replace with your actual domain

# Disable anonymous LDAP bind
Write-Host "Disabling anonymous LDAP bind..."
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\NTDS\Parameters" -Name "LDAPServerRequireSignOrSeal" -Value 1

Write-Host "All requested configurations have been applied successfully!"
