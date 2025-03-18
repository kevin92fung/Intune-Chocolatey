PARAM (
[Parameter(Mandatory=$true, Position=0)]
    [string]$package,
[Parameter(Mandatory=$false, Position=1)]
    [string]$uninstall
)

$chocoInstallPath = "C:\ProgramData\chocolatey\bin\choco.exe"
$libPath = "C:\ProgramData\Chocolatey\lib"

#Step 1, checks if Chocolatey is installed. Installs if not installed and updates if installed.

if (-Not (Test-Path $chocoInstallPath)) {
    try {
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    }
    catch {
        Throw "Install failed"
    }
}
else {
    try {
        Invoke-Expression "cmd.exe /c $chocoInstallPath upgrade chocolatey -y" -ErrorAction Stop
    }
    catch {
        Throw "Install failed"
    }
}

#Step 2, Install and uninstall of the selected package
if ($uninstall -eq "uninstall") {
    try {
        Invoke-Expression "cmd.exe /c $chocoInstallPath uninstall $package -y" -ErrorAction Stop
        $folders = Get-ChildItem -Path $libPath -Directory | Where-Object { $_.Name -like "*$package*" }
            foreach ($folder in $folders){
                Remove-Item -Path $folder.FullName -Recurse -Force
            }
    }
    catch {
        Throw "Uninstall failed"
    }
}
else {
    try {
        Invoke-Expression "cmd.exe /c $chocoInstallPath install $package -y" -ErrorAction Stop
    }
    catch {
        Throw "Install failed"
    }
}
