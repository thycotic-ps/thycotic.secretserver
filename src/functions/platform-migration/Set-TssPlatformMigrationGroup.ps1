function Set-TssPlatformMigrationGroup {
    <#
    .SYNOPSIS
    Include or exclude groups from Delinea Platform migration

    .DESCRIPTION
    Marks Secret Server groups to be migrated to the Delinea Platform, or with -DoNotMigrate excludes them from migration.
    Search-TssPlatformMigrationGroup returns the groups and their current migration state.
    Requires Delinea Platform integration on the Secret Server instance; without it the server returns an error (API_PlatformNotEnabled).

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret Server group IDs to update

    .PARAMETER DoNotMigrate
    Exclude the groups from migration. Without it the groups are marked to migrate

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssPlatformMigrationGroup -TssSession $session -Id 4, 7

    Marks groups 4 and 7 to be migrated to the Platform

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssPlatformMigrationGroup -TssSession $session -Name 'Contractors' | Set-TssPlatformMigrationGroup -TssSession $session -DoNotMigrate

    Excludes the groups named like Contractors from migration

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Set-TssPlatformMigrationGroup

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Set-TssPlatformMigrationGroup.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Returns True or False (the success flag of the response).
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('System.Boolean')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('GroupId')]
        [int[]]
        $Id,

        [switch]
        $DoNotMigrate
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'platform-migration', 'set-groups-to-migrate' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{
                data = @{
                    groupIds          = $Id
                    setGroupAsMigrate = -not $DoNotMigrate
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Platform migration group", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssPlatformMigrationGroup request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($null -ne $restResponse) {
                    [System.Convert]::ToBoolean($restResponse.success)
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
