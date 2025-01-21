#CODE CHECKS PASSED!!!
# Create the folder "scripterino" if it doesn't already exist
$folderPath = ".\scripterino"
if (-not (Test-Path -Path $folderPath)) {
    New-Item -Path $folderPath -ItemType Directory
}

# Grab processes with a working set > 20MB and save to interestingprocess.txt in the "scripterino" folder
Get-Process | Where-Object {$_.WorkingSet -gt 20000000} > "$folderPath\interestingprocess.txt"
