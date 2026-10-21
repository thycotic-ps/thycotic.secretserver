function Test-TssPlatformIntegration {
    <#
    .SYNOPSIS
    Test the Delinea Platform integration of a Secret Server instance

    .DESCRIPTION
    Asks Secret Server whether Delinea Platform integration is configured and whether the session token was issued by that Platform.
    With a Delinea Platform access token (New-TssSession -AccessToken) every flag is True when the vault is integrated with the Platform that issued the token.
    Every flag is False when the session token is not a Platform token the server accepts, for example a Secret Server token or an instance with no Platform integration.
    The endpoint allows anonymous access; the session token is sent so the server can inspect it.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://vault.secretservercloud.com -AccessToken $platformToken
    Test-TssPlatformIntegration -TssSession $session

    Uses a Delinea Platform access token and shows whether the vault accepts the Platform token and matches the Platform issuer

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    (Test-TssPlatformIntegration -TssSession $session).HasIntegrationConfigured

    Returns False for a Secret Server token, because the server only reports integration details for a Platform token

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Test-TssPlatformIntegration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Test-TssPlatformIntegration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Platform.Integration')]
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
            $uri = $TssSession.ApiUrl, 'platform', 'test-integration' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Test-TssPlatformIntegration request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Platform.Integration](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Platform.Integration]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
