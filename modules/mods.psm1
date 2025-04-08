# Import modules
Import-Module ".\modules\core.psm1" -Force

# Functions
function Disable-BingSearch {
    # Structures
    $Keys = @(
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer"; Name = "DisableSearchBoxSuggestions"; Type = "REG_DWORD"; Value = "1"},
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Search"; Name = "BingSearchEnabled"; Type = "REG_DWORD"; Value = "0"},
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Search"; Name = "CortanaConsent"; Type = "REG_DWORD"; Value = "0"},
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Search"; Name = "SearchboxTaskbarMode"; Type = "REG_DWORD"; Value = "1"},
        @{Path = "HKCU\Software\Policies\Microsoft\Windows\Explorer"; Name = "DisableSearchBoxSuggestions"; Type = "REG_DWORD"; Value = "1"}
    )

    # Edit registry keys
    Write-Host "Disabling web results in search!" -ForegroundColor Cyan
    foreach ($Key in $Keys) {
        Set-RegistryKey -Path $Key.Path -Name $Key.Name -Type $Key.Type -Value $Key.Value
    }
    Write-Host ""
    Pause
}

function Disable-Telemetry {
    # Structures
    $Keys = @(
        @{Path = "HKCU\Software\Microsoft\Siuf\Rules"; Name = "NumberOfSIUFInPeriod"; Value = "0"; Type = "REG_DWORD"},
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"; Name = "ContentDeliveryState"; Value = "0"; Type = "REG_DWORD"},
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"; Name = "OemPreInstalledAppsEnabled"; Value = "0"; Type = "REG_DWORD"},
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"; Name = "PreInstalledAppsEnabled"; Value = "0"; Type = "REG_DWORD"},
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"; Name = "PreInstalledAppsEverEnabled"; Value = "0"; Type = "REG_DWORD"},
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"; Name = "SilentInstalledAppsEnabled"; Value = "0"; Type = "REG_DWORD"},
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"; Name = "SubscribedContent-338387Enabled"; Value = "0"; Type = "REG_DWORD"},
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"; Name = "SubscribedContent-338388Enabled"; Value = "0"; Type = "REG_DWORD"},
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"; Name = "SubscribedContent-338389Enabled"; Value = "0"; Type = "REG_DWORD"},
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"; Name = "SubscribedContent-353698Enabled"; Value = "0"; Type = "REG_DWORD"},
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"; Name = "SystemPaneSuggestionsEnabled"; Value = "0"; Type = "REG_DWORD"},
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; Name = "LaunchTo"; Value = "1"; Type = "REG_DWORD"},
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; Name = "ShowTaskViewButton"; Value = "0"; Type = "REG_DWORD"},
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People"; Name = "PeopleBand"; Value = "0"; Type = "REG_DWORD"},
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds"; Name = "ShellFeedsTaskbarViewMode"; Value = "2"; Type = "REG_DWORD"},
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"; Name = "HideSCAMeetNow"; Value = "1"; Type = "REG_DWORD"},
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement"; Name = "ScoobeSystemSettingEnabled"; Value = "0"; Type = "REG_DWORD"},
        @{Path = "HKCU\Software\Policies\Microsoft\Windows\CloudContent"; Name = "DisableTailoredExperiencesWithDiagnosticData"; Value = "1"; Type = "REG_DWORD"},
        @{Path = "HKCU\Software\Policies\Microsoft\Windows\Windows Feeds"; Name = "EnableFeeds"; Value = "0"; Type = "REG_DWORD"}
    )

    # Edit registry keys
    Write-Host "Disabling user telemetry rules!" -ForegroundColor Cyan
    foreach ($Key in $Keys) {
        Set-RegistryKey -Path $Key.Path -Name $Key.Name -Type $Key.Type -Value $Key.Value
    }
    Write-Host ""

    # Edit registry keys as admin
    try {
        Invoke-ElevatedShell "
            # Structures
            `$Keys = @(
                @{Path = 'HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots'; Name = 'Value'; Value = '0'; Type = 'REG_DWORD'},
                @{Path = 'HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting'; Name = 'Value'; Value = '0'; Type = 'REG_DWORD'},
                @{Path = 'HKLM\Software\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile'; Name = 'NetworkThrottlingIndex'; Value = '4294967295'; Type = 'REG_DWORD'},
                @{Path = 'HKLM\Software\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile'; Name = 'SystemResponsiveness'; Value = '0'; Type = 'REG_DWORD'},
                @{Path = 'HKLM\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config'; Name = 'DODownloadMode'; Value = '1'; Type = 'REG_DWORD'},
                @{Path = 'HKLM\Software\Policies\Microsoft\Windows\AdvertisingInfo'; Name = 'DisabledByGroupPolicy'; Value = '1'; Type = 'REG_DWORD'},
                @{Path = 'HKLM\Software\Policies\Microsoft\Windows\DataCollection'; Name = 'AllowTelemetry'; Value = '0'; Type = 'REG_DWORD'},
                @{Path = 'HKLM\Software\Policies\Microsoft\Windows\DataCollection'; Name = 'DoNotShowFeedbackNotifications'; Value = '1'; Type = 'REG_DWORD'},
                @{Path = 'HKLM\Software\Policies\Microsoft\Windows\System'; Name = 'EnableActivityFeed'; Value = '0'; Type = 'REG_DWORD'},
                @{Path = 'HKLM\Software\Policies\Microsoft\Windows\System'; Name = 'PublishUserActivities'; Value = '0'; Type = 'REG_DWORD'},
                @{Path = 'HKLM\Software\Policies\Microsoft\Windows\System'; Name = 'UploadUserActivities'; Value = '0'; Type = 'REG_DWORD'},
                @{Path = 'HKLM\System\ControlSet001\Services\Ndu'; Name = 'Start'; Value = '2'; Type = 'REG_DWORD'},
                @{Path = 'HKLM\System\CurrentControlSet\Control\Remote Assistance'; Name = 'fAllowToGetHelp'; Value = '0'; Type = 'REG_DWORD'},
                @{Path = 'HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management'; Name = 'ClearPageFileAtShutdown'; Value = '0'; Type = 'REG_DWORD'},
                @{Path = 'HKLM\System\CurrentControlSet\Services\LanmanServer\Parameters'; Name = 'IRPStackSize'; Value = '30'; Type = 'REG_DWORD'}
            )

            `$Tasks = @(
                @{Path = 'Microsoft\Windows\Application Experience'; Name = 'MareBackup'; State = `$false},
                @{Path = 'Microsoft\Windows\Application Experience'; Name = 'Microsoft Compatibility Appraiser'; State = `$false},
                @{Path = 'Microsoft\Windows\Application Experience'; Name = 'PcaPatchDbTask'; State = `$false},
                @{Path = 'Microsoft\Windows\Application Experience'; Name = 'ProgramDataUpdater'; State = `$false},
                @{Path = 'Microsoft\Windows\Application Experience'; Name = 'StartupAppTask'; State = `$false},
                @{Path = 'Microsoft\Windows\Autochk'; Name = 'Proxy'; State = `$false},
                @{Path = 'Microsoft\Windows\Customer Experience Improvement Program'; Name = 'Consolidator'; State = `$false},
                @{Path = 'Microsoft\Windows\Customer Experience Improvement Program'; Name = 'UsbCeip'; State = `$false},
                @{Path = 'Microsoft\Windows\DiskDiagnostic'; Name = 'Microsoft-Windows-DiskDiagnosticDataCollector'; State = `$false},
                @{Path = 'Microsoft\Windows\Feedback\Siuf'; Name = 'DmClient'; State = `$false},
                @{Path = 'Microsoft\Windows\Feedback\Siuf'; Name = 'DmClientOnScenarioDownload'; State = `$false},
                @{Path = 'Microsoft\Windows\Maps'; Name = 'MapsUpdateTask'; State = `$false},
                @{Path = 'Microsoft\Windows\Windows Error Reporting'; Name = 'QueueReporting'; State = `$false}
            )

            # Edit registry keys
            Write-Host 'Disabling system telemetry rules!' -ForegroundColor Cyan
            foreach (`$Key in `$Keys) {
                Set-RegistryKey -Path `$Key.Path -Name `$Key.Name -Type `$Key.Type -Value `$Key.Value
            }
            Write-Host ''

            # Edit scheduled task
            Write-Host 'Disabling system telemetry scheduled task!' -ForegroundColor Cyan
            foreach (`$Task in `$Tasks) {
                Set-TaskState -Path `$Task.Path -Name `$Task.Name -State `$Task.State
            }
            Write-Host ''
            Pause
        "
    } catch {
        Show-ErrorMessage -Title "Failed to run!" -Message $_.Exception.Message
        Pause
    }
}

