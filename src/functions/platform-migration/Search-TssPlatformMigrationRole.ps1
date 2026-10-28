function Search-TssPlatformMigrationRole {
    <#
    .SYNOPSIS
    Search the Secret Server roles in scope for Delinea Platform migration

    .DESCRIPTION
    Returns the Secret Server roles in scope for migration to the Delinea Platform, with their migration state.
    The endpoint is a read even though it is called with POST (the filter is sent in the request body).
    Requires Delinea Platform integration on the Secret Server instance; without it the server returns an error (API_PlatformNotEnabled).

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Name
    Return roles whose name matches this text

    .PARAMETER RoleId
    Return only these role IDs

    .PARAMETER UserId
    Return the roles assigned to these user IDs

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssPlatformMigrationRole -TssSession $session

    Returns every role with its migration state, permission count and assignment count

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssPlatformMigrationRole -TssSession $session -UserId 15

    Returns the roles assigned to user 15

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Search-TssPlatformMigrationRole

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Search-TssPlatformMigrationRole.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.PlatformMigration.MigrationRole[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [string]
        $Name,

        [int[]]
        $RoleId,

        [int[]]
        $UserId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'platform-migration', 'roles' -join '/'
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
                'RoleId' {
                    $body.filter.Add('roleIds', $RoleId)
                }
                'UserId' {
                    $body.filter.Add('userIds', $UserId)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssPlatformMigrationRole request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.PlatformMigration.MigrationRole[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.PlatformMigration.MigrationRole]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
