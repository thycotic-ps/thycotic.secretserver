function Set-TssInboxRuleAction {
    <#
    .SYNOPSIS
    Update the actions of an inbox rule

    .DESCRIPTION
    Update the email and Slack actions of an inbox rule and the templates they use. Only the parameters provided are changed.
    The server rejects a change that leaves the rule without an action (400, Not a valid value).

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Inbox rule ID

    .PARAMETER SendEmail
    Send an email for each notification (-SendEmail) or stop sending email (-SendEmail:$false)

    .PARAMETER InboxEmailTemplateId
    Inbox template used for the email

    .PARAMETER SendSlack
    Send a Slack message for each notification (-SendSlack) or stop (-SendSlack:$false)

    .PARAMETER InboxSlackTemplateId
    Inbox template used for the Slack message

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssInboxRuleAction -TssSession $session -Id 7 -SendEmail -InboxEmailTemplateId 5

    Make inbox rule 7 send an email using inbox template 5

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/Set-TssInboxRuleAction

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/Set-TssInboxRuleAction.ps1

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
            $uri = $TssSession.ApiUrl, 'inbox-rules', $Id, 'actions' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'SendEmail' {
                    $body.data.Add('sendEmail', @{ dirty = $true; value = [boolean]$SendEmail })
                }
                'InboxEmailTemplateId' {
                    $body.data.Add('inboxEmailTemplateId', @{ dirty = $true; value = $InboxEmailTemplateId })
                }
                'SendSlack' {
                    $body.data.Add('sendSlack', @{ dirty = $true; value = [boolean]$SendSlack })
                }
                'InboxSlackTemplateId' {
                    $body.data.Add('inboxSlackTemplateId', @{ dirty = $true; value = $InboxSlackTemplateId })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Inbox rule: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssInboxRuleAction request'
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
