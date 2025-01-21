#CHECKS NOT COMPLETED FOR THIS CODE
#You must check all of this with your readme and then run this.
# Secure Kerberos Maximum Lifetime for Service Ticket
Write-Host "Configuring Kerberos Maximum Lifetime for Service Ticket..."
Import-Module ActiveDirectory
Set-ADDefaultDomainPasswordPolicy -Domain (Get-ADDomain).DNSRoot -MaxTicketAge 04:00:00  # 4 hours

# Enable Audit Process Creation [Success]
Write-Host "Enabling Audit Process Creation (Success)..."
auditpol /set /subcategory:"Process Creation" /success:enable

# Include command-line data in process creation events
Write-Host "Enabling command-line data in process creation events..."
Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System\Audit" -Name "ProcessCreationIncludeCmdLine_Enabled" -Value 1

# Domain Users may not enable computer and user accounts to be trusted for delegation
Write-Host "Removing 'Enable computer and user accounts to be trusted for delegation' for Domain Users..."
secedit /export /cfg "C:\Temp\SecurityConfig.inf"
(Get-Content "C:\Temp\SecurityConfig.inf") -replace "SeEnableDelegationPrivilege = .*", "SeEnableDelegationPrivilege = " | Set-Content "C:\Temp\SecurityConfig.inf"
secedit /configure /db secedit.sdb /cfg "C:\Temp\SecurityConfig.inf" /areas USER_RIGHTS

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
$acl = Get-Acl -Path "\\<DomainName>\SYSVOL"
$acl.RemoveAccessRule((New-Object System.Security.AccessControl.FileSystemAccessRule("Everyone", "FullControl", "Allow")))
Set-Acl -Path "\\<DomainName>\SYSVOL" -AclObject $acl

# Disable AD Certificate Services
Write-Host "Disabling Active Directory Certificate Services..."
Stop-Service CertSvc
Set-Service CertSvc -StartupType Disabled

# Disable Windows Fax Service
Write-Host "Disabling Windows Fax Service..."
Stop-Service Fax
Set-Service Fax -StartupType Disabled

# Chrome blocks intrusive ads
Write-Host "Configuring Chrome to block intrusive ads..."
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "DefaultAdsSetting" -Value 2

# Disable DNS zone transfers to any server
Write-Host "Disabling DNS zone transfers to any server..."
Set-DnsServerZoneTransferPolicy -Name "BlockZoneTransfers" -PolicyType Deny

# Disable anonymous LDAP bind
Write-Host "Disabling anonymous LDAP bind..."
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\NTDS\Parameters" -Name "LDAPServerRequireSignOrSeal" -Value 1

Write-Host "All requested configurations have been applied successfully!"
