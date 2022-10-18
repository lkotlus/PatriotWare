# Running all the scripts

if ($args[0] -eq "-h") {
    Get-Content readmes\megaScript.md
    Exit 1
}

$scripts = @("delUsers.ps1", "missingUsers.ps1", "admins.ps1", "delFiles.ps1", "services.ps1", "scheduledTasks.ps1", "passwords.ps1", "firewall.ps1", "misc.ps1", "winDefender.ps1", "updates.ps1")

for ($i = $args[0]; $i -lt $scripts.length; $i++) {
    $currentScript = $scripts[$i]
    $String = Write-Output "Would you like to run the ${currentScript} script? (y/n)"
    $Selection = Read-Host $String
    switch ($Selection) {
        'y' {
            Write-Output "Cool"
            if ($i -eq 6) {
                $passwd = $args[1]
                Invoke-Expression ".\individual_scripts\$currentScript $passwd"
            }
            else {
                Invoke-Expression ".\individual_scripts\$currentScript"
            }
        }
        'n' {
            Write-Output "Cool, moving on..."
        }
    }  
} 