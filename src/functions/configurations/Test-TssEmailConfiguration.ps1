function Test-TssEmailConfiguration {
    <#
    .SYNOPSIS
    Send a test email

    .DESCRIPTION
    Send a test email with the current email configuration to the email address of the calling user. Returns whether the send succeeded and the server message.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Test-TssEmailConfiguration -TssSession $session

    Send a test email and show whether it succeeded

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Test-TssEmailConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Test-TssEmailConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Configuration.EmailTestResult')]
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
            $uri = $TssSession.ApiUrl, 'configuration', 'email', 'test' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Test-TssEmailConfiguration request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Configuration.EmailTestResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.EmailTestResult]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
