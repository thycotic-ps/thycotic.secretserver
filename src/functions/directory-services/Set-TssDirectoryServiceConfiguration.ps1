function Set-TssDirectoryServiceConfiguration {
    <#
    .SYNOPSIS
    Update the Directory Services configuration

    .DESCRIPTION
    Update the Directory Services settings. Only the parameters you pass are sent; everything else stays as it is. Pass a switch as -EnableUserDisabling:$false to turn that setting off.
    The server applies -DisableInactiveUsersMonths only while user disabling is on (already on, or turned on with -EnableUserDisabling in the same call) and ignores it otherwise. Turning user disabling off clears the stored months, which then read back as 3. The synchronization interval is applied only while directory synchronization is on, and synchronization cannot be turned on while directory integration is off.
    Returns the updated configuration.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER DaysToKeepOperationalLogs
    Days to keep the directory synchronization log

    .PARAMETER DisableInactiveUsersMonths
    Months without a login before a directory user is disabled, 1 to 12; applied only while user disabling is on

    .PARAMETER EnableDirectoryIntegration
    Enable directory integration (Active Directory, Azure AD, OpenLDAP)

    .PARAMETER EnableDirectorySynchronization
    Enable the scheduled directory synchronization

    .PARAMETER EnableIntegratedWindowsAuthentication
    Enable integrated Windows authentication

    .PARAMETER EnableUserDisabling
    Disable directory users who have not logged in for DisableInactiveUsersMonths months; turning it off resets DisableInactiveUsersMonths to the server default of 3

    .PARAMETER SynchronizationIntervalDays
    Days part of the synchronization interval, applied only while directory synchronization is on

    .PARAMETER SynchronizationIntervalHours
    Hours part of the synchronization interval, applied only while directory synchronization is on

    .PARAMETER SynchronizationIntervalMinutes
    Minutes part of the synchronization interval, applied only while directory synchronization is on

    .PARAMETER UserAccountOptions
    How synchronized users are created: ImportEnabled, ImportDisabled or MirrorDirectory

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssDirectoryServiceConfiguration -TssSession $session -SynchronizationIntervalDays 0 -SynchronizationIntervalHours 4 -SynchronizationIntervalMinutes 0

    Synchronize the directory every four hours (directory synchronization must already be on)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssDirectoryServiceConfiguration -TssSession $session -EnableUserDisabling -DisableInactiveUsersMonths 6

    Disable directory users after six months without a login

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/Set-TssDirectoryServiceConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/Set-TssDirectoryServiceConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Requires the Administer Active Directory permission.
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.DirectoryServices.Configuration')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [int]
        $DaysToKeepOperationalLogs,

        [int]
        $DisableInactiveUsersMonths,

        [switch]
        $EnableDirectoryIntegration,

        [switch]
        $EnableDirectorySynchronization,

        [switch]
        $EnableIntegratedWindowsAuthentication,

        [switch]
        $EnableUserDisabling,

        [int]
        $SynchronizationIntervalDays,

        [int]
        $SynchronizationIntervalHours,

        [int]
        $SynchronizationIntervalMinutes,

        [ValidateSet('ImportEnabled', 'ImportDisabled', 'MirrorDirectory')]
        [string]
        $UserAccountOptions
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'directory-services', 'configuration' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'DaysToKeepOperationalLogs' {
                    $body.data.Add('daysToKeepOperationalLogs', @{ dirty = $true; value = $DaysToKeepOperationalLogs })
                }
                'DisableInactiveUsersMonths' {
                    $body.data.Add('disableInactiveUsersMonths', @{ dirty = $true; value = $DisableInactiveUsersMonths })
                }
                'EnableDirectoryIntegration' {
                    $body.data.Add('enableDirectoryIntegration', @{ dirty = $true; value = [boolean]$EnableDirectoryIntegration })
                }
                'EnableDirectorySynchronization' {
                    $body.data.Add('enableDirectorySynchronization', @{ dirty = $true; value = [boolean]$EnableDirectorySynchronization })
                }
                'EnableIntegratedWindowsAuthentication' {
                    $body.data.Add('enableIntegratedWindowsAuthentication', @{ dirty = $true; value = [boolean]$EnableIntegratedWindowsAuthentication })
                }
                'EnableUserDisabling' {
                    $body.data.Add('enableUserDisabling', @{ dirty = $true; value = [boolean]$EnableUserDisabling })
                }
                'SynchronizationIntervalDays' {
                    $body.data.Add('synchronizationIntervalDays', @{ dirty = $true; value = $SynchronizationIntervalDays })
                }
                'SynchronizationIntervalHours' {
                    $body.data.Add('synchronizationIntervalHours', @{ dirty = $true; value = $SynchronizationIntervalHours })
                }
                'SynchronizationIntervalMinutes' {
                    $body.data.Add('synchronizationIntervalMinutes', @{ dirty = $true; value = $SynchronizationIntervalMinutes })
                }
                'UserAccountOptions' {
                    $body.data.Add('userAccountOptions', @{ dirty = $true; value = $UserAccountOptions })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Directory configuration", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssDirectoryServiceConfiguration request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.DirectoryServices.Configuration](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.DirectoryServices.Configuration]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
