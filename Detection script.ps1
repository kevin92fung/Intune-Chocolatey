$package = "<package name>" 
$installed = choco list -i

if ($installed -like "*$package*") {
    Write-Host "installerad"
    Exit 0
} else {
    Exit 0
}