function Remove-MicrosoftApps {
    try {
        Invoke-ElevatedShell -Script "
            # Structures
            `$Apps = @(
                @{Name = 'Copilot'; Type = 'Package'},
                @{Name = 'Microsoft.BingNews'; Type = 'Package'},
                @{Name = 'Microsoft.BingSearch'; Type = 'Package'},
                @{Name = 'Microsoft.BingWeather'; Type = 'Package'}
                @{Name = 'Microsoft.GamingApp'; Type = 'Package'},
                @{Name = 'Microsoft.GetHelp'; Type = 'Package'},
                @{Name = 'Microsoft.Getstarted'; Type = 'Package'},
                @{Name = 'Microsoft.Microsoft3DViewer'; Type = 'Package'},
                @{Name = 'Microsoft.MicrosoftSolitaireCollection'; Type = 'Package'},
                @{Name = 'Microsoft.OutlookForWindows'; Type = 'Package'},
                @{Name = 'Microsoft.People'; Type = 'Package'},
                @{Name = 'Microsoft.PowerAutomateDesktop'; Type = 'Package'},
                @{Name = 'Microsoft.SkypeApp'; Type = 'Package'},
                @{Name = 'Microsoft.Windows.DevHome'; Type = 'Package'},
                @{Name = 'Microsoft.windowscommunicationsapps'; Type = 'Package'},
                @{Name = 'Microsoft.WindowsFeedbackHub'; Type = 'Package'},
                @{Name = 'Microsoft.WindowsMaps'; Type = 'Package'},
                @{Name = 'Microsoft.XboxApp'; Type = 'Package'},
                @{Name = 'Microsoft.XboxGamingOverlay'; Type = 'Package'},
                @{Name = 'Microsoft.XboxIdentityProvider'; Type = 'Package'},
                @{Name = 'Microsoft.XboxSpeechToTextOverlay'; Type = 'Package'},
                @{Name = 'Microsoft.YourPhone'; Type = 'Package'},
                @{Name = 'Microsoft.549981C3F5F10'; Type = 'Package'},
                @{Name = 'MicrosoftCorporationII.MicrosoftFamily'; Type = 'Package'},
                @{Name = 'MicrosoftCorporationII.QuickAssist'; Type = 'Package'},
                @{Name = 'Recall'; Type = 'App'},
                @{Name = 'XboxOneSmartGlass'; Type = 'Package'}
            )
            
            # Remove apps
            Write-Host 'Removing Bloatware!' -ForegroundColor Cyan
            foreach (`$App in `$Apps) {
                Remove-App -Name `$App.Name -Type `$App.Type
            }
            Write-Host ''
            Pause
        "
    } catch {
        Show-ErrorMessage -Title "Failed to run!" -Message $_.Exception.Message
        Pause
    }
}

function Disable-AppxProcesses {
    # Structures
    $Keys = @(
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications"; Name = "GlobalUserDisabled"; Type = "REG_DWORD"; Value = "1"},
        @{Path = "HKCU\Software\Microsoft\Windows\CurrentVersion\Search"; Name = "BackgroundAppGlobalToggle"; Type = "REG_DWORD"; Value = "0"}
    )

    # Edit registry keys
    Write-Host "Stopping AppX packages from running in the background!" -ForegroundColor Cyan
    foreach ($Key in $Keys) {
        Set-RegistryKey -Path $Key.Path -Name $Key.Name -Type $Key.Type -Value $Key.Value
    }
    Write-Host ""
    Pause
}

function Disable-SystemProcesses {
    # Variables
    $Keys = @(
        @{Path = 'HKCU\System\GameConfigStore'; Name = 'GameDVR_EFSEFeatureFlags'; Value = '0'; Type = 'REG_DWORD'},
        @{Path = 'HKCU\System\GameConfigStore'; Name = 'GameDVR_Enabled'; Value = '0'; Type = 'REG_DWORD'},
        @{Path = 'HKCU\System\GameConfigStore'; Name = 'GameDVR_FSEBehaviorGameDVR_FSEBehavior'; Value = '2'; Type = 'REG_DWORD'},
        @{Path = 'HKCU\System\GameConfigStore'; Name = 'GameDVR_HonorUserFSEBehaviorMode'; Value = '1'; Type = 'REG_DWORD'}
    )

    # Edit registry keys
    Write-Host "Disabling non-essential processes!" -ForegroundColor Cyan
    foreach ($Key in $Keys) {
        Set-RegistryKey -Path $Key.Path -Name $Key.Name -Type $Key.Type -Value $Key.Value
    }
    Write-Host ""

    # Edit registry keys as admin
    try {
        $LocationSetting = "{BFA794E4-F964-4FDB-90F6-51056BFE4B44}"
        Invoke-ElevatedShell "
            # Structures
            `$Keys = @(
                @{Path = 'HKLM\Software\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\$LocationSetting'; Name = 'SensorPermissionState'; Value = '0'; Type = 'REG_DWORD'},
                @{Path = 'HKLM\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location'; Name = 'Value'; Value = 'Deny'; Type = 'REG_SZ'},
                @{Path = 'HKLM\Software\Microsoft\Windows\Windows Error Reporting'; Name = 'Disabled'; Value = '1'; Type = 'REG_DWORD'},
                @{Path = 'HKLM\Software\Policies\Microsoft\Windows\CloudContent'; Name = 'DisableWindowsConsumerApps'; Value = '1'; Type = 'REG_SZ'},
                @{Path = 'HKLM\Software\Policies\Microsoft\Windows\CloudContent'; Name = 'DisableWindowsConsumerFeatures'; Value = '1'; Type = 'REG_DWORD'},
                @{Path = 'HKLM\Software\Policies\Microsoft\Windows\GameDVR'; Name = 'AllowGameDVR'; Value = '0'; Type = 'REG_DWORD'},
                @{Path = 'HKLM\System\CurrentControlSet\Services\lfsvc\Service\Configuration'; Name = 'Status'; Value = '0'; Type = 'REG_DWORD'},
                @{Path = 'HKLM\System\Maps'; Name = 'AutoUpdateEnabled'; Value = '0'; Type = 'REG_DWORD'}
            )

            # Edit registry keys
            Write-Host 'Disabling non-essential processes!' -ForegroundColor Cyan
            foreach (`$Key in `$Keys) {
                Set-RegistryKey -Path `$Key.Path -Name `$Key.Name -Type `$Key.Type -Value `$Key.Value
            }
            Write-Host ''
            Pause
        "
    } catch {
        Show-ErrorMessage -Title "Failed to run!" -Message $_.Exception.Message
        Pause
    }
}

