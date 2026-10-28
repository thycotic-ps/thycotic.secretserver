function Update-TssInboxRuleCondition {
    <#
    .SYNOPSIS
    Replace the conditions of an inbox rule

    .DESCRIPTION
    Replace the whole condition list of an inbox rule. Conditions left out of the list are removed from the rule.
    Pipe the output of Get-TssInboxRuleCondition, changed as needed, to write the list back.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER InboxRuleId
    Inbox rule ID

    .PARAMETER Condition
    The full condition list, as Get-TssInboxRuleCondition output or hashtables with these keys: InboxDataId, InboxRuleOperand (Equals, NotEquals, LessThan, GreaterThan, Regex), one of ValueString, ValueInt, ValueBool, ValueDateTime, optional DisplayValue, and InboxRuleConditionId to keep an existing condition

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $conditions = Get-TssInboxRuleCondition -TssSession $session -InboxRuleId 7 | Where-Object ValueString -ne 'Test'
    Update-TssInboxRuleCondition -TssSession $session -InboxRuleId 7 -Condition $conditions

    Remove the conditions of inbox rule 7 that compare against Test

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssInboxRuleCondition -TssSession $session -InboxRuleId 7 -Condition @{ InboxDataId = 2; InboxRuleOperand = 'Regex'; ValueString = '^Prod' }

    Replace the conditions of inbox rule 7 with one regular expression condition

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/Update-TssInboxRuleCondition

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/Update-TssInboxRuleCondition.ps1

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
        [int]
        $InboxRuleId,

        [Parameter(Mandatory)]
        [AllowEmptyCollection()]
        [object[]]
        $Condition
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
            $uri = $TssSession.ApiUrl, 'inbox-rules', $InboxRuleId, 'conditions' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $wireNames = 'inboxRuleConditionId', 'inboxDataId', 'inboxRuleOperand', 'valueString', 'valueInt', 'valueBool', 'valueDateTime', 'displayValue'
            $conditionList = foreach ($item in $Condition) {
                $source = [pscustomobject]$item
                $wireCondition = @{ }
                foreach ($wireName in $wireNames) {
                    $sourceProperty = $source.PSObject.Properties[$wireName]
                    if ($sourceProperty -and $null -ne $sourceProperty.Value) {
                        $value = $sourceProperty.Value
                        if ($value -is [datetime]) {
                            $value = $value.ToString('o')
                        }
                        $wireCondition[$wireName] = $value
                    }
                }
                $wireCondition
            }
            $invokeParams.Body = ConvertTo-Json -InputObject @{ data = @($conditionList) } -Depth 100
            if ($PSCmdlet.ShouldProcess("Inbox rule: $InboxRuleId", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssInboxRuleCondition request'
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
