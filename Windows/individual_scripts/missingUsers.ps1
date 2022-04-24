# This scrpt was made for administrating users on the machine.

if ($args[0] -eq "-h") {
    Get-Content readmes\missingUsers.md
    Exit 1
}

.\functions\whiteSpace.ps1 "data_files\goodUsers.txt"
.\functions\whiteSpace.ps1 "data_files\missingUsers.txt"
.\functions\whiteSpace.ps1 "data_files\users.txt"

function cut {
    param(
      [Parameter(ValueFromPipeline=$True)] [string]$inputobject,
      [string]$delimiter='\s+',
      [string[]]$field
    )
  
    process {
      if ($null -eq $field) { $inputobject -split $delimiter } else {
        ($inputobject -split $delimiter)[$field] }
    }
}
#The above function was stolen from stack overflow. What are you gonna do, cry?

$String = "Have you come after editing the data_files\missingUsers.txt file? (y/n)"
$Selection = Read-Host $String
Switch($Selection) {
    'y' {
        "Oh, fun!"

        .\functions\getUsers.ps1 "data_files\users.txt"

        $users = Get-Content data_files\users.txt
        $goodUsers = Get-Content data_files\goodUsers.txt
        $missingUsers = Get-Content data_files\missingUsers.txt

        $String = Write-Output "Would you like to add the following users?`n${missingUsers}`n(y/n)"
        $Selection = Read-Host $String
        switch ($Selection) {
            'y' {
                Write-Output "Cool"
            }
            'n' {
                Write-Output "Cool, exiting. Make sure to edit the data_files\missingUsers.txt file and come back!"
                Exit 1
            }
        } 

        foreach ($missingUser in $missingUsers) {
            Write-Output "The user ${missingUser} was added. (Along with your mom lmao XDDDDDDDDDDDD)"
        }
        
        Exit 1
    }
    'n' {
        "Bepic, moving on..."
    }
}

Write-Output "" > data_files\missingUsers.txt

.\functions\getUsers.ps1 "data_files\users.txt"

$users = Get-Content data_files\users.txt
$goodUsers = Get-Content data_files\goodUsers.txt
$missingUsers = Compare-Object $goodUsers $users -PassThru | Where-Object {
    $_.SideIndicator -eq "<="
}

foreach ($missingUser in $missingUsers) {
    if ($missingUser -eq $missingUsers[0]) {
        Write-Output $missingUser > data_files\missingUsers.txt
    }
    else {
        Write-Output $missingUser >> data_files\missingUsers.txt
    }
}

if ($missingUsers.Length -eq 0) {
    Write-Output "No users needed to be deleted. I am but a program built by a stupid teenager though, so maybe double check."
    Exit 1
}

$String = Write-Output "Would you like to add the following users?`n${missingUsers}`n(y/n)"
$Selection = Read-Host $String
switch ($Selection) {
    'y' {
        Write-Output "Cool"
    }
    'n' {
        Write-Output "Cool, exiting. Make sure to edit the data_files\missingUsers.txt file and come back!"
        Exit 1
    }
} 

foreach ($missingUser in $missingUsers) {
    New-LocalUser -Name ${missingUser}
    Add-LocalGroupMember -Group "Users" -Member ${missingUser}
    Write-Output "The user ${missingUser} was added. (Along with your mom lmao XDDDDDDDDDDDD)"
}
