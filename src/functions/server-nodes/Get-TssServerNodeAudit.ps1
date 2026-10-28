function Get-TssServerNodeAudit {
    <#
    .SYNOPSIS
    Get the server node audit history

    .DESCRIPTION
    Gets the audit records of server node changes, such as nodes being created, joining or leaving the cluster and role changes.
    Returns every record; the endpoint is not paged.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssServerNodeAudit -TssSession $session | Sort-Object Date -Descending | Select-Object -First 10

    Gets the ten most recent server node audit records

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/server-nodes/Get-TssServerNodeAudit

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/server-nodes/Get-TssServerNodeAudit.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.ServerNodes.Audit[]')]
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
            Compare-TssVersion $TssSession '11.7.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'nodes', 'audit' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssServerNodeAudit request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.ServerNodes.Audit[]](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.ServerNodes.Audit]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
