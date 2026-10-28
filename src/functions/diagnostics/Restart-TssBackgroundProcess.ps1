function Restart-TssBackgroundProcess {
    <#
    .SYNOPSIS
    Recycle the Secret Server background processes

    .DESCRIPTION
    Recycles the background processes (scheduler, remote password changing, heartbeat and the other worker threads) without an IIS reset, the same as the Recycle Background Processes button under Admin, Diagnostics. Active user sessions are not affected.
    Returns an object whose Success property is True when the recycle was started. Requires the Administer Configuration permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Restart-TssBackgroundProcess -TssSession $session

    Recycle the background processes

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Restart-TssBackgroundProcess -TssSession $session -WhatIf

    Show what would be sent without recycling anything

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Restart-TssBackgroundProcess

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Restart-TssBackgroundProcess.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server on-premises only (Secret Server Cloud answers Access denied).
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
            $uri = $TssSession.ApiUrl, 'diagnostics', 'recycle-background-processes' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            if ($PSCmdlet.ShouldProcess("Background process", "$($invokeParams.Method) $uri")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Restart-TssBackgroundProcess request'
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
