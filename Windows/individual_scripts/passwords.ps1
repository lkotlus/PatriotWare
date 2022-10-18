if ($args[0] -eq "-h") {
    Get-Content readmes\passwords.md
    Exit 1
}

$String = Write-Output "Would you like to set the password policy? (y/n)"
$Selection = Read-Host $String
switch ($Selection) {
    'y' {
        Write-Output "Cool. The current state password policies are:"
        net accounts
        $Selection = Read-Host "Please enter the force logoff time (Recommended: NO)"
        net accounts /forcelogoff:$Selection
        $Selection = Read-Host "Please enter the minimum password length (Recommended: 10)"
        net accounts /minpwlen:$Selection
        $Selection = Read-Host "Please enter the maximum password age (Recommended: 30)"
        net accounts /maxpwage:$Selection
        $Selection = Read-Host "Please enter the minimum password age (Recommended: 10)"
        net accounts /minpwage:$Selection
        $Selection = Read-Host "Please enter the number of unique passwords stored (Recommended: 5)"
        net accounts /uniquepw:$Selection
        $Selection = Read-Host "Please enter the lockout threshold (Recommended: 5)"
        net accounts /lockoutthreshold:$Selection
        $Selection = Read-Host "Enter whatever you want, I'm setting password complexity requirements to enabled. N00bs G3t pwnd."
        secedit /export /cfg c:\secpol.cfg
        (Get-Content C:\secpol.cfg).replace("PasswordComplexity = 0", "PasswordComplexity = 1") | Out-File C:\secpol.cfg
        secedit /configure /db c:\windows\security\local.sdb /cfg c:\secpol.cfg /areas SECURITYPOLICY
        Remove-Item -force c:\secpol.cfg -confirm:$false
        $Selection = Read-Host "Please enter the lockout duration (Recommended: 15, must be >= current lockout window)"
        net accounts /lockoutduration:$Selection
        $Selection = Read-Host "Please enter the lockout window (Recommended: 15, must be <= lockout duration)"
        net accounts /lockoutwindow:$Selection
    }
    'n' {
        Write-Output "Wow. Woooooow. WOOOOOOOOOOOWWWWWWW. SOMBODY is DEFINITELY NOT invited to my birthday party."
    }
}

.\functions\whiteSpace.ps1 "data_files\users.txt"
.\functions\getUsers.ps1 "data_files\users.txt"
$users = Get-Content "data_files\users.txt"
$passwd = $args[0]
$String = Write-Output "Would you like to set EVERY USERS password to `"${passwd}`"? (y/n)"
$Selection = Read-Host $String
switch ($Selection) {
    'y' {
        Write-Output "Cool"
    }
    'n' {
        Write-Output "Epic, use the correct password nex time."
        Exit 1
    }
} 

$securePasswd = ConvertTo-SecureString -String $passwd -AsPlainText -Force

foreach ($user in $users) {
    Write-Output "Password changed for user ${user}"
    Set-LocalUser -Name $user -Password $securePasswd    
}