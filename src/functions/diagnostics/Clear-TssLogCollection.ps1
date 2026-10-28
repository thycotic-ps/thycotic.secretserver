function Clear-TssLogCollection {
    <#
    .SYNOPSIS
    Clear the collected logs

    .DESCRIPTION
    Clears the log collection: the collected log files and their status, the same as the Clear button of the log collection under Admin, Diagnostics.
    Returns an object whose Success property is True when the clear was started. Requires the Administer Configuration permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Clear-TssLogCollection -TssSession $session

    Clear the collected logs

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Clear-TssLogCollection

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Clear-TssLogCollection.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Diagnostics.OperationResult')]
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
            $uri = $TssSession.ApiUrl, 'diagnostics', 'log-collections', 'clear' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            if ($PSCmdlet.ShouldProcess("Log collection", "$($invokeParams.Method) $uri")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Clear-TssLogCollection request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Diagnostics.OperationResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Diagnostics.OperationResult]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
