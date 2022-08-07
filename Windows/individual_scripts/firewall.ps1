if ($args[0] -eq "-h") {
    Get-Content readmes\firewall.md
    Exit 1
}

Set-NetFirewallProfile -Profile Domain, Public, Private -Enabled True

$TCP=@(21,22,23,25,80,161,162,3389,4444,1234,8080,8088,8888)
$UDP=@(3389,161,162,389,636)

foreach ($port in $TCP) {
    New-NetFirewallRule -DisplayName "Block Outbound Port $port" -Direction Outbound -LocalPort $port -Protocol TCP -Action Block
}

foreach ($port in $UDP) {
    New-NetFirewallRule -DisplayName "Block Outbound Port $port" -Direction Outbound -LocalPort $port -Protocol UDP -Action Block
}