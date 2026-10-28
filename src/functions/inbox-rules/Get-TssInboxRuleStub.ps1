function Get-TssInboxRuleStub {
    <#
    .SYNOPSIS
    Get the default values for a new inbox rule

    .DESCRIPTION
    Get the default values Secret Server uses for a new inbox rule.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssInboxRuleStub -TssSession $session

    Return the default values of a new inbox rule

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/Get-TssInboxRuleStub

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/Get-TssInboxRuleStub.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.InboxRules.InboxRule')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'inbox-rules', 'stub' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssInboxRuleStub request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.InboxRules.InboxRule](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.InboxRules.InboxRule]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
