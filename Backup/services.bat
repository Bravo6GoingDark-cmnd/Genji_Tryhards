@echo off
setlocal enabledelayedexpansion

Rem Services
choice /c ync /m "Do you wish to disable any services? (Manual and automatic mode are available) "
if %ERRORLEVEL% equ 3 (
    echo Canceling...
    pause
    goto:eof
)
if %ERRORLEVEL% equ 2 echo Skipping services...
if %ERRORLEVEL% equ 1 (
    choice /c amc /m "Manual or automatic mode? (Manual mode steps through each service while automatic mode disables them all) "
    set /a mode=!ERRORLEVEL!
    if !mode! equ 3 (
        echo Skipping services... 
    ) else (
        set services=Telephony TapiSrv Tlntsvr tlntsvr p2pimsvc simptcp fax msftpsvc iprip ftpsvc RasMan RasAuto seclogon MSFTPSVC W3SVC SMTPSVC Dfs TrkWks MSDTC DNS ERSVC NtFrs MSFtpsvc helpsvc HTTPFilter IISADMIN IsmServ WmdmPmSN Spooler RDSessMgr RPCLocator RsoPProv ShellHWDetection ScardSvr Sacsvr Uploadmgr VDS VSS WINS WinHttpAutoProxySvc SZCSVC CscService hidserv IPBusEnum PolicyAgent SCPolicySvc SharedAccess SSDPSRV Themes upnphost nfssvc nfsclnt MSSQLServerADHelper
        echo ------------------------------------------------------------------------------------
        echo *** Managing services...                                                         ***
        Rem Automatic mode
        if !mode! equ 1 (
            for %%a in (!services!) do (
                echo Disabling %%a
                sc stop "%%a"
                sc config "%%a" start=disabled
            )
        Rem Manual mode
        ) else (
            for %%a in (!services!) do (
                choice /c yn /m "Do you wish to disable %%a? "
                if !ERRORLEVEL! equ 1 (
                    echo Disabling %%a...
                    sc stop "%%a"
                    sc config "%%a" start=disabled
                ) else (
                    echo Skipping %%a...
                )
            )
        )
        echo *** Finished                                                                     ***
        echo ------------------------------------------------------------------------------------
    )
)

endlocal
