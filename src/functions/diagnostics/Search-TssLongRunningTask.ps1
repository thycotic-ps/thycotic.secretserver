function Search-TssLongRunningTask {
    <#
    .SYNOPSIS
    List the long-running tasks

    .DESCRIPTION
    Lists the long-running tasks shown on the Long Running Tasks tab under Admin, Diagnostics: background task locks Secret Server considers stale, with when each was created, its time to live in minutes and when it expires.
    Release a stuck task with Clear-TssLongRunningTask. Requires the Administer Configuration or View Configuration permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssLongRunningTask -TssSession $session

    List the long-running tasks

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Search-TssLongRunningTask

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Search-TssLongRunningTask.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server on-premises only (Secret Server Cloud answers Access denied).
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Diagnostics.LongRunningTask[]')]
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
            $uri = $TssSession.ApiUrl, 'diagnostics', 'long-running-tasks' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssLongRunningTask request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Diagnostics.LongRunningTask[]](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Diagnostics.LongRunningTask]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
