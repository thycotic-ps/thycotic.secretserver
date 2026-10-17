function Clear-TssLongRunningTask {
    <#
    .SYNOPSIS
    Clear a long-running task

    .DESCRIPTION
    Clears a long-running task: releases the lock a background task holds so the task can run again, the same as clearing it on the Long Running Tasks tab under Admin, Diagnostics. Clear only a task that is stuck.
    Returns an object whose Success property is True when the task was cleared. Requires the Administer Configuration permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER TaskName
    Name of the long-running task, as returned by Search-TssLongRunningTask

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssLongRunningTask -TssSession $session

    List the long-running tasks

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssLongRunningTask -TssSession $session | Where-Object TaskName -Like '*Heartbeat*' | Clear-TssLongRunningTask -TssSession $session

    Clear the long-running heartbeat tasks

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Clear-TssLongRunningTask

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Clear-TssLongRunningTask.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server on-premises only (Secret Server Cloud answers Access denied).
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Diagnostics.OperationResult')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string[]]
        $TaskName
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($currentTaskName in $TaskName) {
                $restResponse = $null
                $escapedTaskName = [uri]::EscapeDataString($currentTaskName)
                $uri = $TssSession.ApiUrl, 'diagnostics', 'long-running-tasks', 'clear', $escapedTaskName -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'POST'
                if ($PSCmdlet.ShouldProcess("Long running task: $currentTaskName", "$($invokeParams.Method) $uri")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning 'Issue with Clear-TssLongRunningTask request'
                        $err = $_
                        . $ErrorHandling $err
                    }
                    if ($restResponse) {
                        [Thycotic.PowerShell.Diagnostics.OperationResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Diagnostics.OperationResult]))
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
