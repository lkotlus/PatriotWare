if ($args[0] -eq "-h") {
    Get-Content readmes\winDefender.md
    Exit 1
}

$String = Write-Output "Would you like to set up windows defender? (y/n) THIS SCRIPT IS UNFINISHED"
$Selection = Read-Host $String
switch ($Selection) {
    'y' {
        Write-Output "Cool, starting..."
    }
    'n' {
        Write-Output "Then you are a cringe-pilled nae-nae beta male"
        Exit 1
    }
}

Set-MpPreference -AllowDatagramProcessingOnWinServer $False
Set-MpPreference -AllowNetworkProtectionDownLevel $False
Set-MpPreference -AllowNetworkProtectionOnWinServer $False
Set-MpPreference -AllowSwitchToAsyncInspection $False
Set-MpPreference -AttackSurfaceReductionOnlyExclusions ""
Set-MpPreference -AttackSurfaceReductionRules_Actions ""
Set-MpPreference -AttackSurfaceReductionRules_Ids ""
Set-MpPreference -CheckForSignaturesBeforeRunningScan $False
Set-MpPreference -CloudBlockLevel 0
Set-MpPreference -CloudExtendedTimeout 0
Set-MpPreference -ControlledFolderAccessAllowedApplications ""
Set-MpPreference -ControlledFolderAccessProtectedFolders ""
Set-MpPreference -DefinitionUpdatesChannel 0
Set-MpPreference -DisableArchiveScanning $False
Set-MpPreference -DisableAutoExclusions $False
Set-MpPreference -DisableBehaviorMonitoring $False
Set-MpPreference -DisableBlockAtFirstSeen $False
Set-MpPreference -DisableCatchupFullScan $True
Set-MpPreference -DisableCatchupQuickScan $True
Set-MpPreference -DisableCpuThrottleOnIdleScans $True
Set-MpPreference -DisableDatagramProcessing $False
Set-MpPreference -DisableDnsOverTcpParsing $False
Set-MpPreference -DisableDnsParsing $False
Set-MpPreference -DisableEmailScanning $True
Set-MpPreference -DisableFtpParsing $False
Set-MpPreference -DisableGradualRelease $False
Set-MpPreference -DisableHttpParsing $False
Set-MpPreference -DisableInboundConnectionFiltering $False
Set-MpPreference -DisableIOAVProtection $False
Set-MpPreference -DisableNetworkProtectionPerfTelemetry $False
Set-MpPreference -DisablePrivacyMode $False
Set-MpPreference -DisableRdpParsing $False
Set-MpPreference -DisableRealtimeMonitoring $False
Set-MpPreference -DisableRemovableDriveScanning $True
Set-MpPreference -DisableRestorePoint $True
Set-MpPreference -DisableScanningMappedNetworkDrivesForFullScan $True
Set-MpPreference -DisableScanningNetworkFiles $False
Set-MpPreference -DisableScriptScanning $False
Set-MpPreference -DisableSshParsing $False
Set-MpPreference -DisableTDTFeature $False
Set-MpPreference -DisableTlsParsing $False
Set-MpPreference -EnableControlledFolderAccess 0
Set-MpPreference -EnableDnsSinkhole $True
Set-MpPreference -EnableFileHashComputation $False
Set-MpPreference -EnableFullScanOnBatteryPower $False
Set-MpPreference -EnableLowCpuPriority $False
Set-MpPreference -EnableNetworkProtection 0
Set-MpPreference -EngineUpdatesChannel 0
Set-MpPreference -ExclusionExtension ""
Set-MpPreference -ExclusionIpAddress ""
Set-MpPreference -ExclusionPath ""
Set-MpPreference -ExclusionProcess ""
Set-MpPreference -ForceUseProxyOnly $False
Set-MpPreference -HighThreatDefaultAction 0
Set-MpPreference -LowThreatDefaultAction 0
Set-MpPreference -MAPSReporting 2
Set-MpPreference -MeteredConnectionUpdates $False
Set-MpPreference -ModerateThreatDefaultAction 0
Set-MpPreference -PlatformUpdatesChannel 0
Set-MpPreference -ProxyBypass ""
Set-MpPreference -ProxyPacUrl ""
Set-MpPreference -ProxyServer ""
Set-MpPreference -PUAProtection 0
Set-MpPreference -QuarantinePurgeItemsAfterDelay 90
Set-MpPreference -RandomizeScheduleTaskTimes $True
Set-MpPreference -RealTimeScanDirection 0
Set-MpPreference -RemediationScheduleDay 0
Set-MpPreference -RemediationScheduleTime 020000
Set-MpPreference -ReportingAdditionalActionTimeOut 10080
Set-MpPreference -ReportingCriticalFailureTimeOut 10080
Set-MpPreference -ReportingNonCriticalTimeOut 1440
Set-MpPreference -ScanAvgCPULoadFactor 50
Set-MpPreference -ScanOnlyIfIdleEnabled $True
Set-MpPreference -ScanParameters 1
Set-MpPreference -ScanPurgeItemsAfterDelay 15
Set-MpPreference -ScanScheduleDay 0
Set-MpPreference -ScanScheduleOffset 120
Set-MpPreference -ScanScheduleQuickScanTime 000000
Set-MpPreference -ScanScheduleTime 020000
Set-MpPreference -SchedulerRandomizationTime 4
Set-MpPreference -ServiceHealthReportInterval 60
Set-MpPreference -SevereThreatDefaultAction 0
Set-MpPreference -SharedSignaturesPath ""
Set-MpPreference -SignatureAuGracePeriod 0
Set-MpPreference -SignatureBlobFileSharesSources ""
Set-MpPreference -SignatureBlobUpdateInterval 60
Set-MpPreference -SignatureDefinitionUpdateFileSharesSources ""
Set-MpPreference -SignatureDisableUpdateOnStartupWithoutEngine $False
Set-MpPreference -SignatureFallbackOrder MicrosoftUpdateServer|MMPC
Set-MpPreference -SignatureFirstAuGracePeriod 120
Set-MpPreference -SignatureScheduleDay 8
Set-MpPreference -SignatureScheduleTime 014500
Set-MpPreference -SignatureUpdateCatchupInterval 1
Set-MpPreference -SignatureUpdateInterval 0
Set-MpPreference -SubmitSamplesConsent 1
Set-MpPreference -ThreatIDDefaultAction_Actions ""
Set-MpPreference -ThreatIDDefaultAction_Ids ""
Set-MpPreference -ThrottleForScheduledScanOnly $True
Set-MpPreference -TrustLabelProtectionStatus 0
Set-MpPreference -UILockdown False ""
Set-MpPreference -UnknownThreatDefaultAction 0
Set-MpPreference -PSComputerName ""