function Disable-SystemServices {
    try {
        Invoke-ElevatedShell -Script "
            # Structures
            `$Services = @(
                @{Name = 'AJRouter'; Type = 'Disabled'}
                @{Name = 'ALG'; Type = 'Manual'},
                @{Name = 'AppIDSvc'; Type = 'Manual'},
                @{Name = 'AppMgmt'; Type = 'Manual'},
                @{Name = 'AppReadiness'; Type = 'Manual'},
                @{Name = 'AppVClient'; Type = 'Disabled'},
                @{Name = 'AppXSvc'; Type = 'Manual'},
                @{Name = 'Appinfo'; Type = 'Manual'},
                @{Name = 'AssignedAccessManagerSvc'; Type = 'Disabled'},
                @{Name = 'AudioEndpointBuilder'; Type = 'Automatic'},
                @{Name = 'AudioSrv'; Type = 'Automatic'},
                @{Name = 'Audiosrv'; Type = 'Automatic'},
                @{Name = 'AxInstSV'; Type = 'Manual'},
                @{Name = 'BDESVC'; Type = 'Manual'},
                @{Name = 'BFE'; Type = 'Automatic'},
                @{Name = 'BITS'; Type = 'AutomaticDelayedStart'},
                @{Name = 'BTAGService'; Type = 'Manual'},
                @{Name = 'BcastDVRUserService_*'; Type = 'Manual'},
                @{Name = 'BluetoothUserService_*'; Type = 'Manual'},
                @{Name = 'BrokerInfrastructure'; Type = 'Automatic'},
                @{Name = 'Browser'; Type = 'Manual'},
                @{Name = 'BthHFSrv'; Type = 'Automatic'},
                @{Name = 'CDPSvc'; Type = 'Manual'},
                @{Name = 'CDPUserSvc_*'; Type = 'Automatic'},
                @{Name = 'COMSysApp'; Type = 'Manual'},
                @{Name = 'CaptureService_*'; Type = 'Manual'},
                @{Name = 'CertPropSvc'; Type = 'Manual'},
                @{Name = 'ClipSVC'; Type = 'Manual'},
                @{Name = 'ConsentUxUserSvc_*'; Type = 'Manual'},
                @{Name = 'CoreMessagingRegistrar'; Type = 'Automatic'},
                @{Name = 'CredentialEnrollmentManagerUserSvc_*'; Type = 'Manual'},
                @{Name = 'CryptSvc'; Type = 'Automatic'},
                @{Name = 'CscService'; Type = 'Manual'},
                @{Name = 'DPS'; Type = 'Automatic'},
                @{Name = 'DcomLaunch'; Type = 'Automatic'},
                @{Name = 'DcpSvc'; Type = 'Manual'},
                @{Name = 'DevQueryBroker'; Type = 'Manual'},
                @{Name = 'DeviceAssociationBrokerSvc_*'; Type = 'Manual'},
                @{Name = 'DeviceAssociationService'; Type = 'Manual'},
                @{Name = 'DeviceInstall'; Type = 'Manual'},
                @{Name = 'DevicePickerUserSvc_*'; Type = 'Manual'},
                @{Name = 'DevicesFlowUserSvc_*'; Type = 'Manual'},
                @{Name = 'Dhcp'; Type = 'Automatic'},
                @{Name = 'DiagTrack'; Type = 'Disabled'},
                @{Name = 'DialogBlockingService'; Type = 'Disabled'},
                @{Name = 'DispBrokerDesktopSvc'; Type = 'Automatic'},
                @{Name = 'DisplayEnhancementService'; Type = 'Manual'},
                @{Name = 'DmEnrollmentSvc'; Type = 'Manual'},
                @{Name = 'Dnscache'; Type = 'Automatic'},
                @{Name = 'DoSvc'; Type = 'AutomaticDelayedStart'},
                @{Name = 'DsSvc'; Type = 'Manual'},
                @{Name = 'DsmSvc'; Type = 'Manual'},
                @{Name = 'DusmSvc'; Type = 'Automatic'},
                @{Name = 'EFS'; Type = 'Manual'},
                @{Name = 'EapHost'; Type = 'Manual'},
                @{Name = 'EntAppSvc'; Type = 'Manual'},
                @{Name = 'EventLog'; Type = 'Automatic'},
                @{Name = 'EventSystem'; Type = 'Automatic'},
                @{Name = 'FDResPub'; Type = 'Manual'},
                @{Name = 'Fax'; Type = 'Manual'},
                @{Name = 'FontCache'; Type = 'Automatic'},
                @{Name = 'FrameServer'; Type = 'Manual'},
                @{Name = 'FrameServerMonitor'; Type = 'Manual'},
                @{Name = 'GraphicsPerfSvc'; Type = 'Manual'},
                @{Name = 'HomeGroupListener'; Type = 'Manual'},
                @{Name = 'HomeGroupProvider'; Type = 'Manual'},
                @{Name = 'HvHost'; Type = 'Manual'},
                @{Name = 'IEEtwCollectorService'; Type = 'Manual'},
                @{Name = 'IKEEXT'; Type = 'Manual'},
                @{Name = 'InstallService'; Type = 'Manual'},
                @{Name = 'InventorySvc'; Type = 'Manual'},
                @{Name = 'IpxlatCfgSvc'; Type = 'Manual'},
                @{Name = 'KtmRm'; Type = 'Manual'},
                @{Name = 'LSM'; Type = 'Automatic'},
                @{Name = 'LanmanServer'; Type = 'Automatic'},
                @{Name = 'LanmanWorkstation'; Type = 'Automatic'},
                @{Name = 'LicenseManager'; Type = 'Manual'},
                @{Name = 'LxpSvc'; Type = 'Manual'},
                @{Name = 'MSDTC'; Type = 'Manual'},
                @{Name = 'MSiSCSI'; Type = 'Manual'},
                @{Name = 'MapsBroker'; Type = 'AutomaticDelayedStart'},
                @{Name = 'McpManagementService'; Type = 'Manual'},
                @{Name = 'MessagingService_*'; Type = 'Manual'},
                @{Name = 'MicrosoftEdgeElevationService'; Type = 'Manual'},
                @{Name = 'MixedRealityOpenXRSvc'; Type = 'Manual'},
                @{Name = 'MpsSvc'; Type = 'Automatic'},
                @{Name = 'MsKeyboardFilter'; Type = 'Manual'},
                @{Name = 'NPSMSvc_*'; Type = 'Manual'},
                @{Name = 'NaturalAuthentication'; Type = 'Manual'},
                @{Name = 'NcaSvc'; Type = 'Manual'},
                @{Name = 'NcbService'; Type = 'Manual'},
                @{Name = 'NcdAutoSetup'; Type = 'Manual'},
                @{Name = 'NetSetupSvc'; Type = 'Manual'},
                @{Name = 'NetTcpPortSharing'; Type = 'Disabled'},
                @{Name = 'Netman'; Type = 'Manual'},
                @{Name = 'NgcCtnrSvc'; Type = 'Manual'},
                @{Name = 'NgcSvc'; Type = 'Manual'},
                @{Name = 'NlaSvc'; Type = 'Manual'},
                @{Name = 'OneSyncSvc_*'; Type = 'Automatic'},
                @{Name = 'P9RdrService_*'; Type = 'Manual'},
                @{Name = 'PNRPAutoReg'; Type = 'Manual'},
                @{Name = 'PNRPsvc'; Type = 'Manual'},
                @{Name = 'PcaSvc'; Type = 'Manual'},
                @{Name = 'PeerDistSvc'; Type = 'Manual'},
                @{Name = 'PenService_*'; Type = 'Manual'},
                @{Name = 'PerfHost'; Type = 'Manual'},
                @{Name = 'PhoneSvc'; Type = 'Manual'},
                @{Name = 'PimIndexMaintenanceSvc_*'; Type = 'Manual'},
                @{Name = 'PlugPlay'; Type = 'Manual'},
                @{Name = 'PolicyAgent'; Type = 'Manual'},
                @{Name = 'Power'; Type = 'Automatic'},
                @{Name = 'PrintNotify'; Type = 'Manual'},
                @{Name = 'PrintWorkflowUserSvc_*'; Type = 'Manual'},
                @{Name = 'ProfSvc'; Type = 'Automatic'},
                @{Name = 'PushToInstall'; Type = 'Manual'},
                @{Name = 'QWAVE'; Type = 'Manual'},
                @{Name = 'RasAuto'; Type = 'Manual'},
                @{Name = 'RasMan'; Type = 'Manual'},
                @{Name = 'RemoteAccess'; Type = 'Disabled'},
                @{Name = 'RemoteRegistry'; Type = 'Disabled'},
                @{Name = 'RetailDemo'; Type = 'Manual'},
                @{Name = 'RmSvc'; Type = 'Manual'},
                @{Name = 'RpcEptMapper'; Type = 'Automatic'},
                @{Name = 'RpcLocator'; Type = 'Manual'},
                @{Name = 'RpcSs'; Type = 'Automatic'},
                @{Name = 'SCPolicySvc'; Type = 'Manual'},
                @{Name = 'SCardSvr'; Type = 'Manual'},
                @{Name = 'SDRSVC'; Type = 'Manual'},
                @{Name = 'SEMgrSvc'; Type = 'Manual'},
                @{Name = 'SENS'; Type = 'Automatic'},
                @{Name = 'SNMPTRAP'; Type = 'Manual'},
                @{Name = 'SNMPTrap'; Type = 'Manual'},
                @{Name = 'SSDPSRV'; Type = 'Manual'},
                @{Name = 'SamSs'; Type = 'Automatic'},
                @{Name = 'ScDeviceEnum'; Type = 'Manual'},
                @{Name = 'Schedule'; Type = 'Automatic'},
                @{Name = 'SecurityHealthService'; Type = 'Manual'},
                @{Name = 'Sense'; Type = 'Manual'},
                @{Name = 'SensorDataService'; Type = 'Manual'},
                @{Name = 'SensorService'; Type = 'Manual'},
                @{Name = 'SensrSvc'; Type = 'Manual'},
                @{Name = 'SessionEnv'; Type = 'Manual'},
                @{Name = 'SharedAccess'; Type = 'Manual'},
                @{Name = 'SharedRealitySvc'; Type = 'Manual'},
                @{Name = 'ShellHWDetection'; Type = 'Automatic'},
                @{Name = 'SmsRouter'; Type = 'Manual'},
                @{Name = 'Spooler'; Type = 'Automatic'},
                @{Name = 'SstpSvc'; Type = 'Manual'},
                @{Name = 'StateRepository'; Type = 'Manual'},
                @{Name = 'StiSvc'; Type = 'Manual'},
                @{Name = 'StorSvc'; Type = 'Manual'},
                @{Name = 'SysMain'; Type = 'Automatic'},
                @{Name = 'SystemEventsBroker'; Type = 'Automatic'},
                @{Name = 'TabletInputService'; Type = 'Manual'},
                @{Name = 'TapiSrv'; Type = 'Manual'},
                @{Name = 'TextInputManagementService'; Type = 'Manual'},
                @{Name = 'Themes'; Type = 'Automatic'},
                @{Name = 'TieringEngineService'; Type = 'Manual'},
                @{Name = 'TimeBroker'; Type = 'Manual'},
                @{Name = 'TimeBrokerSvc'; Type = 'Manual'},
                @{Name = 'TokenBroker'; Type = 'Manual'},
                @{Name = 'TrkWks'; Type = 'Automatic'},
                @{Name = 'TroubleshootingSvc'; Type = 'Manual'},
                @{Name = 'TrustedInstaller'; Type = 'Manual'},
                @{Name = 'UI0Detect'; Type = 'Manual'},
                @{Name = 'UdkUserSvc_*'; Type = 'Manual'},
                @{Name = 'UevAgentService'; Type = 'Disabled'},
                @{Name = 'UmRdpService'; Type = 'Manual'},
                @{Name = 'UnistoreSvc_*'; Type = 'Manual'},
                @{Name = 'UserDataSvc_*'; Type = 'Manual'},
                @{Name = 'UserManager'; Type = 'Automatic'},
                @{Name = 'UsoSvc'; Type = 'Manual'},
                @{Name = 'VGAuthService'; Type = 'Automatic'},
                @{Name = 'VMTools'; Type = 'Automatic'},
                @{Name = 'VSS'; Type = 'Manual'},
                @{Name = 'VacSvc'; Type = 'Manual'},
                @{Name = 'W32Time'; Type = 'Manual'},
                @{Name = 'WEPHOSTSVC'; Type = 'Manual'},
                @{Name = 'WFDSConMgrSvc'; Type = 'Manual'},
                @{Name = 'WMPNetworkSvc'; Type = 'Manual'},
                @{Name = 'WManSvc'; Type = 'Manual'},
                @{Name = 'WPDBusEnum'; Type = 'Manual'},
                @{Name = 'WSService'; Type = 'Manual'},
                @{Name = 'WSearch'; Type = 'AutomaticDelayedStart'},
                @{Name = 'WaaSMedicSvc'; Type = 'Manual'},
                @{Name = 'WalletService'; Type = 'Manual'},
                @{Name = 'WarpJITSvc'; Type = 'Manual'},
                @{Name = 'WbioSrvc'; Type = 'Manual'},
                @{Name = 'Wcmsvc'; Type = 'Automatic'},
                @{Name = 'WcsPlugInService'; Type = 'Manual'},
                @{Name = 'WdNisSvc'; Type = 'Manual'},
                @{Name = 'WdiServiceHost'; Type = 'Manual'},
                @{Name = 'WdiSystemHost'; Type = 'Manual'},
                @{Name = 'WebClient'; Type = 'Manual'},
                @{Name = 'Wecsvc'; Type = 'Manual'},
                @{Name = 'WerSvc'; Type = 'Manual'},
                @{Name = 'WiaRpc'; Type = 'Manual'},
                @{Name = 'WinDefend'; Type = 'Automatic'},
                @{Name = 'WinHttpAutoProxySvc'; Type = 'Manual'},
                @{Name = 'WinRM'; Type = 'Manual'},
                @{Name = 'Winmgmt'; Type = 'Automatic'},
                @{Name = 'WpcMonSvc'; Type = 'Manual'},
                @{Name = 'WpnService'; Type = 'Manual'},
                @{Name = 'WpnUserService_*'; Type = 'Automatic'},
                @{Name = 'XblAuthManager'; Type = 'Manual'},
                @{Name = 'XblGameSave'; Type = 'Manual'},
                @{Name = 'XboxGipSvc'; Type = 'Manual'},
                @{Name = 'XboxNetApiSvc'; Type = 'Manual'},
                @{Name = 'autotimesvc'; Type = 'Manual'},
                @{Name = 'bthserv'; Type = 'Manual'},
                @{Name = 'camsvc'; Type = 'Manual'},
                @{Name = 'cbdhsvc_*'; Type = 'Manual'},
                @{Name = 'cloudidsvc'; Type = 'Manual'},
                @{Name = 'dcsvc'; Type = 'Manual'},
                @{Name = 'defragsvc'; Type = 'Manual'},
                @{Name = 'diagnosticshub.standardcollector.service'; Type = 'Manual'},
                @{Name = 'diagsvc'; Type = 'Manual'},
                @{Name = 'dmwappushservice'; Type = 'Manual'},
                @{Name = 'dot3svc'; Type = 'Manual'},
                @{Name = 'edgeupdate'; Type = 'Manual'},
                @{Name = 'edgeupdatem'; Type = 'Manual'},
                @{Name = 'embeddedmode'; Type = 'Manual'},
                @{Name = 'fdPHost'; Type = 'Manual'},
                @{Name = 'fhsvc'; Type = 'Manual'},
                @{Name = 'gpsvc'; Type = 'Automatic'},
                @{Name = 'hidserv'; Type = 'Manual'},
                @{Name = 'icssvc'; Type = 'Manual'},
                @{Name = 'iphlpsvc'; Type = 'Automatic'},
                @{Name = 'lfsvc'; Type = 'Manual'},
                @{Name = 'lltdsvc'; Type = 'Manual'},
                @{Name = 'lmhosts'; Type = 'Manual'},
                @{Name = 'mpssvc'; Type = 'Automatic'},
                @{Name = 'msiserver'; Type = 'Manual'},
                @{Name = 'netprofm'; Type = 'Manual'},
                @{Name = 'nsi'; Type = 'Automatic'},
                @{Name = 'p2pimsvc'; Type = 'Manual'},
                @{Name = 'p2psvc'; Type = 'Manual'},
                @{Name = 'perceptionsimulation'; Type = 'Manual'},
                @{Name = 'pla'; Type = 'Manual'},
                @{Name = 'seclogon'; Type = 'Manual'},
                @{Name = 'shpamsvc'; Type = 'Disabled'},
                @{Name = 'smphost'; Type = 'Manual'},
                @{Name = 'spectrum'; Type = 'Manual'},
                @{Name = 'sppsvc'; Type = 'AutomaticDelayedStart'},
                @{Name = 'ssh-agent'; Type = 'Disabled'},
                @{Name = 'svsvc'; Type = 'Manual'},
                @{Name = 'swprv'; Type = 'Manual'},
                @{Name = 'tiledatamodelsvc'; Type = 'Automatic'},
                @{Name = 'tzautoupdate'; Type = 'Disabled'},
                @{Name = 'uhssvc'; Type = 'Disabled'},
                @{Name = 'upnphost'; Type = 'Manual'},
                @{Name = 'vds'; Type = 'Manual'},
                @{Name = 'vm3dservice'; Type = 'Manual'},
                @{Name = 'vmicguestinterface'; Type = 'Manual'},
                @{Name = 'vmicheartbeat'; Type = 'Manual'},
                @{Name = 'vmickvpexchange'; Type = 'Manual'},
                @{Name = 'vmicrdv'; Type = 'Manual'},
                @{Name = 'vmicshutdown'; Type = 'Manual'},
                @{Name = 'vmictimesync'; Type = 'Manual'},
                @{Name = 'vmicvmsession'; Type = 'Manual'},
                @{Name = 'vmicvss'; Type = 'Manual'},
                @{Name = 'vmvss'; Type = 'Manual'},
                @{Name = 'wbengine'; Type = 'Manual'},
                @{Name = 'wcncsvc'; Type = 'Manual'},
                @{Name = 'webthreatdefsvc'; Type = 'Manual'},
                @{Name = 'webthreatdefusersvc_*'; Type = 'Automatic'},
                @{Name = 'wercplsupport'; Type = 'Manual'},
                @{Name = 'wisvc'; Type = 'Manual'},
                @{Name = 'wlidsvc'; Type = 'Manual'},
                @{Name = 'wlpasvc'; Type = 'Manual'},
                @{Name = 'wmiApSrv'; Type = 'Manual'},
                @{Name = 'workfolderssvc'; Type = 'Manual'},
                @{Name = 'wscsvc'; Type = 'AutomaticDelayedStart'},
                @{Name = 'wuauserv'; Type = 'Manual'},
                @{Name = 'wudfsvc'; Type = 'Manual'}
            )
            
            # Remove apps
            Write-Host 'Started tweaking Windows Services!' -ForegroundColor Blue
            foreach (`$Service in `$Services) {
                Set-ServiceStartup -Name `$Service.Name -Type `$Service.Type
            }
            Write-Host ''
            Pause
        "
    } catch {
        Show-ErrorMessage -Title "Failed to run!" -Message $_.Exception.Message
        Pause
    }
}

function Disable-AdobeServices {
    try {
        Invoke-ElevatedShell -Script "
            # Structures
            `$Services = @(
                @{Name = 'AGSService'; Type = 'Disabled'},
                @{Name = 'AGMService'; Type = 'Disabled'},
                @{Name = 'AdobeUpdateService'; Type = 'Manual'},
                @{Name = 'Adobe Acrobat Update'; Type = 'Manual'},
                @{Name = 'Adobe Genuine Monitor Service'; Type = 'Disabled'},
                @{Name = 'AdobeARMservice'; Type = 'Manual'},
                @{Name = 'Adobe Licensing Console'; Type = 'Manual'},
                @{Name = 'CCXProcess'; Type = 'Manual'},
                @{Name = 'AdobeIPCBroker'; Type = 'Manual'},
                @{Name = 'CoreSync'; Type = 'Manual'}
            )
            
            # Remove apps
            Write-Host 'Started tweaking Adobe Services!' -ForegroundColor Blue
            foreach (`$Service in `$Services) {
                Set-ServiceStartup -Name `$Service.Name -Type `$Service.Type
            }
            Write-Host ''
            Pause
        "
    } catch {
        Show-ErrorMessage -Title "Failed to run!" -Message $_.Exception.Message
        Pause
    }
}

