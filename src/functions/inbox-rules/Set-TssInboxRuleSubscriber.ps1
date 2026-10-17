function Set-TssInboxRuleSubscriber {
    <#
    .SYNOPSIS
    Subscribe or unsubscribe users, groups and email addresses to an inbox rule

    .DESCRIPTION
    Subscribe users, groups and external email addresses to an inbox rule in one call, or unsubscribe them with -Unsubscribe.
    Subscribers not named are left unchanged. Use Add-TssInboxRuleSubscribe to subscribe the current user.
    Returns True when the server reports success.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Inbox rule ID

    .PARAMETER UserId
    User IDs to subscribe or unsubscribe

    .PARAMETER GroupId
    Group IDs to subscribe or unsubscribe

    .PARAMETER EmailAddress
    External email addresses to subscribe or unsubscribe

    .PARAMETER Unsubscribe
    Unsubscribe the named users, groups and email addresses instead of subscribing them

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssInboxRuleSubscriber -TssSession $session -Id 7 -GroupId 5 -EmailAddress 'oncall@example.com'

    Subscribe group 5 and an external email address to inbox rule 7

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssInboxRuleSubscriber -TssSession $session -Id 7 -UserId 17 -Unsubscribe

    Unsubscribe user 17 from inbox rule 7

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/Set-TssInboxRuleSubscriber

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/Set-TssInboxRuleSubscriber.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('System.Boolean')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('InboxRuleId', 'RuleId')]
        [int]
        $Id,

        [int[]]
        $UserId,

        [int[]]
        $GroupId,

        [string[]]
        $EmailAddress,

        [switch]
        $Unsubscribe
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
            $subscribe = -not $Unsubscribe
            $uri = $TssSession.ApiUrl, 'inbox-rules', $Id, 'subscribers' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $groupUserUpdates = @()
            $groupUserUpdates += foreach ($currentUserId in $UserId) {
                @{ userId = $currentUserId; subscribe = $subscribe }
            }
            $groupUserUpdates += foreach ($currentGroupId in $GroupId) {
                @{ groupId = $currentGroupId; subscribe = $subscribe }
            }
            $emailUpdates = @()
            $emailUpdates += foreach ($currentEmail in $EmailAddress) {
                @{ emailAddress = $currentEmail; subscribe = $subscribe }
            }
            $body = @{
                data = @{
                    groupUserUpdates = $groupUserUpdates
                    emailUpdates     = $emailUpdates
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Inbox rule: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssInboxRuleSubscriber request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [System.Convert]::ToBoolean($restResponse.success)
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
