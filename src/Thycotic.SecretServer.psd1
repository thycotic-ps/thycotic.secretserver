#
# Module manifest for module 'Thycotic.SecretServer'
#
# Generated by: Delinea Professional Services
#
# Generated on: 6/22/2022
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'Thycotic.SecretServer.psm1'

# Version number of this module.
ModuleVersion = '0.61.0'

# Supported PSEditions
CompatiblePSEditions = 'Desktop', 'Core'

# ID used to uniquely identify this module
GUID = 'e6b56c5f-41ac-4ba4-8b88-2c063f683176'

# Author of this module
Author = 'Delinea Professional Services'

# Company or vendor of this module
CompanyName = 'Delinea'

# Copyright statement for this module
Copyright = '(c) Delinea Professional Services. All rights reserved.'

# Description of the functionality provided by this module
Description = 'Interact with the Secret Server REST API'

# Minimum version of the PowerShell engine required by this module
PowerShellVersion = '5.1'

# Name of the PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# ClrVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
TypesToProcess = 'Thycotic.SecretServer.Types.ps1xml'

# Format files (.ps1xml) to be loaded when importing this module
FormatsToProcess = 'Thycotic.SecretServer.Format.ps1xml'

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
NestedModules = @('bin\Thycotic.SecretServer.dll')

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = 'Add-TssDirectoryServiceGroup', 'Add-TssEventPipeline',
               'Add-TssFolderPermission', 'Add-TssGroupMember', 'Add-TssListOption',
               'Add-TssSecretPermission', 'Add-TssSecretTemplateField',
               'Clear-TssList', 'Clear-TssListOption', 'Close-TssSecret',
               'Close-TssSession', 'Disable-TssEventPipeline',
               'Disable-TssEventPipelinePolicy', 'Disable-TssSecretCheckout',
               'Disable-TssSecretEmail', 'Disable-TssUnlimitedAdmin',
               'Disable-TssUser', 'Enable-TssEventPipeline',
               'Enable-TssEventPipelinePolicy', 'Enable-TssSecretCheckout',
               'Enable-TssSecretEmail', 'Enable-TssUnlimitedAdmin', 'Enable-TssUser',
               'Export-TssAutoExportStorageItem', 'Export-TssReport',
               'Find-TssFolder', 'Find-TssGroup', 'Find-TssReport', 'Find-TssSecret',
               'Find-TssUser', 'Get-TssConfiguration',
               'Get-TssConfigurationAutoExport', 'Get-TssConfigurationBackup',
               'Get-TssConfigurationLocalUserPassword',
               'Get-TssConfigurationLogin', 'Get-TssConfigurationRpc',
               'Get-TssConfigurationSaml', 'Get-TssConfigurationSearchIndex',
               'Get-TssConfigurationSecurity', 'Get-TssConfigurationSiteConnector',
               'Get-TssDiagnostic', 'Get-TssDiagnosticBackgroundProcess',
               'Get-TssDiagnosticConnectivityReport',
               'Get-TssDirectoryServiceDomain',
               'Get-TssDirectoryServiceSyncStatus', 'Get-TssDiscoveryStatus',
               'Get-TssDistributedEngineConfiguration',
               'Get-TssDistributedEngineConnectorCredential',
               'Get-TssDistributedEngineDownload',
               'Get-TssDistributedEngineServerCapabilities',
               'Get-TssDistributedEngineSite',
               'Get-TssDistributedEngineSiteConnector', 'Get-TssEventPipeline',
               'Get-TssEventPipelinePolicy', 'Get-TssEventPipelinePolicyActivity',
               'Get-TssEventPipelineRun', 'Get-TssFolder', 'Get-TssFolderAudit',
               'Get-TssFolderPermission', 'Get-TssFolderState', 'Get-TssGroup',
               'Get-TssGroupMember', 'Get-TssGroupRole', 'Get-TssGroupUser',
               'Get-TssList', 'Get-TssListCategory', 'Get-TssListOption',
               'Get-TssMetadataField', 'Get-TssReport', 'Get-TssReportCategory',
               'Get-TssReportParameter', 'Get-TssReportSchedule',
               'Get-TssRpcAssociatedSecret', 'Get-TssRpcPasswordType',
               'Get-TssScript', 'Get-TssSecret', 'Get-TssSecretAccessRequest',
               'Get-TssSecretAccessRequestOption',
               'Get-TssSecretAccessRequestSecret', 'Get-TssSecretAttachment',
               'Get-TssSecretAudit', 'Get-TssSecretDependency',
               'Get-TssSecretDependencyGroup', 'Get-TssSecretDependencyRunStatus',
               'Get-TssSecretDependencyScript', 'Get-TssSecretDependencyStub',
               'Get-TssSecretDependencyTemplate', 'Get-TssSecretField',
               'Get-TssSecretHeartbeatStatus', 'Get-TssSecretHook',
               'Get-TssSecretHookStub', 'Get-TssSecretPasswordStatus',
               'Get-TssSecretPolicy', 'Get-TssSecretPolicyItemStub',
               'Get-TssSecretPolicyStub', 'Get-TssSecretSetting',
               'Get-TssSecretState', 'Get-TssSecretStub', 'Get-TssSecretSummary',
               'Get-TssSecretTemplate', 'Get-TssSecretTemplateFolder',
               'Get-TssSecretWebTemplate', 'Get-TssSite', 'Get-TssUser',
               'Get-TssUserAudit', 'Get-TssUserGroup', 'Get-TssUserOwner',
               'Get-TssUserRole', 'Get-TssUserRoleAssigned', 'Get-TssVersion',
               'Initialize-TssSdkClient', 'Invoke-TssReport', 'Invoke-TssRestApi',
               'Invoke-TssSecretGeneratePassword', 'Lock-TssUser', 'Move-TssFolder',
               'New-TssDirectoryService', 'New-TssDistributedEngineSite',
               'New-TssDistributedEngineSiteConnector', 'New-TssFolder',
               'New-TssFolderPermission', 'New-TssGroup', 'New-TssIpRestriction',
               'New-TssList', 'New-TssMetadataField', 'New-TssReport',
               'New-TssReportSchedule', 'New-TssScript', 'New-TssSecret',
               'New-TssSecretDependency', 'New-TssSecretDependencyGroup',
               'New-TssSecretHook', 'New-TssSecretPermission', 'New-TssSecretPolicy',
               'New-TssSecretTemplate', 'New-TssSecretTemplateField',
               'New-TssSession', 'New-TssUser', 'Open-TssSecret',
               'Register-TssDistributedEngine', 'Remove-TssDirectoryServiceGroup',
               'Remove-TssDistributedEngine', 'Remove-TssEventPipeline',
               'Remove-TssFolder', 'Remove-TssFolderPermission',
               'Remove-TssFolderTemplate', 'Remove-TssGroupMember',
               'Remove-TssIpRestriction', 'Remove-TssIpRestrictionGroup',
               'Remove-TssIpRestrictionUser', 'Remove-TssList', 'Remove-TssMetadata',
               'Remove-TssReport', 'Remove-TssReportCategory',
               'Remove-TssReportSchedule', 'Remove-TssSecret',
               'Remove-TssSecretDependency', 'Remove-TssSecretHook',
               'Remove-TssSecretPermission', 'Remove-TssUserPii',
               'Reset-TssUserPassword', 'Restore-TssSecret', 'Revoke-TssSecret',
               'Search-TssAutoExportStorage', 'Search-TssConfigurationAudit',
               'Search-TssConfigurationBackupLog',
               'Search-TssDirectoryServiceDomain',
               'Search-TssDirectoryServiceGroup',
               'Search-TssDirectoryServiceGroupMember',
               'Search-TssDistributedEngine',
               'Search-TssDistributedEngineConnector',
               'Search-TssDistributedEngineSite', 'Search-TssEventPipeline',
               'Search-TssEventPipelinePolicy', 'Search-TssFolder',
               'Search-TssFolderPermission', 'Search-TssGroup',
               'Search-TssIpRestriction', 'Search-TssIpRestrictionGroup',
               'Search-TssIpRestrictionUser', 'Search-TssList', 'Search-TssMetadata',
               'Search-TssMetadataHistory', 'Search-TssMetadataSection',
               'Search-TssReport', 'Search-TssReportSchedule', 'Search-TssRole',
               'Search-TssRpcPasswordType', 'Search-TssScript', 'Search-TssSecret',
               'Search-TssSecretAccessRequest', 'Search-TssSecretDependency',
               'Search-TssSecretHook', 'Search-TssSecretPermission',
               'Search-TssSecretPolicy', 'Search-TssSecretsByUrl',
               'Search-TssSecretTemplate', 'Search-TssServerNode',
               'Search-TssSystemLog', 'Search-TssUser', 'Search-TssWorkflowTemplate',
               'Set-TssConfigurationAutoExport', 'Set-TssConfigurationGeneral',
               'Set-TssConfigurationLocalUserPassword',
               'Set-TssConfigurationLogin', 'Set-TssConfigurationRpc',
               'Set-TssConfigurationSecurity', 'Set-TssDistributedEngine',
               'Set-TssDistributedEngineSite',
               'Set-TssDistributedEngineSiteConnector', 'Set-TssFolder',
               'Set-TssIpRestrictionGroup', 'Set-TssIpRestrictionUser',
               'Set-TssSecret', 'Set-TssSecretExpiration', 'Set-TssSecretField',
               'Set-TssSecretPolicy', 'Set-TssSecretRpcAssociated',
               'Set-TssSecretRpcPrivileged', 'Set-TssSecretSecurity',
               'Set-TssSecretTemplate', 'Show-TssCurrentUser',
               'Show-TssListCurrentUser', 'Start-TssConfigurationBackup',
               'Start-TssConfigurationSearchIndex',
               'Start-TssDirectoryServiceSync', 'Start-TssDiscovery',
               'Start-TssSecretChangePassword', 'Start-TssSecretDependency',
               'Start-TssSecretHeartbeat', 'Stop-TssSecretChangePassword',
               'Test-TssDistributedEngineCloudAccess',
               'Test-TssDistributedEngineSiteConnector', 'Test-TssFolderAction',
               'Test-TssSdkClient', 'Test-TssSecretAction', 'Test-TssSecretState',
               'Test-TssSession', 'Test-TssVersion', 'Unlock-TssUser',
               'Unregister-TssDistributedEngine', 'Update-TssDistributedEngine',
               'Update-TssFolder', 'Update-TssFolderPermission',
               'Update-TssGroupMember', 'Update-TssIpRestriction', 'Update-TssList',
               'Update-TssMetadataField', 'Update-TssMetadataSection',
               'Update-TssSecret', 'Update-TssSecretAccessRequest',
               'Update-TssSecretHook', 'Update-TssSecretPermission',
               'Update-TssSecretRdpLauncherSetting',
               'Update-TssSecretTemplateField', 'Update-TssServerNode',
               'Update-TssUser', 'Update-TssUserPassword',
               'Write-TssSecretAccessRequestViewComment'

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = 'Start-TssLog', 'Stop-TssLog', 'Write-TssLog'

# Variables to export from this module
# VariablesToExport = @()

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @()

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = 'SecretServer','Thycotic','DevOps','Security'

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/thycotic-ps/thycotic.secretserver/blob/main/LICENSE'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/thycotic-ps/thycotic.secretserver'

        # A URL to an icon representing this module.
        IconUri = 'https://thyproservices.z20.web.core.windows.net/thycotic.secretserver_logo.png'

        # ReleaseNotes of this module
        ReleaseNotes = 'https://github.com/thycotic-ps/thycotic.secretserver/blob/main/CHANGELOG.md'

        # Prerelease string of this module
        # Prerelease = ''

        # Flag to indicate whether the module requires explicit user acceptance for install/update/save
        # RequireLicenseAcceptance = $false

        # External dependent modules of this module
        # ExternalModuleDependencies = @()

    } # End of PSData hashtable

 } # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

