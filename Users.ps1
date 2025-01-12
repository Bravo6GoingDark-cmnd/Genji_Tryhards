#disabling guest/admin and renaming them
    'disabling Guest and Admin account'
    Get-LocalUser Guest | Disable-LocalUser
    Get-LocalUser Administrator | Disable-LocalUser
    'renaming guest and admin account'
    $adminAccount =Get-WMIObject Win32_UserAccount -Filter "Name='Administrator'"
    $result =$adminAccount.Rename("adminBOI")
    $guestAccount =Get-WMIObject Win32_UserAccount -Filter "Name='Guest'"
    $result =$guestAccount.Rename("guestBOI")


#REKING PLEBS AND THEIR SHIT PASSWORDS
    'reking plebs and their shit passwords'
    get-wmiobject win32_useraccount | ForEach-Object {
    ([adsi](“WinNT://”+$_.caption).replace(“\”,”/”)).SetPassword(“CyberPatriot@123”)      #change the password to whatever you want other plebs passwords to be.
    }

