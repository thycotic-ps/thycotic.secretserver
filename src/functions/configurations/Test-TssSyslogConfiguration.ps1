function Test-TssSyslogConfiguration {
    <#
    .SYNOPSIS
    Send a test syslog message

    .DESCRIPTION
    Sends a test message to the syslog server configured in Secret Server and returns whether it succeeded, with a description.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Test-TssSyslogConfiguration -TssSession $session

    Sends a test syslog message

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Test-TssSyslogConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Test-TssSyslogConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Configuration.SyslogTestResult')]
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
            $uri = $TssSession.ApiUrl, 'configuration', 'syslog', 'test' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Test-TssSyslogConfiguration request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Configuration.SyslogTestResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.SyslogTestResult]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
