function Search-TssInboxRule {
    <#
    .SYNOPSIS
    Search inbox rules

    .DESCRIPTION
    Search inbox (notification) rules. Returns the ID, name, state and notification types of each; use Get-TssInboxRule for the full rule.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER IncludeInactive
    Include inactive inbox rules

    .PARAMETER IncludeCurrentUserSubscriptionStatus
    Set CurrentUserSubscribed on each rule

    .PARAMETER IsImmediate
    Return only immediate rules (-IsImmediate) or only digest rules (-IsImmediate:$false)

    .PARAMETER MessageTypeId
    Return only the rules that apply to this inbox message type

    .PARAMETER MessageId
    Return only the rules that apply to this inbox message

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssInboxRule -TssSession $session -IncludeInactive -IncludeCurrentUserSubscriptionStatus

    Return every inbox rule and whether the current user is subscribed to it

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssInboxRule -TssSession $session -MessageTypeId 4

    Return the active inbox rules that apply to inbox message type 4

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/Search-TssInboxRule

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/Search-TssInboxRule.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.InboxRules.InboxRuleItem[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $IncludeInactive,

        [switch]
        $IncludeCurrentUserSubscriptionStatus,

        [switch]
        $IsImmediate,

        [int]
        $MessageTypeId,

        [int]
        $MessageId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'inbox-rules' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'IncludeInactive' {
                    $queryParams += "filter.includeInactive=$([boolean]$IncludeInactive)"
                }
                'IncludeCurrentUserSubscriptionStatus' {
                    $queryParams += "filter.includeCurrentUserSubscriptionStatus=$([boolean]$IncludeCurrentUserSubscriptionStatus)"
                }
                'IsImmediate' {
                    $queryParams += "filter.isImmediate=$([boolean]$IsImmediate)"
                }
                'MessageTypeId' {
                    $queryParams += "filter.messageTypeId=$MessageTypeId"
                }
                'MessageId' {
                    $queryParams += "filter.messageId=$MessageId"
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
                Write-Warning 'Issue with Search-TssInboxRule request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.InboxRules.InboxRuleItem[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.InboxRules.InboxRuleItem]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
