function Get-TssInboxRuleActionLog {
    <#
    .SYNOPSIS
    Get the action log of an inbox rule

    .DESCRIPTION
    Get the action log of an inbox rule: every email or Slack notification the rule sent, with its status.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Inbox rule ID

    .PARAMETER RuleActionStatus
    Return only entries with this status

    .PARAMETER StartDate
    Return only entries on or after this date

    .PARAMETER EndDate
    Return only entries on or before this date

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssInboxRuleActionLog -TssSession $session -Id 1 -RuleActionStatus Failed

    Return the notifications of inbox rule 1 that failed to send

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/Get-TssInboxRuleActionLog

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/Get-TssInboxRuleActionLog.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.InboxRules.ActionLog[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('InboxRuleId')]
        [int[]]
        $Id,

        [datetime]
        $EndDate,

        [ValidateSet('Success', 'Failed', 'FailedAfterThreeAttempts', 'InvalidEmail', 'UnableToResolveHost')]
        [string]
        $RuleActionStatus,

        [datetime]
        $StartDate
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'inbox-rules', $currentId, 'action-log' -join '/'
                $queryParams = @()
                $queryParams += "take=$($TssSession.Take)"
                switch ($tssParams.Keys) {
                    'EndDate' {
                        $queryParams += "filter.endDate=$([uri]::EscapeDataString($EndDate.ToString('o')))"
                    }
                    'RuleActionStatus' {
                        $queryParams += "filter.ruleActionStatus=$([uri]::EscapeDataString($RuleActionStatus))"
                    }
                    'StartDate' {
                        $queryParams += "filter.startDate=$([uri]::EscapeDataString($StartDate.ToString('o')))"
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
                    Write-Warning 'Issue with Get-TssInboxRuleActionLog request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.records) {
                    [Thycotic.PowerShell.InboxRules.ActionLog[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.InboxRules.ActionLog]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
