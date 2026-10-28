function Search-TssInboxRuleSubscriber {
    <#
    .SYNOPSIS
    Search the subscribers of an inbox rule

    .DESCRIPTION
    Lists the users, groups and external email addresses subscribed to an inbox rule, including entries that were unsubscribed.
    Filter by account type or subscription status. -OnlyIncludeUnsubscribableUsers lists the users who receive the rule through a subscribed group instead, and -SearchText narrows that list by name.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Inbox rule ID

    .PARAMETER AccountType
    Only return subscribers of this account type: All, Groups, Users or ExternalEmails

    .PARAMETER OnlyIncludeUnsubscribableUsers
    Only return users who receive the rule through a subscribed group

    .PARAMETER SearchText
    Only return users whose name contains this text. The server applies it only together with -OnlyIncludeUnsubscribableUsers

    .PARAMETER Status
    Only return subscribers with this subscription status: All, Subscribed or Unsubscribed

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssInboxRuleSubscriber -TssSession $session -Id 12

    List every subscriber of inbox rule 12

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssInboxRuleSubscriber -TssSession $session -Id 12 -AccountType Groups -Status Subscribed

    List the groups subscribed to inbox rule 12

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/Search-TssInboxRuleSubscriber

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/Search-TssInboxRuleSubscriber.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.InboxRules.Subscriber[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('InboxRuleId')]
        [int[]]
        $Id,

        [ValidateSet('All', 'Groups', 'Users', 'ExternalEmails')]
        [string]
        $AccountType,

        [switch]
        $OnlyIncludeUnsubscribableUsers,

        [string]
        $SearchText,

        [ValidateSet('All', 'Subscribed', 'Unsubscribed')]
        [string]
        $Status
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
                $uri = $TssSession.ApiUrl, 'inbox-rules', $currentId, 'subscribers' -join '/'
                $queryParams = @()
                $queryParams += "take=$($TssSession.Take)"
                switch ($tssParams.Keys) {
                    'AccountType' {
                        $queryParams += "filter.accountTypes=$([uri]::EscapeDataString($AccountType))"
                    }
                    'OnlyIncludeUnsubscribableUsers' {
                        $queryParams += "filter.onlyIncludeUnsubscribableUsers=$([boolean]$OnlyIncludeUnsubscribableUsers)"
                    }
                    'SearchText' {
                        $queryParams += "filter.searchText=$([uri]::EscapeDataString($SearchText))"
                    }
                    'Status' {
                        $queryParams += "filter.status=$([uri]::EscapeDataString($Status))"
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
                    Write-Warning 'Issue with Search-TssInboxRuleSubscriber request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.records) {
                    [Thycotic.PowerShell.InboxRules.Subscriber[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.InboxRules.Subscriber]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
