#TESTING NOT COMPLETE
# Function to disable scheduled tasks
Function Disable-Tasks {
    Unregister-ScheduledTask -TaskPath *Bluetooth* -ErrorAction SilentlyContinue
    Unregister-ScheduledTask -TaskPath *Location* -ErrorAction SilentlyContinue
    Unregister-ScheduledTask -TaskPath *Maps* -ErrorAction SilentlyContinue
    Unregister-ScheduledTask -TaskPath *UPnP* -ErrorAction SilentlyContinue
    Unregister-ScheduledTask -TaskPath '*Plug and Play*' -ErrorAction SilentlyContinue
    Unregister-ScheduledTask -TaskPath '*Windows Error Reporting*' -ErrorAction SilentlyContinue
}

# Export the function so it can be used after importing the module
Export-ModuleMember -Function Disable-Tasks

# code calls the function to disable tasks right after loading the script
Disable-Tasks
