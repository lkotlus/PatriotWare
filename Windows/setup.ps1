if ($args[0] -eq "-noRestrict") {
    Set-ExecutionPolicy Bypass
}

Unblock-File individual_scripts\*
Unblock-File functions\*

#only use the -noRestrict option if you are lazy and dumb (like me). You should probably use "powershell.exe -noprofile -executionpolicy bypass -file .\script.ps1" instead.

New-Item data_files\badUsers.txt 2>&1>$null
New-Item data_files\goodUsers.txt 2>&1>$null
New-Item data_files\users.txt 2>&1>$null
New-Item data_files\badAdmins.txt 2>&1>$null
New-Item data_files\goodAdmins.txt 2>&1>$null
New-Item data_files\admins.txt 2>&1>$null
New-Item data_files\missingAdmins.txt 2>&1>$null
New-Item data_files\missingUsers.txt 2>&1>$null
New-Item data_files\passthrough.txt 2>&1>$null
New-Item data_files\scheduledTasks.txt 2>&1>$null

# Installing modules for updates

Install-Module PSWindowsUpdate
