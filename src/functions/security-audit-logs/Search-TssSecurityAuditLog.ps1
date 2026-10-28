function Search-TssSecurityAuditLog {
    <#
    .SYNOPSIS
    Search the security audit log

    .DESCRIPTION
    Searches the security audit log: security relevant events such as changes to users, roles, permissions and configuration, with who made them, from which IP address and machine, and when.
    Returns the entries visible to the caller.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER SearchText
    Return only the entries whose text matches

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSecurityAuditLog -TssSession $session

    Get the security audit log entries

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSecurityAuditLog -TssSession $session -SearchText 'role'

    Get the security audit log entries that mention role

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/security-audit-logs/Search-TssSecurityAuditLog

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/security-audit-logs/Search-TssSecurityAuditLog.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SecurityAuditLogs.SecurityAuditLog[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [string]
        $SearchText
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'security-audit-logs' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'SearchText' {
                    $queryParams += "filter.searchText=$([uri]::EscapeDataString($SearchText))"
                }
            }
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
                Write-Warning 'Issue with Search-TssSecurityAuditLog request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.SecurityAuditLogs.SecurityAuditLog[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.SecurityAuditLogs.SecurityAuditLog]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
