function New-TssInboxRule {
    <#
    .SYNOPSIS
    Create a new inbox rule

    .DESCRIPTION
    Create a new inbox (notification) rule for one or more inbox message types.
    The rule needs at least one action: -SendEmail (with an email template) or -SendSlack (with a Slack template).
    Add conditions afterwards with New-TssInboxRuleCondition.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Name
    Name of the inbox rule

    .PARAMETER InboxMessageTypeId
    Inbox message types the rule applies to (InboxMessageTypeId from Search-TssInboxMessageType)

    .PARAMETER Active
    Activate the inbox rule on creation

    .PARAMETER IsImmediate
    Send notifications as they happen instead of as a scheduled digest

    .PARAMETER HighPriority
    Mark the rule's notifications as high priority

    .PARAMETER CanEditOwnSubscription
    Let subscribers subscribe and unsubscribe themselves

    .PARAMETER SendEmail
    Send an email for each notification

    .PARAMETER InboxEmailTemplateId
    Inbox template used for the email

    .PARAMETER SendSlack
    Send a Slack message for each notification

    .PARAMETER InboxSlackTemplateId
    Inbox template used for the Slack message

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssInboxRule -TssSession $session -Name 'Password reset alerts' -InboxMessageTypeId 4 -Active -IsImmediate -CanEditOwnSubscription -SendEmail -InboxEmailTemplateId 5

    Create an active rule that emails each Password Reset message as it happens

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/New-TssInboxRule

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/New-TssInboxRule.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.InboxRules.InboxRule')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [string]
        $Name,

        [Parameter(Mandatory)]
        [int[]]
        $InboxMessageTypeId,

        [switch]
        $Active,

        [switch]
        $IsImmediate,

        [switch]
        $HighPriority,

        [switch]
        $CanEditOwnSubscription,

        [switch]
        $SendEmail,

        [int]
        $InboxEmailTemplateId,

        [switch]
        $SendSlack,

        [int]
        $InboxSlackTemplateId
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
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{
                data = @{
                    name                   = $Name
                    inboxMessageTypeIds    = @($InboxMessageTypeId)
                    active                 = [boolean]$Active
                    isImmediate            = [boolean]$IsImmediate
                    highPriority           = [boolean]$HighPriority
                    canEditOwnSubscription = [boolean]$CanEditOwnSubscription
                    sendEmail              = [boolean]$SendEmail
                    sendSlack              = [boolean]$SendSlack
                    conditions             = @()
                }
            }
            switch ($tssParams.Keys) {
                'InboxEmailTemplateId' {
                    $body.data.Add('inboxEmailTemplateId', $InboxEmailTemplateId)
                }
                'InboxSlackTemplateId' {
                    $body.data.Add('inboxSlackTemplateId', $InboxSlackTemplateId)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Inbox rule: $Name", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssInboxRule request'
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
