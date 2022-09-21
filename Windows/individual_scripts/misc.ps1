# Does a bunch of random crap

if ($args[0] -eq "-h") {
    Get-Content readmes\misc.md
    Exit 1
}

$String = Write-Output "Would you like to do a bunch of random stuff? (y/n)"
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

# Setting all audit policies to success/failure
Write-Output "Setting all audit policies to success/failure..."
auditpol /set /category:* /failure:enable /success:enable
Write-Output "Done!"

Write-Output "Setting up UAC..."
secedit /export /cfg c:\secpol.cfg
(Get-Content C:\secpol.cfg) -replace "MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\System\\ConsentPromptBehaviorAdmin.*", "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\ConsentPromptBehaviorAdmin=4,2" | Out-File C:\secpol.cfg
(Get-Content C:\secpol.cfg) -replace "MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\System\\ConsentPromptBehaviorUser.*", "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\ConsentPromptBehaviorUser=4,3" | Out-File C:\secpol.cfg
(Get-Content C:\secpol.cfg) -replace "MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\System\\PromptOnSecureDesktop.*", "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\PromptOnSecureDesktop=4,1" | Out-File C:\secpol.cfg
secedit /configure /db c:\windows\security\local.sdb /cfg c:\secpol.cfg /areas SECURITYPOLICY
Remove-Item -force c:\secpol.cfg -confirm:$false
Write-Output "Done!"

Write-Output "Doing shared drive stuff...`n"
$shares = Get-WmiObject -class Win32_Share | Select-Object Name
foreach ($share in $shares) {
    Write-Output $share.Name
    $String = Write-Output "Would you like to remove the above shared drive (ADMIN$, C$, and IPC$ are default, but can be deleted anyway)? (y/n)"
    $Selection = Read-Host $String
    switch ($Selection) {
        'y' {
            Write-Output "Lit, removing..."
            Remove-SmbShare -Name $share.Name
            Write-Output "Done!`n"
        }
        'n' {
            Write-Output "Okay, moving on to the next one.`n"
        }
    }
}