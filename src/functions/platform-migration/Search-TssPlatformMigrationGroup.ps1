function Search-TssPlatformMigrationGroup {
    <#
    .SYNOPSIS
    Search the Secret Server groups in scope for Delinea Platform migration

    .DESCRIPTION
    Returns the Secret Server groups in scope for migration to the Delinea Platform, with their migration state.
    The endpoint is a read even though it is called with POST (the filter is sent in the request body).
    Requires Delinea Platform integration on the Secret Server instance; without it the server returns an error (API_PlatformNotEnabled).

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Name
    Return groups whose name matches this text

    .PARAMETER MigrationState
    Return groups in these migration states

    .PARAMETER ExcludeSystemGroups
    Leave out the system groups

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssPlatformMigrationGroup -TssSession $session -ExcludeSystemGroups

    Returns the groups in scope for migration, without system groups

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssPlatformMigrationGroup -TssSession $session -MigrationState MigrationError

    Returns the groups whose last migration failed

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Search-TssPlatformMigrationGroup

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Search-TssPlatformMigrationGroup.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.PlatformMigration.MigrationGroup[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [string]
        $Name,

        [ValidateSet('NotMigrated', 'Migrated', 'DoNotMigrate', 'MigrationError')]
        [string[]]
        $MigrationState,

        [switch]
        $ExcludeSystemGroups
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'platform-migration', 'groups' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{
                skip   = 0
                take   = $TssSession.Take
                filter = @{ }
            }
            switch ($tssParams.Keys) {
                'Name' {
                    $body.filter.Add('name', $Name)
                }
                'MigrationState' {
                    $body.filter.Add('migrationStates', $MigrationState)
                }
                'ExcludeSystemGroups' {
                    $body.filter.Add('excludeSystemGroups', [boolean]$ExcludeSystemGroups)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssPlatformMigrationGroup request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.PlatformMigration.MigrationGroup[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.PlatformMigration.MigrationGroup]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
