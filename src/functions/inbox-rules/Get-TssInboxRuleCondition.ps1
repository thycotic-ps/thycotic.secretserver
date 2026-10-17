function Get-TssInboxRuleCondition {
    <#
    .SYNOPSIS
    Get the conditions of an inbox rule

    .DESCRIPTION
    Get the conditions of an inbox rule (-InboxRuleId), or a single inbox rule condition by its own ID (-Id).
    When the server cannot list the conditions of a rule (HTTP 500), the cmdlet reads them from the rule itself.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER InboxRuleId
    Inbox rule ID: return all of its conditions

    .PARAMETER Id
    Inbox rule condition ID: return that condition

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssInboxRuleCondition -TssSession $session -InboxRuleId 7

    Return the conditions of inbox rule 7

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssInboxRuleCondition -TssSession $session -Id 3

    Return inbox rule condition 3

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/Get-TssInboxRuleCondition

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/Get-TssInboxRuleCondition.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'rule')]
    [OutputType('Thycotic.PowerShell.InboxRules.Condition')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'rule')]
        [int[]]
        $InboxRuleId,

        [Parameter(Mandatory, ParameterSetName = 'condition')]
        [Alias('InboxRuleConditionId')]
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
            switch ($PSCmdlet.ParameterSetName) {
                'rule' {
                    foreach ($currentId in $InboxRuleId) {
                        $restResponse = $null
                        $uri = $TssSession.ApiUrl, 'inbox-rules', $currentId, 'conditions' -join '/'
                        $invokeParams.Uri = $uri
                        $invokeParams.Method = 'GET'
                        Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                        try {
                            $apiResponse = Invoke-TssApi @invokeParams
                            $restResponse = . $ProcessResponse $apiResponse
                        } catch {
                            if ($tssLastResponse.StatusCode -eq 500) {
                                $uri = $TssSession.ApiUrl, 'inbox-rules', $currentId -join '/'
                                $invokeParams.Uri = $uri
                                Write-Verbose "Conditions route failed, performing the operation $($invokeParams.Method) $uri"
                                try {
                                    $apiResponse = Invoke-TssApi @invokeParams
                                    $restResponse = (. $ProcessResponse $apiResponse).conditions
                                } catch {
                                    Write-Warning 'Issue with Get-TssInboxRuleCondition request'
                                    $err = $_
                                    . $ErrorHandling $err
                                }
                            } else {
                                Write-Warning 'Issue with Get-TssInboxRuleCondition request'
                                $err = $_
                                . $ErrorHandling $err
                            }
                        }
                        foreach ($condition in @($restResponse)) {
                            if ($condition) {
                                $condition | Add-Member -NotePropertyName inboxRuleId -NotePropertyValue $currentId -Force
                                [Thycotic.PowerShell.InboxRules.Condition](. $FilterTssResponse $condition ([Thycotic.PowerShell.InboxRules.Condition]))
                            }
                        }
                    }
                }
                'condition' {
                    foreach ($currentId in $Id) {
                        $restResponse = $null
                        $uri = $TssSession.ApiUrl, 'inbox-rules', 'conditions', $currentId -join '/'
                        $invokeParams.Uri = $uri
                        $invokeParams.Method = 'GET'
                        Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                        try {
                            $apiResponse = Invoke-TssApi @invokeParams
                            $restResponse = . $ProcessResponse $apiResponse
                        } catch {
                            Write-Warning 'Issue with Get-TssInboxRuleCondition request'
                            $err = $_
                            . $ErrorHandling $err
                        }
                        if ($restResponse) {
                            [Thycotic.PowerShell.InboxRules.Condition](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.InboxRules.Condition]))
                        }
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
