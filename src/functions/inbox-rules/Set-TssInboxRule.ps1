function Set-TssInboxRule {
    <#
    .SYNOPSIS
    Update an inbox rule

    .DESCRIPTION
    Update the name, state, timing and message types of an inbox rule. Only the parameters provided are changed.
    Use Set-TssInboxRuleAction for the email and Slack actions and Update-TssInboxRuleCondition for the conditions.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Inbox rule ID

    .PARAMETER Name
    New name of the inbox rule

    .PARAMETER Active
    Activate (-Active) or deactivate (-Active:$false) the inbox rule

    .PARAMETER IsImmediate
    Send notifications as they happen (-IsImmediate) or as a scheduled digest (-IsImmediate:$false)

    .PARAMETER HighPriority
    Mark the rule's notifications as high priority, or not with -HighPriority:$false

    .PARAMETER CanEditOwnSubscription
    Let subscribers subscribe and unsubscribe themselves, or not with -CanEditOwnSubscription:$false

    .PARAMETER InboxMessageTypeId
    Replacement list of inbox message types the rule applies to

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssInboxRule -TssSession $session -Id 7 -Name 'Password reset alerts (ops)' -HighPriority

    Rename inbox rule 7 and mark its notifications as high priority

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssInboxRule -TssSession $session -Id 7 -Active:$false

    Deactivate inbox rule 7

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/Set-TssInboxRule

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/Set-TssInboxRule.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.InboxRules.InboxRule')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('InboxRuleId')]
        [int]
        $Id,

        [string]
        $Name,

        [switch]
        $Active,

        [switch]
        $IsImmediate,

        [switch]
        $HighPriority,

        [switch]
        $CanEditOwnSubscription,

        [int[]]
        $InboxMessageTypeId
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
            $uri = $TssSession.ApiUrl, 'inbox-rules', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Name' {
                    $body.data.Add('name', @{ dirty = $true; value = $Name })
                }
                'Active' {
                    $body.data.Add('active', @{ dirty = $true; value = [boolean]$Active })
                }
                'IsImmediate' {
                    $body.data.Add('isImmediate', @{ dirty = $true; value = [boolean]$IsImmediate })
                }
                'HighPriority' {
                    $body.data.Add('highPriority', @{ dirty = $true; value = [boolean]$HighPriority })
                }
                'CanEditOwnSubscription' {
                    $body.data.Add('canEditOwnSubscription', @{ dirty = $true; value = [boolean]$CanEditOwnSubscription })
                }
                'InboxMessageTypeId' {
                    $body.data.Add('inboxMessageTypes', @{ dirty = $true; value = @($InboxMessageTypeId) })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Inbox rule: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssInboxRule request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.InboxRules.InboxRule](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.InboxRules.InboxRule]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
