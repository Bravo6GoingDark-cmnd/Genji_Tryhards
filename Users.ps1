# Disabling Guest and Admin accounts
'Disabling Guest and Admin accounts'
Disable-LocalUser -Name 'Guest'
Disable-LocalUser -Name 'Administrator'

# Renaming Guest and Admin accounts
'Renaming Guest and Admin accounts'
Rename-LocalUser -Name 'Administrator' -NewName 'Cyberadmin'
Rename-LocalUser -Name 'Guest' -NewName 'Cyberguest'

# Updating passwords for all local user accounts
'Updating passwords for all local user accounts'
$users = Get-LocalUser
foreach ($user in $users) {
    $password = ConvertTo-SecureString -String 'CyberPatriot@123' -AsPlainText -Force
    Set-LocalUser -Name $user.Name -Password $password
}
