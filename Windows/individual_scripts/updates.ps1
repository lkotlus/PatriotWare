# Windows updates

if ($args[0] -eq "-h") {
    Get-Content readmes\updates.md
    Exit 1
}

$String = Write-Output "Would you like to do Windows updates? (y/n)"
$Selection = Read-Host $String
switch ($Selection) {
    'y' {
        Write-Output "Lit, moving on..."
    }
    'n' {
        Write-Output "Okay, bye."
        Exit
    }
}

# Starting hte updates service
Write-Output "Starting the Windows update service and setting it's startup type to automatic..."
$service = Get-Service -Name "wuauserv" 
Start-Service -InputObject $service 
Set-Service -InputObject $service -StartupType Automatic
Write-Output "Done!"

# Checking for updates
Write-Output "Checking for updates..."
Get-WindowsUpdate

# Installing updates
Write-Output "Installing updates (be CAREFUL)..."
Install-WindowsUpdate