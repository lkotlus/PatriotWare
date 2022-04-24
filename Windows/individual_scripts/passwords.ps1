if ($args[0] -eq "-h") {
    Get-Content readmes\passwords.md
    Exit 1
}

.\functions\whiteSpace.ps1 "data_files\users.txt"
.\functions\getUsers.ps1 "data_files\users.txt"
$users = Get-Content "data_files\users.txt"
$passwd = $args[0]
$String = Write-Output "Would you like to set EVERY USERS password to ${passwd}? (y/n)"
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