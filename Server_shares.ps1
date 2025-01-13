$user = 'ADJUST'
#grabbing network shares check if irregular
'grabbing shares bb'
net share > scripterino\shares.txt

#flush DNS
'flushing dns cache'
ipconfig /flushdns

#Grabbing hosts file
'grabbing hosts file'	
New-Item -Path C:\Users\$user\Desktop\scripterino\hosts -ItemType directory
Get-ChildItem -Path "C:\Windows\System32\drivers\etc\hosts" | Copy-Item -Destination C:\Users\$user\Desktop\scripterino\hosts
