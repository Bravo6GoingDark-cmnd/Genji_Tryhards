:: # TESTING NOT COMPLETE
:: # CHECK YOUR LOCAL POLICY AFTER RUNNING IF THEY CHANGED OR NOT.
@echo off
:: Enable color in the terminal
echo.
echo Starting the Security Configuration Script...
echo.
color 0A

:: # Account Policies (Green Comments)
echo Configuring Account Policies...
net accounts /UNIQUEPW:24 /MAXPWAGE:90 /MINPWAGE:1 /MINPWLEN:10 /FORCELOGOFF:60 /LOCKOUTTHRESHOLD:5 /LOCKOUTDURATION:30 /PASSWORDHISTORY:24 /COMPLEXITYENABLED:YES /REVERSIBLEENCRYPTION:NO
echo Account Policies configured successfully.
echo.

:: # Audit Policies
echo Configuring Audit Policies...
auditpol /set /category:"Account Logon" /success:enable /failure:enable
auditpol /set /category:"Account Management" /success:enable /failure:enable
auditpol /set /category:"DS Access" /success:enable /failure:enable
auditpol /set /category:"Logon/Logoff" /success:enable /failure:enable
auditpol /set /category:"Object Access" /success:enable /failure:enable
auditpol /set /category:"Policy Change" /success:enable /failure:enable
auditpol /set /category:"Privilege Use" /success:enable /failure:enable
auditpol /set /category:"Detailed Tracking" /success:enable /failure:enable
auditpol /set /category:"Process Tracking" /success:enable /failure:enable
auditpol /set /category:"System" /success:enable /failure:enable
echo Audit Policies configured successfully.
echo.

:: # Disable Guest and Admin Accounts
echo Disabling Administrator and Guest accounts...
Get-LocalUser -Name "Administrator" | Disable-LocalUser
Get-LocalUser -Name "Guest" | Disable-LocalUser
echo Administrator and Guest accounts disabled successfully.
echo.

:: # Local Security Policy (Using SecEdit)
echo Configuring Local Security Policies...
:: Export current security policies to a template
secedit /export /cfg c:\temp\current_security.inf
:: Create the updated template dynamically
(
echo [System Access]
echo PasswordComplexity = 1
echo MinimumPasswordAge = 1
echo MaximumPasswordAge = 90
echo MinimumPasswordLength = 10
echo PasswordHistorySize = 24
echo LockoutBadCount = 5
echo ResetLockoutCount = 30
echo ForceLogoffWhenHourExpire = 1
echo [Event Audit]
echo AuditSystemEvents = 3
echo AuditLogonEvents = 3
echo AuditObjectAccess = 3
echo AuditPrivilegeUse = 3
echo AuditPolicyChange = 3
echo AuditAccountManage = 3
echo AuditProcessTracking = 3
echo AuditDSAccess = 3
echo AuditAccountLogon = 3
) > c:\temp\updated_security.inf
:: Apply the updated security policy
secedit /configure /db secedit.sdb /cfg c:\temp\updated_security.inf /quiet
echo Local Security Policies configured successfully.
echo.

:: # Local Group Policy
echo Configuring Local Group Policies...
:: Enable Windows Defender SmartScreen to prompt for warning
reg ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\SmartScreen" /v Enabled /t REG_DWORD /d 1 /f
reg ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\SmartScreen" /v PromptOnHighRisk /t REG_DWORD /d 1 /f
:: Disable AutoPlay for all drives
reg ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoAutoplay /t REG_DWORD /d 1 /f
reg ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoAutoplayForNonVolume /t REG_DWORD /d 1 /f
echo Local Group Policies configured successfully.
echo.

:: Final Message
echo Script Execution Completed Successfully!
pause
