function Clear-TssConfigurationAdCredential {
    <#
    .SYNOPSIS
    Clear cached Active Directory credentials

    .DESCRIPTION
    Clears the Active Directory credentials Secret Server has cached for Active Directory logins, so the next Active Directory login is checked against the domain again.
    Returns Success True, also when no Active Directory integration is configured.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Clear-TssConfigurationAdCredential -TssSession $session

    Clear the cached Active Directory credentials

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Clear-TssConfigurationAdCredential

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Clear-TssConfigurationAdCredential.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Configuration.AdCredentialClearResult')]
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
            $uri = $TssSession.ApiUrl, 'configuration', 'login', 'clear-ad-credentials' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            if ($PSCmdlet.ShouldProcess("Configuration ad credential", "$($invokeParams.Method) $uri")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Clear-TssConfigurationAdCredential request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Configuration.AdCredentialClearResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.AdCredentialClearResult]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
