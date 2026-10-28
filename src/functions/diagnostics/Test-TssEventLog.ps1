function Test-TssEventLog {
    <#
    .SYNOPSIS
    Write a test entry to the Secret Server event log

    .DESCRIPTION
    Asks Secret Server to write a test entry to the Windows event log of the web server, to check that event log writing works.
    Returns True when the entry was written. When the web server cannot write to the event log (for example, the application pool identity may not create the Secret Server event source), the error Secret Server returns is written as an error.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Test-TssEventLog -TssSession $session

    Write a test entry to the event log and return True when it worked

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Test-TssEventLog

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Test-TssEventLog.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).
    #>
    [CmdletBinding()]
    [OutputType('System.Boolean')]
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
            $uri = $TssSession.ApiUrl, 'diagnostics', 'test-event-log' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Test-TssEventLog request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($null -ne $restResponse) {
                [System.Convert]::ToBoolean($restResponse)
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
