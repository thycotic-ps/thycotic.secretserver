function Search-TssRoleAudit {
    <#
    .SYNOPSIS
    Search role audit records

    .DESCRIPTION
    Returns role and role permission audit records, newest first.
    Requires permission to view roles.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER AuditType
    Audit records to return: All, Permission or Role. Default All

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssRoleAudit -TssSession $session

    Returns every role audit record, newest first

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssRoleAudit -TssSession $session -AuditType Permission

    Returns only role permission audit records

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/roles/Search-TssRoleAudit

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/roles/Search-TssRoleAudit.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Roles.Audit[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [ValidateSet('All', 'Permission', 'Role')]
        [string]
        $AuditType = 'All'
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'role-audits' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            $queryParams += "filter.auditType=$AuditType"
            $queryParams += 'sortBy[0].name=dateRecorded'
            $queryParams += 'sortBy[0].direction=desc'
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
                Write-Warning 'Issue with Search-TssRoleAudit request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Roles.Audit[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Roles.Audit]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