function Set-IPv6Preferences {
    # Parameters
    param (
        [Parameter(Mandatory=$true)][string]$Setting
    )

    # Structures
    $Settings = @(
        @{Name = "Default"; Value = "0"},
        @{Name = "DisableIPv6"; Value = "255"},
        @{Name = "DisableTeredo"; Value = "1"},
        @{Name = "PreferIPv4"; Value = "32"}
    )

    # Variables
    $Config = ($Settings | Where-Object { $_.Name -eq $Setting }).Value

    # Modify IPv6 Preferences
    try {
        Invoke-ElevatedShell "
            Write-Host 'Setting IPv6 preferences!' -ForegroundColor Cyan
            Set-RegistryKey -Path 'HKLM\System\CurrentControlSet\Tcpip6\Parameters' -Name 'DisabledComponents' -Type 'REG_DWORD' -Value $Config
            Write-Host ''
            Pause
        "
    } catch {
        Show-ErrorMessage -Title "Failed to run!" -Message $_.Exception.Message
        Pause
    }
}

function Enable-VerboseMode {
    try {
        Invoke-ElevatedShell "
            # Structures
            `$Keys = @(
                @{Path = 'HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System'; Name = 'VerboseStatus'; Type = 'REG_DWORD'; Value = '1'},
                @{Path = 'HKLM\System\CurrentControlSet\Control'; Name = 'WaitToKillServiceTimeout'; Type = 'REG_DWORD'; Value = '3000'}
                @{Path = 'HKLM\System\CurrentControlSet\Control\CrashControl'; Name = 'DisableEmoticon'; Type = 'REG_DWORD'; Value = '1'},
                @{Path = 'HKLM\System\CurrentControlSet\Control\CrashControl'; Name = 'DisplayParameters'; Type = 'REG_DWORD'; Value = '1'},
                @{Path = 'HKLM\System\CurrentControlSet\Control\FileSystem'; Name = 'LongPathsEnabled'; Value = '1'; Type = 'REG_DWORD'}
            )

            # Edit registry keys
            Write-Host 'Enabling verbose mode!' -ForegroundColor Cyan
            foreach (`$Key in `$Keys) {
                Set-RegistryKey -Path `$Key.Path -Name `$Key.Name -Type `$Key.Type -Value `$Key.Value
            }
            Write-Host ''
            Pause
        "
    } catch {
        Show-ErrorMessage -Title "Failed to run!" -Message $_.Exception.Message
        Pause
    }
}
