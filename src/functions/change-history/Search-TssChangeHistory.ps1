function Search-TssChangeHistory {
    <#
    .SYNOPSIS
    Search the change history of an audited item

    .DESCRIPTION
    Returns the field level change history Secret Server keeps for an audited item, such as a site, secret template or group: the field that changed, its new value, and who changed it and when.
    The server requires both AuditType and ItemId.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER AuditId
    Return only the changes recorded with this audit entry (AuditId of a Search-TssSharedAudit result)

    .PARAMETER AuditType
    Type of the audited item

    .PARAMETER FieldName
    Return only the changes to this field

    .PARAMETER ItemId
    Id of the audited item

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssChangeHistory -TssSession $session -AuditType Site -ItemId 1

    Get the change history of the site with Id 1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssChangeHistory -TssSession $session -AuditType SecretTemplate -ItemId 6001 -FieldName Name

    Get the name changes of secret template 6001

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/change-history/Search-TssChangeHistory

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/change-history/Search-TssChangeHistory.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.ChangeHistory.Entry[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [int]
        $AuditId,

        [Parameter(Mandatory)]
        [ValidateSet('Site', 'EventSubscription', 'SecretTemplate', 'LauncherType', 'InternalCommunication', 'SecurityAnalytics', 'DualControl', 'IPAddressRange', 'License', 'DatabaseConfiguration', 'Group', 'ManualUpgrade', 'InboxRule', 'ExternalVault', 'ExternalVaultSecret', 'SecretDependency', 'CustomDictionary', 'ReportCategory')]
        [string]
        $AuditType,

        [string]
        $FieldName,

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
            $uri = $TssSession.ApiUrl, 'change-history' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'AuditId' {
                    $queryParams += "filter.auditId=$($AuditId)"
                }
                'AuditType' {
                    $queryParams += "filter.auditType=$([uri]::EscapeDataString($AuditType))"
                }
                'FieldName' {
                    $queryParams += "filter.fieldName=$([uri]::EscapeDataString($FieldName))"
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
                Write-Warning 'Issue with Search-TssChangeHistory request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.ChangeHistory.Entry[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.ChangeHistory.Entry]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
