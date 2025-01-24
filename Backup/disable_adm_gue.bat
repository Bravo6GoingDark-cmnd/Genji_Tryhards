rem Disable Unnecessary Accounts
echo Disabling unnecessary accounts...
net user administrator /active:no
net user guest /active:no
echo Finished
