Skriptet installerar applikationer med chocolatey. Finns Chocolatey inte på datorn installeras det innan 
den valda applikationen installeras. Packetera skriptet som win32App för att använda tillsammans med intune.

För att installera applikationer med detta skript använder man install och uninstall commands.
Install
powershell.exe -ex bypass .\choco_install.ps1 <Applikationens namn>
Uninstall
powershell.exe -ex bypass .\choco_install.ps1 <Applikationens namn> uninstall
