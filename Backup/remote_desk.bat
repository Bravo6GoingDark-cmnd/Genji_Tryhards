rem Disable Remote Desktop
echo Disabling Remote Desktop...
sc stop "TermService"
sc config "TermService" start=disabled
sc stop "SessionEnv"
sc config "SessionEnv" start=disabled
sc stop "UmRdpService"
sc config "UmRdpService" start=disabled
sc stop "RemoteRegistry"
sc config "RemoteRegistry" start=disabled
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v "fDenyTSConnections" /t REG_DWORD /d 1 /f
echo Finished reg
