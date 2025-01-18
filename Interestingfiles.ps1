#processes that have bigger loads
'grabbing dem interesting process'
Get-Process | Where-Object {$_.WorkingSet -gt 20000000} > scripterino\interestingprocess.txt
