function Set-TssDiscoveryAccountRuleOrder {
    <#
    .SYNOPSIS
    Set the evaluation order of Discovery account rules

    .DESCRIPTION
    Sets the order in which Discovery account rules are evaluated. Pass every rule id in the new order, inactive rules included: Search-TssDiscoveryAccountRule -Status All lists them all.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER RuleId
    Discovery account rule ids in the new evaluation order

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssDiscoveryAccountRuleOrder -TssSession $session -RuleId 4, 3, 7

    Evaluate Discovery account rule 4 first, then 3, then 7

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $ids = @((Search-TssDiscoveryAccountRule -TssSession $session -Status All | Sort-Object SortOrder).RuleId)
    [array]::Reverse($ids)
    Set-TssDiscoveryAccountRuleOrder -TssSession $session -RuleId $ids

    Reverse the evaluation order of every Discovery account rule

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Set-TssDiscoveryAccountRuleOrder

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Set-TssDiscoveryAccountRuleOrder.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Discovery.OperationResult')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [int[]]
        $RuleId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'discovery', 'rules', 'accounts', 'sort' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'RuleId' {
                    $body.data.Add('discoveryRuleAccountIds', $RuleId)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Discovery account rule order", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssDiscoveryAccountRuleOrder request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Discovery.OperationResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Discovery.OperationResult]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
