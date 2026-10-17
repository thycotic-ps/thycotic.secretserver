function Set-TssDiscoveryDependencyRuleOrder {
    <#
    .SYNOPSIS
    Set the order of the Discovery dependency rules

    .DESCRIPTION
    Sets the order in which Discovery applies its dependency rules. Pass every rule id in the new order.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER DiscoveryRuleDependencyIds
    Dependency rule ids in the new order. The server does not check that the ids exist

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssDiscoveryDependencyRuleOrder -TssSession $session -DiscoveryRuleDependencyIds 3, 1, 2

    Apply dependency rule 3 first, then 1, then 2

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Set-TssDiscoveryDependencyRuleOrder

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Set-TssDiscoveryDependencyRuleOrder.ps1

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
        [Alias('RuleId')]
        [int[]]
        $DiscoveryRuleDependencyIds
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'discovery', 'rules', 'dependencies', 'sort' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'DiscoveryRuleDependencyIds' {
                    $body.data.Add('discoveryRuleDependencyIds', $DiscoveryRuleDependencyIds)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Discovery dependency rule order", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssDiscoveryDependencyRuleOrder request'
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
