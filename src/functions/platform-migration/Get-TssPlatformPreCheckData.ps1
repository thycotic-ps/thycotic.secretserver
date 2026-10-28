function Get-TssPlatformPreCheckData {
    <#
    .SYNOPSIS
    Get the Delinea Platform migration pre-check of users, groups and roles

    .DESCRIPTION
    Returns the migration pre-check summary of users, groups and roles: error, warning and information counts and the items that would prevent or affect their migration to the Delinea Platform.
    The server marks this route deprecated in favor of the separate group, user and role pre-check routes.
    Requires Delinea Platform integration on the Secret Server instance; without it the server returns an error (API_PlatformNotEnabled).

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssPlatformPreCheckData -TssSession $session

    Returns the pre-check counts and items

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    (Get-TssPlatformPreCheckData -TssSession $session).Errors | Where-Object ErrorType -eq 'Error'

    Returns the pre-check items that would prevent migration

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Get-TssPlatformPreCheckData

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Get-TssPlatformPreCheckData.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.PlatformMigration.PlatformPreCheckData')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'platform-migration', 'pre-check-data' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssPlatformPreCheckData request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.PlatformMigration.PlatformPreCheckData](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.PlatformMigration.PlatformPreCheckData]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
