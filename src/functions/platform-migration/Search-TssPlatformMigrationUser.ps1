function Search-TssPlatformMigrationUser {
    <#
    .SYNOPSIS
    Search the Secret Server users in scope for Delinea Platform migration

    .DESCRIPTION
    Returns the Secret Server users in scope for migration to the Delinea Platform, with their migration state.
    The endpoint is a read even though it is called with POST (the filter is sent in the request body).
    Requires Delinea Platform integration on the Secret Server instance; without it the server returns an error (API_PlatformNotEnabled).

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Name
    Return users whose name matches this text

    .PARAMETER GroupId
    Return the members of these group IDs

    .PARAMETER UserId
    Return only these user IDs

    .PARAMETER MigrationState
    Return users in these migration states

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssPlatformMigrationUser -TssSession $session -MigrationState NotMigrated

    Returns the users not yet migrated to the Platform

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssPlatformMigrationUser -TssSession $session -GroupId 4 | Where-Object HasTotp

    Returns the members of group 4 that have TOTP configured

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Search-TssPlatformMigrationUser

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Search-TssPlatformMigrationUser.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.PlatformMigration.MigrationUser[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [string]
        $Name,

        [int[]]
        $GroupId,

        [int[]]
        $UserId,

        [ValidateSet('NotMigrated', 'Migrated', 'DoNotMigrate', 'MigrationError')]
        [string[]]
        $MigrationState
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'platform-migration', 'users' -join '/'
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
                'GroupId' {
                    $body.filter.Add('groupIds', $GroupId)
                }
                'UserId' {
                    $body.filter.Add('userIds', $UserId)
                }
                'MigrationState' {
                    $body.filter.Add('migrationStates', $MigrationState)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssPlatformMigrationUser request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.PlatformMigration.MigrationUser[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.PlatformMigration.MigrationUser]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
