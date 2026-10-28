function Search-TssSharedAudit {
    <#
    .SYNOPSIS
    Search the audit entries of an audited item

    .DESCRIPTION
    Returns the audit entries Secret Server keeps for an audited item, such as a site, secret template or group: the action, who did it, when, from which IP address and machine, and how many field changes it made (ChangesetCount).
    The server requires both AuditType and ItemId. Search-TssChangeHistory returns the field changes of an entry.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER AuditType
    Type of the audited item

    .PARAMETER ItemId
    Id of the audited item

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSharedAudit -TssSession $session -AuditType Site -ItemId 1

    Get the audit entries of the site with Id 1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSharedAudit -TssSession $session -AuditType Group -ItemId 3 | Sort-Object DateRecorded -Descending | Select-Object -First 5

    Get the five most recent audit entries of the group with Id 3

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/shared-audits/Search-TssSharedAudit

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/shared-audits/Search-TssSharedAudit.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SharedAudits.SharedAudit[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [ValidateSet('Site', 'EventSubscription', 'SecretTemplate', 'LauncherType', 'InternalCommunication', 'SecurityAnalytics', 'DualControl', 'IPAddressRange', 'License', 'DatabaseConfiguration', 'Group', 'ManualUpgrade', 'InboxRule', 'ExternalVault', 'ExternalVaultSecret', 'SecretDependency', 'CustomDictionary', 'ReportCategory')]
        [string]
        $AuditType,

        [Parameter(Mandatory)]
        [int]
        $ItemId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'shared-audits' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'AuditType' {
                    $queryParams += "filter.auditType=$([uri]::EscapeDataString($AuditType))"
                }
                'ItemId' {
                    $queryParams += "filter.itemId=$($ItemId)"
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
                Write-Warning 'Issue with Search-TssSharedAudit request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.SharedAudits.SharedAudit[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.SharedAudits.SharedAudit]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
