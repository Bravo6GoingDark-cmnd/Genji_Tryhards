# Ask for the username and assign it to $user
$user = Read-Host 'Enter the EXACT name of the user you are currently logged in as'

# Create the necessary directories on the user's desktop
New-Item -Path "C:\Users\$user\Desktop\scripterino" -ItemType Directory -Force
New-Item -Path "C:\Users\$user\Desktop\scripterino\userfiles" -ItemType Directory -Force
New-Item -Path "C:\Users\$user\Desktop\scripterino\programfiles" -ItemType Directory -Force
New-Item -Path "C:\Users\$user\Desktop\scripterino\programfilesx86" -ItemType Directory -Force
New-Item -Path "C:\Users\$user\Desktop\scripterino\documents" -ItemType Directory -Force

# Grabbing user files
Write-Host 'Grabbing user files...'
Get-ChildItem -Path "C:\Users\*" -Include *.jpg,*.png,*.aac,*.ac3,*.avi,*.aiff,*.bat,*.bmp,*.exe,*.flac,*.gif,*.jpeg,*.mov,*.m3u,*.m4p,*.mp2,*.mp3,*.mp4,*.mpeg4,*.midi,*.msi,*.ogg,*.png,*.txt,*.sh,*.wav,*.wma,*.vqf,*.pcap,*.zip,*.pdf,*.json -Recurse | Copy-Item -Destination "C:\Users\$user\Desktop\scripterino\userfiles" -Force

# Grabbing program files
Write-Host 'Grabbing program files...'
Get-ChildItem -Path "C:\Program Files\*" -Include *.jpg,*.png,*.aac,*.ac3,*.avi,*.aiff,*.bat,*.bmp,*.exe,*.flac,*.gif,*.jpeg,*.mov,*.m3u,*.m4p,*.mp2,*.mp3,*.mp4,*.mpeg4,*.midi,*.msi,*.ogg,*.png,*.txt,*.sh,*.wav,*.wma,*.vqf,*.pcap,*.zip,*.pdf,*.json -Recurse | Copy-Item -Destination "C:\Users\$user\Desktop\scripterino\programfiles" -Force

Get-ChildItem -Path "C:\Program Files (x86)\*" -Include *.jpg,*.png,*.aac,*.ac3,*.avi,*.aiff,*.bat,*.bmp,*.exe,*.flac,*.gif,*.jpeg,*.mov,*.m3u,*.m4p,*.mp2,*.mp3,*.mp4,*.mpeg4,*.midi,*.msi,*.ogg,*.png,*.txt,*.sh,*.wav,*.wma,*.vqf,*.pcap,*.zip,*.pdf,*.json -Recurse | Copy-Item -Destination "C:\Users\$user\Desktop\scripterino\programfilesx86" -Force

# Grabbing documents
Write-Host 'Grabbing Documents...'
Get-ChildItem -Path "C:\Users\$user\Documents\*" -Include *.jpg,*.png,*.aac,*.ac3,*.avi,*.aiff,*.bat,*.bmp,*.exe,*.flac,*.gif,*.jpeg,*.mov,*.m3u,*.m4p,*.mp2,*.mp3,*.mp4,*.mpeg4,*.midi,*.msi,*.ogg,*.png,*.txt,*.sh,*.wav,*.wma,*.vqf,*.pcap,*.zip,*.pdf,*.json -Recurse | Copy-Item -Destination "C:\Users\$user\Desktop\scripterino\documents" -Force

# Catching media files
Write-Host 'Catching special media files...'
Get-ChildItem -Path "C:\Users" -Include *.jpg,*.png,*.jpeg,*.avi,*.mp4,*.mp3,*.wav -Exclude *.dll,*.doc,*.docx -File -Recurse -ErrorAction SilentlyContinue | Out-File -FilePath "C:\Users\$user\Desktop\scripterino\Mediafiles.txt"

Write-Host "Process completed! Files saved under C:\Users\$user\Desktop\scripterino"
