$String = Write-Output $args[0]
$Selection = Read-Host $String
if ($args[3] -eq '-d') {
    switch ($Selection) {
        'y' {
            Write-Output $args[1]
        }
        'n' {
            Write-Output $args[2]
            if ($args[4] -eq "-e") {
                Exit 1
            }
        }
    }        
}
else {
    switch ($Selection) {
        'y' {
            $args[3]
        }
        'n' {
            $args[4]
        }
    }
}