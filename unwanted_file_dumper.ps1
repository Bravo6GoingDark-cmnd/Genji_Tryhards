#CODE CHECK PASSED!!!
# Ask for the username and assign it to $user
$user = Read-Host 'Enter the EXACT name of the user you are currently logged in as'

# Define base path
$desktopPath = "C:\Users\$user\Desktop\scripterino"

# Create necessary directories
New-Item -Path "$desktopPath" -ItemType Directory -Force
New-Item -Path "$desktopPath\userfiles" -ItemType Directory -Force
New-Item -Path "$desktopPath\programfiles" -ItemType Directory -Force
New-Item -Path "$desktopPath\programfilesx86" -ItemType Directory -Force
New-Item -Path "$desktopPath\documents" -ItemType Directory -Force

# Grabbing user files
Write-Host 'Grabbing user files...'
Get-ChildItem -Path "C:\Users\*" -Include *.jpg,*.png,*.aac,*.ac3,*.avi,*.bat,*.bmp,*.exe,*.flac,*.gif,*.jpeg,*.mov,*.mp3,*.mp4,*.pdf,*.json -Recurse -ErrorAction SilentlyContinue |
    Copy-Item -Destination "$desktopPath\userfiles" -Force

# Grabbing program files
Write-Host 'Grabbing program files...'
Get-ChildItem -Path "C:\Program Files\*" -Include *.exe,*.dll,*.txt -Recurse -ErrorAction SilentlyContinue |
    Copy-Item -Destination "$desktopPath\programfiles" -Force

Get-ChildItem -Path "C:\Program Files (x86)\*" -Include *.exe,*.dll,*.txt -Recurse -ErrorAction SilentlyContinue |
    Copy-Item -Destination "$desktopPath\programfilesx86" -Force

# Grabbing documents
Write-Host 'Grabbing documents...'
Get-ChildItem -Path "C:\Users\$user\Documents\*" -Include *.doc,*.docx,*.pdf,*.txt -Recurse -ErrorAction SilentlyContinue |
    Copy-Item -Destination "$desktopPath\documents" -Force

# Catching media files
Write-Host 'Catching special media files...'
Get-ChildItem -Path "C:\Users" -Include *.jpg,*.png,*.jpeg,*.avi,*.mp4,*.mp3,*.wav -File -Recurse -ErrorAction SilentlyContinue |
    Out-File -FilePath "$desktopPath\Mediafiles.txt"

Write-Host "Process completed! Files saved under $desktopPath"
