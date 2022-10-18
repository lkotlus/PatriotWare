# Creating an array of services that we don't want

Write-Output "WARNING: Might not catch all services because some may be missing in the badServices array.`nALSO: Error messages pop up because certain services won't be installed. Windows sucks balls, so the error handling doesn't work, so we need to look at the errors in shame."

if ($args[0] -eq "-h") {
    Get-Content readmes\services.md
    Exit 1
}

$badServices = @("SharedAccess","XblAuthManager","WbioSrvc","lfsvc","ftpsvc","TermService","XblGameSave","SensrSvc","WMPNetworkSvc","SSDPSRV","RemoteAccess","upnphost","NetTcpPortSharing","RemoteRegistry","dmwappushservice","XboxNetApiSvc","EventLog","MapsBroker","HomeGroupProvider","RpcLocator","bthserv","TrkWks","wuauserv","DcpSvc","WSearch","DiagTrack","WinHttpAutoProxySvc","SessionEnv","HomeGroupListener")

foreach ($badService in $badServices) {
    $service = Get-Service -Name $badService -erroraction 'silentlycontinue' 
    Stop-Service -InputObject $service -Force -erroraction 'silentlycontinue' 
    Set-Service -InputObject $service -StartupType Disabled -erroraction 'silentlycontinue' 
    Write-Output "Done with the service: $badService`n" 
}
