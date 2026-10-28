function Remove-TssInboxRuleSubscribe {
    <#
    .SYNOPSIS
    Unsubscribe the current user from inbox rules

    .DESCRIPTION
    Removes the calling user's own subscription to one or more inbox rules, so the user stops receiving the notifications those rules send.
    It only changes the subscription of the user the session belongs to. Use Search-TssInboxRuleSubscriber to see who else is subscribed.
    A user who receives a rule through a subscribed group gets an explicit unsubscribed entry for that rule.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Inbox rule ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssInboxRuleSubscribe -TssSession $session -Id 12

    Unsubscribe the current user from inbox rule 12

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssInboxRuleSubscribe -TssSession $session -Id 12, 14 -WhatIf

    Show which inbox rules would be unsubscribed without changing anything

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/Remove-TssInboxRuleSubscribe

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/Remove-TssInboxRuleSubscribe.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Common.Delete')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('InboxRuleId', 'RuleId')]
        [int[]]
        $Id
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
                $uri = $TssSession.ApiUrl, 'inbox-rules', $currentId, 'subscribe' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'DELETE'
                if ($PSCmdlet.ShouldProcess("Inbox rule subscribe: $currentId", "$($invokeParams.Method) $uri")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning 'Issue with Remove-TssInboxRuleSubscribe request'
                        $err = $_
                        . $ErrorHandling $err
                    }
                    if ($restResponse.success) {
                        [Thycotic.PowerShell.Common.Delete]@{
                            Id         = $currentId
                            ObjectType = 'InboxRuleSubscription'
                        }
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
