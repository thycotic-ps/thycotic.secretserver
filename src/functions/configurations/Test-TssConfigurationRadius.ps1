function Test-TssConfigurationRadius {
    <#
    .SYNOPSIS
    Test a RADIUS login

    .DESCRIPTION
    Tests a login against the RADIUS server in the login configuration.
    Returns Success False when the RADIUS server rejects the credential or no RADIUS server is configured; a failed login is not an error.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Credential
    RADIUS user name and password to test

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $radiusCred = Get-Credential
    Test-TssConfigurationRadius -TssSession $session -Credential $radiusCred

    Test a RADIUS login with the user name and password entered at the prompt

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Test-TssConfigurationRadius

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Test-TssConfigurationRadius.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Configuration.RadiusTestResult')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [System.Management.Automation.PSCredential]
        $Credential
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'login', 'radius', 'test' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{
                data = @{
                    radiusUsername = $Credential.UserName
                    radiusPassword = $Credential.GetNetworkCredential().Password
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri (request body not shown: it carries sensitive values)"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Test-TssConfigurationRadius request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Configuration.RadiusTestResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.RadiusTestResult]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
