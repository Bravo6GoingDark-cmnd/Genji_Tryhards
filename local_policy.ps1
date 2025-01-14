#account policies
net accounts /UNIQUEPW:24 /MAXPWAGE:60 /MINPWAGE:1 /MINPWLEN:12 /lockoutthreshold:5

#localpolicies-audit policies
auditpol /set /category:"Account Logon" /success:enable #is everything really just success and failure?
auditpol /set /category:"Account Logon" /failure:enable

auditpol /set /category:"Account Management" /success:enable
auditpol /set /category:"Account Management" /failure:enable

auditpol /set /category:"DS Access" /success:enable
auditpol /set /category:"DS Access" /failure:enable

auditpol /set /category:"Logon/Logoff" /success:enable
auditpol /set /category:"Logon/Logoff" /failure:enable

auditpol /set /category:"Object Access" /success:enable
auditpol /set /category:"Object Access" /failure:enable

auditpol /set /category:"Policy Change" /success:enable
auditpol /set /category:"Policy Change" /failure:enable

auditpol /set /category:"Privilege Use" /success:enable
auditpol /set /category:"Privilege Use" /failure:enable

auditpol /set /category:"Detailed Tracking" /success:enable
auditpol /set /category:"Detailed Tracking" /failure:enable

auditpol /set /category:"System" /success:enable 
auditpol /set /category:"System" /failure:enable
