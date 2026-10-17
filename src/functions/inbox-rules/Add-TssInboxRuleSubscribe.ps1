function Add-TssInboxRuleSubscribe {
    <#
    .SYNOPSIS
    Subscribe the current user to an inbox rule

    .DESCRIPTION
    Subscribe the current user to an inbox rule, so the rule's notifications reach them. Subscribing twice is harmless.
    Returns True when the server reports success.
    Use Set-TssInboxRuleSubscriber to subscribe other users, groups or email addresses.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Inbox rule ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Add-TssInboxRuleSubscribe -TssSession $session -Id 7

    Subscribe the current user to inbox rule 7

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/Add-TssInboxRuleSubscribe

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/Add-TssInboxRuleSubscribe.ps1

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
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'inbox-rules', $Id, 'subscribe' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            if ($PSCmdlet.ShouldProcess("Inbox rule subscribe: $Id", "$($invokeParams.Method) $uri")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Add-TssInboxRuleSubscribe request'
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
