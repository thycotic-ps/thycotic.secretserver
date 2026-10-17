function Copy-TssInboxRule {
    <#
    .SYNOPSIS
    Copy an inbox rule

    .DESCRIPTION
    Copy an inbox rule, with its message types, conditions and actions, to a new rule with the given name.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    ID of the inbox rule to copy

    .PARAMETER Name
    Name of the new inbox rule

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Copy-TssInboxRule -TssSession $session -Id 1 -Name 'Password Reset (copy)'

    Copy inbox rule 1 to a new rule named Password Reset (copy)

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/Copy-TssInboxRule

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/Copy-TssInboxRule.ps1

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

        [Parameter(Mandatory)]
        [string]
        $Name
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
            $uri = $TssSession.ApiUrl, 'inbox-rules', 'copy' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{
                data = @{
                    inboxRuleIdToCopy = $Id
                    name              = $Name
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Inbox rule: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Copy-TssInboxRule request'
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
