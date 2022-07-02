if ($args[0] -eq "-h") {
    Get-Content readmes\scheduledTasks.md
    Exit 1
}

# Getting scheduled tasks
Get-ScheduledTask | Select-Object TaskName | Set-Content -Encoding UTF8 .\data_files\scheduledTasks.txt

# Sorting scheduledTasks.txt
Get-Content .\data_files\scheduledTasks.txt | Sort-Object | Get-Unique | Set-Content -Encoding UTF8 .\data_files\passthrough.txt
Get-Content .\data_files\passthrough.txt | Set-Content -Encoding UTF8 .\data_files\scheduledTasks.txt

# Getting useless crap out of scheduledTasks.txt
$lines = Get-Content .\data_files\scheduledTasks.txt

for ($i=0; $i -lt $lines.Length; $i++) {
    $lines[$i] = $lines[$i].Substring(11)
    $lines[$i] = $lines[$i].Substring(0, $lines[$i].Length-1)
}

Write-Output $lines | Set-Content .\data_files\scheduledTasks.txt

# Get a diff of the two files
Compare-Object (Get-Content .\data_files\scheduledTasks.txt) (Get-Content .\data_files\scheduledTasksWhitelist.txt) | Where-Object {$_.SideIndicator -eq "<="} 