function Get-TssPlatformPreCheckFederatedUserSource {
    <#
    .SYNOPSIS
    Get the Delinea Platform migration pre-check of federated user sources

    .DESCRIPTION
    Returns the migration pre-check summary of the SAML and OpenID Connect user sources: totals, valid counts and the errors that would prevent or affect their migration to the Delinea Platform.
    Requires Delinea Platform integration on the Secret Server instance; without it the server returns an error (API_PlatformNotEnabled).

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssPlatformPreCheckFederatedUserSource -TssSession $session

    Returns the SAML and OpenID Connect pre-check totals and errors

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    (Get-TssPlatformPreCheckFederatedUserSource -TssSession $session).Errors

    Returns only the pre-check errors

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Get-TssPlatformPreCheckFederatedUserSource

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Get-TssPlatformPreCheckFederatedUserSource.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.PlatformMigration.PlatformPreCheckFederatedUserSource')]
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
            $uri = $TssSession.ApiUrl, 'platform-migration', 'federated-user-sources' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssPlatformPreCheckFederatedUserSource request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.PlatformMigration.PlatformPreCheckFederatedUserSource](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.PlatformMigration.PlatformPreCheckFederatedUserSource]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
