::DON'T USE THIS. WORK IN PROGRESS. MAY CRASH EVERYTHIN



@echo off
rem Main Script

rem Disable Unnecessary Accounts
echo Disabling unnecessary accounts...
net user administrator /active:no
net user guest /active:no
echo Finished

rem Enable Firewall
echo Enabling firewall...
netsh advfirewall set allprofiles state on
echo Firewall Finished

rem Manage Registry Keys
echo Configuring registry keys...
reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU /v AutoInstallMinorUpdates /t REG_DWORD /d 1 /f
reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU /v NoAutoUpdate /t REG_DWORD /d 0 /f
reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU /v AUOptions /t REG_DWORD /d 4 /f
echo Finished reg keys

rem Disable Remote Desktop
echo Disabling Remote Desktop...
sc stop "TermService"
sc config "TermService" start=manual
sc stop "SessionEnv"
sc config "SessionEnv" start=manual
sc stop "UmRdpService"
sc config "UmRdpService" start=manual
sc stop "RemoteRegistry"
sc config "RemoteRegistry" start=manual
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v "fDenyTSConnections" /t REG_DWORD /d 1 /f
echo Finished reg

rem ------------------------------------------------------------------------------------
rem Services Management
echo ------------------------------------------------------------------------------------
echo *** Services Management                                                             ***
echo ------------------------------------------------------------------------------------

rem List of services to manage
set services=Telephony TapiSrv Tlntsvr p2pimsvc simptcp fax msftpsvc iprip ftpsvc RasMan RasAuto seclogon MSFTPSVC W3SVC SMTPSVC Dfs TrkWks MSDTC DNS ERSVC NtFrs MSFtpsvc helpsvc HTTPFilter IISADMIN IsmServ WmdmPmSN Spooler RDSessMgr RPCLocator RsoPProv ShellHWDetection ScardSvr Sacsvr Uploadmgr VDS VSS WINS WinHttpAutoProxySvc SZCSVC CscService hidserv IPBusEnum PolicyAgent SCPolicySvc SharedAccess SSDPSRV Themes upnphost nfssvc nfsclnt MSSQLServerADHelper

rem Manual mode: Step through each service with a prompt
echo ------------------------------------------------------------------------------------
echo *** Running in Manual Mode: Prompting for each service...                       ***
for %%a in (%services%) do (
    choice /c yn /m "Do you wish to set %%a to manual mode?"
    if %ERRORLEVEL% equ 1 (
        echo Setting %%a to manual mode...
        sc config "%%a" start=manual >nul 2>&1
    ) else if %ERRORLEVEL% equ 2 (
        echo Skipping %%a...
    )
)
echo *** Finished Manual Mode                                                        ***
echo ------------------------------------------------------------------------------------
