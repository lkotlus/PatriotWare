#This script was made for administrating the administrators

if ($args[0] -eq "-h") {
    Get-Content readmes\admins.md
    Exit 1
}

$String = "Have you come after editing the data_files\badAdmins.txt file? (y/n)"
$Selection = Read-Host $String
Switch($Selection) {
    'y' {
        "Oh, fun!"

        $badAdmins = Get-Content data_files\badAdmins.txt
        .\functions\yn.ps1 "Would you like to delete the following users?`n${badAdmins}`n(y/n)" "Cool" "Cool, exiting. Make sure to edit the data_files\badUsers.txt file and come back!" "-d" "-e"

        foreach ($badAdmin in $badAdmins) {
            Write-Output "User $badAdmin is no longer an administrator."
            Remove-LocalGroupMember -Group "Administrators" -Member $badAdmin
        }

        Exit 1
    }
    'n' {
        "Bepic, moving on..."
    }
}

.\functions\whiteSpace.ps1 "data_files\badAdmins.txt"
.\functions\whiteSpace.ps1 "data_files\goodAdmins.txt"
.\functions\whiteSpace.ps1 "data_files\admins.txt"

# if ($args[0]) {
   #Write the alternative way in here. 
# }

Write-Output "" > data_files\badAdmins.txt
Write-Output "Administrator" >> data_files\goodAdmins.txt

$admins = Get-LocalGroupMember "Administrators" | Select-Object Name

for ($i = 0; $i -lt $admins.length; $i++) {
    $tmp = ($admins[$i] -split '\\')[1]
    $admins[$i] = $tmp.substring(0, $tmp.length-1)
}

Write-Output $admins > data_files\admins.txt
$goodAdmins = Get-Content data_files\goodAdmins.txt 

$badAdmins = Compare-Object $goodAdmins $admins -PassThru | Where-Object {
    $_.SideIndicator -eq "=>"
}

Write-Output $badAdmins > data_files\badAdmins.txt

$String = Write-Output "Would you like to delete the following users?`n${badAdmins}`n(y/n)"
$Selection = Read-Host $String
switch ($Selection) {
    'y' {
        Write-Output "Cool"
    }
    'n' {
        Write-Output "Cool, exiting. Make sure to edit the data_files\badAdmins.txt file and come back!"
        Exit 1
    }
}        

foreach ($badAdmin in $badAdmins) {
    Write-Output "User $badAdmin is no longer an administrator."
    Remove-LocalGroupMember -Group "Administrators" -Member $badAdmin
}

Write-Output "Thank you and have fun."