function Get-TssConfigurationLoginPolicy {
    <#
    .SYNOPSIS
    Get the login policy configuration

    .DESCRIPTION
    Returns the login policy banner configuration: whether the banner shows on the login page, whether users must accept it, and the banner text.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssConfigurationLoginPolicy -TssSession $session

    Get the login policy configuration

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssConfigurationLoginPolicy

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssConfigurationLoginPolicy.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Configuration.ConfigurationLoginPolicy')]
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
            $uri = $TssSession.ApiUrl, 'configuration', 'login-policy' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssConfigurationLoginPolicy request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Configuration.ConfigurationLoginPolicy](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.ConfigurationLoginPolicy]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
