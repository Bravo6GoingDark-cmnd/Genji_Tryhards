# Description:
# This script stops and disables unwanted Windows services. If the ReadMe specifies essential services, comment out that service by putting a # infront of the service like the example below.

$services = @(
    #"nameOfEssentialService"                  # Description
    "FTPSVC"                                   # Microsoft FTP Service
    "lfsvc"                                    # Geolocation Service
    "MapsBroker"                               # Downloaded Maps Manager
    "NetTcpPortSharing"                        # Net.Tcp Port Sharing Service
    "RemoteAccess"                             # Routing and Remote Access
    "RemoteRegistry"                           # Remote Registry
    "RDSessMgr"                                # Helps with Remote Assistance functionality
    "SNMPTRAP"                                 # Simple Network Management Protocol (too old!)
    "storSvc"                                  # SSD Discovery Service
    "TapiSrv"                                  # Telephony
    "TlntSvr"                                  # Telnet
    "XboxGipSvc"                               # Manages connected Xbox Accessories
    "XblAuthManager"                           # Xbox Live Auth Manager
    "XblGameSave"                              # Xbox Live Game Save Service
    "XboxNetApiSvc"                            # Xbox Live Networking Service
)

foreach ($service in $services) {
    if (Get-Service -Name $service -ErrorAction SilentlyContinue) {
        Write-Output "Stopping and disabling $service..."
        Stop-Service -Name $service -Force
        Set-Service -Name $service -StartupType Disabled
    } else {
        Write-Output "Service $service not found."
    }
}

Write-Output "Script complete!"
