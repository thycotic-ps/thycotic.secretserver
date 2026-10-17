function New-TssInboxRuleCondition {
    <#
    .SYNOPSIS
    Add a condition to an inbox rule

    .DESCRIPTION
    Add a condition to an inbox rule: the rule then only fires for messages whose data value (InboxDataId) compares true against the given value.
    Set the value parameter that matches the data type (ValueString, ValueInt, ValueBool or ValueDateTime).

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER InboxRuleId
    Inbox rule ID

    .PARAMETER InboxDataId
    Inbox data ID the condition tests (InboxDataId from Search-TssInboxDataName)

    .PARAMETER Operand
    Comparison operator (default Equals)

    .PARAMETER ValueString
    String value to compare with

    .PARAMETER ValueInt
    Integer value to compare with

    .PARAMETER ValueBool
    Boolean value to compare with

    .PARAMETER ValueDateTime
    Date value to compare with

    .PARAMETER DisplayValue
    Display text of the value

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssInboxRuleCondition -TssSession $session -InboxRuleId 7 -InboxDataId 2 -Operand Equals -ValueString 'Production' -DisplayValue 'Production'

    Make inbox rule 7 fire only for messages whose data value 2 equals Production

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox-rules/New-TssInboxRuleCondition

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox-rules/New-TssInboxRuleCondition.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.InboxRules.Condition')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $InboxRuleId,

        [Parameter(Mandatory)]
        [int]
        $InboxDataId,

        [ValidateSet('Equals', 'NotEquals', 'LessThan', 'GreaterThan', 'Regex')]
        [string]
        $Operand = 'Equals',

        [string]
        $ValueString,

        [int]
        $ValueInt,

        [boolean]
        $ValueBool,

        [datetime]
        $ValueDateTime,

        [string]
        $DisplayValue
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
            $invokeParams.Method = 'POST'
            $body = @{
                data = @{
                    inboxRuleId      = $InboxRuleId
                    inboxDataId      = $InboxDataId
                    inboxRuleOperand = $Operand
                }
            }
            switch ($tssParams.Keys) {
                'ValueString' {
                    $body.data.Add('valueString', $ValueString)
                }
                'ValueInt' {
                    $body.data.Add('valueInt', $ValueInt)
                }
                'ValueBool' {
                    $body.data.Add('valueBool', $ValueBool)
                }
                'ValueDateTime' {
                    $body.data.Add('valueDateTime', $ValueDateTime.ToString('o'))
                }
                'DisplayValue' {
                    $body.data.Add('displayValue', $DisplayValue)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Inbox rule: $InboxRuleId", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssInboxRuleCondition request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.InboxRules.Condition](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.InboxRules.Condition]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
