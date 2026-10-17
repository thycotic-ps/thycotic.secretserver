function Set-TssFolderSyncConfiguration {
    <#
    .SYNOPSIS
    Set the folder synchronization configuration

    .DESCRIPTION
    Set how Secret Server synchronizes folders from ConnectWise. SyncMethodType None turns synchronization off.
    Only the parameters you pass are sent. Returns the folder synchronization configuration after the update.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER CompanyId
    ConnectWise company Id

    .PARAMETER DaysToKeepOperationalLogs
    Days to keep the synchronization operational logs

    .PARAMETER FolderStructure
    Folder structure template, for example $TYPE\$STATUS

    .PARAMETER IntegratorCredentials
    Id of the secret holding the ConnectWise integrator credentials

    .PARAMETER IntervalDays
    Days between synchronizations

    .PARAMETER IntervalHours
    Hours between synchronizations

    .PARAMETER IntervalMinutes
    Minutes between synchronizations

    .PARAMETER SiteUrl
    ConnectWise site URL

    .PARAMETER SqlCustomView
    Custom SQL view to read instead of the standard ConnectWise view (legacy database mode)

    .PARAMETER SqlDatabaseName
    SQL database name (legacy database mode)

    .PARAMETER SqlPassword
    SQL password (legacy database mode)

    .PARAMETER SqlServerLocation
    SQL server (legacy database mode)

    .PARAMETER SqlUsername
    SQL user name (legacy database mode)

    .PARAMETER SyncAllFolders
    Synchronize every folder; pass -SyncAllFolders:$false and -SyncFolderId to synchronize one folder

    .PARAMETER SyncFolderId
    Folder to synchronize when SyncAllFolders is off

    .PARAMETER SyncMethodType
    Synchronization method: None, LegacyDatabaseIntegration or ApiIntegration

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssFolderSyncConfiguration -TssSession $session -IntervalHours 4 -IntervalMinutes 0

    Synchronize folders every four hours

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssFolderSyncConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssFolderSyncConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Configuration.FolderSyncConfiguration')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [string]
        $CompanyId,

        [int]
        $DaysToKeepOperationalLogs,

        [string]
        $FolderStructure,

        [int]
        $IntegratorCredentials,

        [int]
        $IntervalDays,

        [int]
        $IntervalHours,

        [int]
        $IntervalMinutes,

        [string]
        $SiteUrl,

        [string]
        $SqlCustomView,

        [string]
        $SqlDatabaseName,

        [securestring]
        $SqlPassword,

        [string]
        $SqlServerLocation,

        [string]
        $SqlUsername,

        [switch]
        $SyncAllFolders,

        [int]
        $SyncFolderId,

        [ValidateSet('None', 'LegacyDatabaseIntegration', 'ApiIntegration')]
        [string]
        $SyncMethodType
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'folder-synchronization' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'CompanyId' {
                    $body.data.Add('companyId', @{ dirty = $true; value = $CompanyId })
                }
                'DaysToKeepOperationalLogs' {
                    $body.data.Add('daysToKeepOperationalLogs', @{ dirty = $true; value = $DaysToKeepOperationalLogs })
                }
                'FolderStructure' {
                    $body.data.Add('folderStructure', @{ dirty = $true; value = $FolderStructure })
                }
                'IntegratorCredentials' {
                    $body.data.Add('integratorCredentials', @{ dirty = $true; value = $IntegratorCredentials })
                }
                'IntervalDays' {
                    $body.data.Add('intervalDays', @{ dirty = $true; value = $IntervalDays })
                }
                'IntervalHours' {
                    $body.data.Add('intervalHours', @{ dirty = $true; value = $IntervalHours })
                }
                'IntervalMinutes' {
                    $body.data.Add('intervalMinutes', @{ dirty = $true; value = $IntervalMinutes })
                }
                'SiteUrl' {
                    $body.data.Add('siteUrl', @{ dirty = $true; value = $SiteUrl })
                }
                'SqlCustomView' {
                    $body.data.Add('sqlCustomView', @{ dirty = $true; value = $SqlCustomView })
                }
                'SqlDatabaseName' {
                    $body.data.Add('sqlDatabaseName', @{ dirty = $true; value = $SqlDatabaseName })
                }
                'SqlPassword' {
                    $body.data.Add('sqlPassword', @{ dirty = $true; value = [System.Net.NetworkCredential]::new('', $SqlPassword).Password })
                }
                'SqlServerLocation' {
                    $body.data.Add('sqlServerLocation', @{ dirty = $true; value = $SqlServerLocation })
                }
                'SqlUsername' {
                    $body.data.Add('sqlUsername', @{ dirty = $true; value = $SqlUsername })
                }
                'SyncAllFolders' {
                    $body.data.Add('syncAllFolders', @{ dirty = $true; value = [boolean]$SyncAllFolders })
                }
                'SyncFolderId' {
                    $body.data.Add('syncFolderId', @{ dirty = $true; value = $SyncFolderId })
                }
                'SyncMethodType' {
                    $body.data.Add('syncMethodType', @{ dirty = $true; value = $SyncMethodType })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Folder sync configuration", "$($invokeParams.Method) $uri (request body not shown: it carries sensitive values)")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri (request body not shown: it carries sensitive values)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssFolderSyncConfiguration request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Configuration.FolderSyncConfiguration](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.FolderSyncConfiguration]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
