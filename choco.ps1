<#>
Skriptet installerar applikationer med chocolatey. Finns Chocolatey inte på datorn installeras det innan 
den valda applikationen installeras. Packetera skriptet som win32App för att använda tillsammans med intune.

För att installera applikationer med detta skript använder man install och uninstall commands.
Install
powershell.exe -ex bypass .\choco_install.ps1 <Applikationens namn>
Uninstall
powershell.exe -ex bypass .\choco_install.ps1 <Applikationens namn> uninstall
</#>

PARAM (
[Parameter(Mandatory=$true, Position=0)]
    [string]$package,
[Parameter(Mandatory=$false, Position=1)]
    [string]$uninstall
)

$chocoInstallPath = "C:\ProgramData\chocolatey\bin\choco.exe"
$libPath = "C:\ProgramData\Chocolatey\lib"
#installerar Chocolatey om Chocolatey inte är installerad, updaterar ifall Chocolatey är installerad

if (-Not (Test-Path $chocoInstallPath)) {
    try {
        # Försök installera Chocolatey
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    }
    catch {
        Throw "Installationen misslyckades"
    }
}
else {
    try {
        # Försök att uppdatera Chocolatey
        Invoke-Expression "cmd.exe /c $chocoInstallPath upgrade chocolatey -y" -ErrorAction Stop
    }
    catch {
        Throw "Uppdateringen misslyckades"
    }
}

#installation av applikation
if ($uninstall -eq "uninstall") {
    try {
        Invoke-Expression "cmd.exe /c $chocoInstallPath uninstall $package -y" -ErrorAction Stop
        $folders = Get-ChildItem -Path $libPath -Directory | Where-Object { $_.Name -like "*$package*" }
            foreach ($folder in $folders){
                Remove-Item -Path $folder.FullName -Recurse -Force
            }
    }
    catch {
        Throw "Avinstallationen misslyckades"
    }
}
else {
    try {
        Invoke-Expression "cmd.exe /c $chocoInstallPath install $package -y" -ErrorAction Stop
    }
    catch {
        Throw "Installationen misslyckades"
    }
}