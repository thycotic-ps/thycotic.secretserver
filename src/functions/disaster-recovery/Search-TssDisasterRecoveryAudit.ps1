function Search-TssDisasterRecoveryAudit {
    <#
    .SYNOPSIS
    Search Disaster Recovery configuration audits

    .DESCRIPTION
    Returns the audit entries for changes to the Disaster Recovery configuration of this Secret Server.
    Incoming audits cover this Secret Server as a data replica (incoming configuration); Outgoing audits cover it as a data source (data replicas). -AuditType defaults to Incoming.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER AuditType
    Audit type: Incoming (data replica side) or Outgoing (data source side). Default Incoming

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDisasterRecoveryAudit -TssSession $session

    List the incoming configuration audits

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDisasterRecoveryAudit -TssSession $session -AuditType Outgoing

    List the data replica audits of this data source

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/disaster-recovery/Search-TssDisasterRecoveryAudit

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/disaster-recovery/Search-TssDisasterRecoveryAudit.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Configuration.Audit[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [ValidateSet('Incoming', 'Outgoing')]
        [string]
        $AuditType = 'Incoming'
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'disaster-recovery', 'audits' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            $queryParams += "auditType=$([uri]::EscapeDataString($AuditType))"
            if ($queryParams) {
                $uri = $uri, ($queryParams -join '&') -join '?'
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssDisasterRecoveryAudit request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Configuration.Audit[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Configuration.Audit]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
