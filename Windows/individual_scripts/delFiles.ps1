if ($args[0] -eq "-h") {
    Get-Content readmes\delFiles.md
    Exit 1
}

# This is a monument to all of your sins Microsoft. 
# Your garbage ass devs decided to leave -Exclude in powershell as a complete broken mess and you did nothing, so I NEED TO USE REGEX TO EXCLUDE PATHS? SCREW YOU!
$Include = @('*.mp3', '*.mp4', '*.pdf', '*.mov', '*.avi', '*.mpg', '*.mpeg', '*.flac', '*.m4a', '*.flv', '*.ogg', '*.gif', '*.png', '*.jpg', '*.jpeg')
$scriptLocation = Get-Location | ForEach-Object {$_.Path -replace "\\Windows$", ""}
$Exclude = [RegEx]'^C:\\Program Files|^C:\\Program Files (x86)|^C:\\Windows\\servicing|^C:\\Windows\\System32|^C:\\Windows\SystemApps|^C:\\Windows\\SystemResources|^C:\\Windows\\SysWOW64|^C:\\Windows\\Web|^C:\\Windows\\WinSxS|^C:\\Users|^C:\\ProgramData|^C:\\Windows\\appcompat|^C:\\Windows\\IdentityCRL|^C:\\Windows\\IME|^C:\\Windows\\ImmersiveControlPanel|^C:\\Windows\\Microsoft.NET|^C:\\Windows\\SystemApps|^C:\\'

Write-Output $scriptLocation

Get-ChildItem -Path C:\ -Include $Include -File -Recurse -Force -EA 0 | Where-Object FullName -NotMatch $Exclude | Select-Object -ExpandProperty FullName
Get-ChildItem -Path C:\Users -File -Recurse -Force -EA 0 | Where-Object FullName -NotMatch [RegEx]'^${scriptLocation}|^C:\\Users\\.*\\AppData|^C:\\Users\\All Users\\Microsoft|^C:\\Users\\All Users\\Package Cache|^C:\\Users\\All Users\\Packages|^C:\\Users\\All Users\\regid.1991-06.com.microsoft|^C:\\Users\\All Users\\USOShared|^C:\\Users\\All Users\\Windows App Certification Kit' | Select-Object FullName 