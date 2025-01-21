#CODE CHECKS PASSED!!!
$user = 'ADJUST'

# Create the "scripterino" folder if it doesn't exist
$folderPath = "C:\Users\$user\Desktop\scripterino"
if (-not (Test-Path -Path $folderPath)) {
    New-Item -Path $folderPath -ItemType Directory
}

# Grabbing network shares and checking if irregular, output to shares.txt
'grabbing shares bb'
net share > "$folderPath\shares.txt"

# Flush DNS cache
'flushing dns cache'
ipconfig /flushdns

# Grabbing hosts file
'grabbing hosts file'
$hostsFolder = "$folderPath\hosts"
if (-not (Test-Path -Path $hostsFolder)) {
    New-Item -Path $hostsFolder -ItemType Directory
}
Copy-Item -Path "C:\Windows\System32\drivers\etc\hosts" -Destination $hostsFolder
