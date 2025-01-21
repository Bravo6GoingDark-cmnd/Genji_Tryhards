**Do the Forensic Questions before running these and you must read the readme before this.**


Save the file as specified on this repo.        Ex:        Here -> tasks.ps1        U Save as -> tasks.ps1

1. Start with recommended policies. Copy-paste the contents into a notepad and save it as .inf file. Then run it as admin in powershell.
2. Then run the local_policy.bat You just need to run it as an admin.
3. Run firewall.ps1. If points are removed. check the reason and figure to undo it.
4. Check if remotedesktop is required. If not, run Disable_remoteDesktop.ps1.
5. Run services.ps1 and u must check readme for important services before running this.
6. Run User.ps1 **Remember the passwords changes for everyone.**
7. Run server_shares.ps1
8. Run interesting file.ps1 **Try to run it at the end. You won't need this. Use Malwarebytes or something.**
9. Run test.ps1 **BE CAREFUL WITH THIS SCRIPT**
10. Run auto_update.
11. Run reg_editor.ps1. **Be careful with this one too**
12. Run unwanted_filedumpre.ps1    **THIS IS NOT REQUIRED. AGAIN, USE MALWAREBYTES.**
