@echo off
REM Services Management
echo ------------------------------------------------------------------------------------
echo *** Services Management                                                             ***
echo ------------------------------------------------------------------------------------

REM Prompt for services management mode
choice /c ync /m "Do you wish to disable any services? (Manual and automatic mode are available)"
if %ERRORLEVEL% equ 3 (
    echo Canceling...
    pause
    goto :eof
)
if %ERRORLEVEL% equ 2 (
    echo Skipping services...
    goto :eof
)

REM Prompt for manual or automatic mode
choice /c am /m "Manual or automatic mode? (Manual mode steps through each service while automatic mode disables them all)"
set mode=%ERRORLEVEL%

REM List of services to manage
set services=Telephony TapiSrv Tlntsvr p2pimsvc simptcp fax msftpsvc iprip ftpsvc RasMan RasAuto seclogon MSFTPSVC W3SVC SMTPSVC Dfs TrkWks MSDTC DNS ERSVC NtFrs MSFtpsvc helpsvc HTTPFilter IISADMIN IsmServ WmdmPmSN Spooler RDSessMgr RPCLocator RsoPProv ShellHWDetection ScardSvr Sacsvr Uploadmgr VDS VSS WINS WinHttpAutoProxySvc SZCSVC CscService hidserv IPBusEnum PolicyAgent SCPolicySvc SharedAccess SSDPSRV Themes upnphost nfssvc nfsclnt MSSQLServerADHelper

REM Automatic mode: Disable all services without further prompts
if %mode% equ 1 (
    echo ------------------------------------------------------------------------------------
    echo *** Running in Automatic Mode: Disabling all listed services...                  ***
    for %%a in (%services%) do (
        echo Disabling %%a...
        sc stop "%%a" >nul 2>&1
        sc config "%%a" start=disabled >nul 2>&1
    )
    echo *** Finished Automatic Mode                                                     ***
    echo ------------------------------------------------------------------------------------
    goto :eof
)

REM Manual mode: Step through each service with a prompt
if %mode% equ 2 (
    echo ------------------------------------------------------------------------------------
    echo *** Running in Manual Mode: Prompting for each service...                       ***
    for %%a in (%services%) do (
        choice /c yn /m "Do you wish to disable %%a?"
        if %ERRORLEVEL% equ 1 (
            echo Disabling %%a...
            sc stop "%%a" >nul 2>&1
            sc config "%%a" start=disabled >nul 2>&1
        ) else (
            echo Skipping %%a...
        )
    )
    echo *** Finished Manual Mode                                                        ***
    echo ------------------------------------------------------------------------------------
    goto :eof
)
