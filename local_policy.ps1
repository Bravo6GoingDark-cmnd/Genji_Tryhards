# Account Policies
net accounts /UNIQUEPW:24 /MAXPWAGE:90 /MINPWAGE:1 /MINPWLEN:14 /lockoutthreshold:5 /lockoutduration:30 /lockoutbadcount:5 /passwordhistory:24 /ForceLogoffWhenHourExpire:1

# Audit Policies
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


# Disable Guest and Admin Accounts
Get-LocalUser -Name "Administrator" | Disable-LocalUser
Get-LocalUser -Name "Guest" | Disable-LocalUser

Get-LocalUser -Name "Guest" | Disable-LocalUser

#Local security policy
secpol.msc /configure /PasswordComplexity:1
secpol.msc /configure /RestrictCDRomAccess:1
secpol.msc /configure /RestrictFloppyAccess:1
secpol.msc /configure /LDAPServerSigningRequirements:1
secpol.msc /configure /DigitalEncryptOrSignSecureChannel:1
secpol.msc /configure /AllowBlankAnonymousEnumeration:0
secpol.msc /configure /DoNotDisplayLastUserName:1
secpol.msc /configure /LimitUseOfBlankPasswords:1
secpol.msc /configure /SendUnencryptedPasswordToSMBServer:0
secpol.msc /configure /SignCommunicationsAlwaysClient:1
secpol.msc /configure /SignCommunicationsAlwaysServer:1
secpol.msc /configure /AllowAnonymousSIDNameTranslation:0
secpol.msc /configure /LetEveryonePermissionsApplyToAnonymousUser:0
secpol.msc /configure /NoLMHash:1
secpol.msc /configure /AdminApprovalModePromptOnSecureDesktop:1
secpol.msc /configure /CreateTokenObject:None
