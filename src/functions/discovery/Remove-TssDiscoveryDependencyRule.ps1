function Remove-TssDiscoveryDependencyRule {
    <#
    .SYNOPSIS
    Remove a Discovery dependency rule

    .DESCRIPTION
    Removes one or more Discovery dependency rules by id. The server deactivates the rule: it stays listed by Search-TssDiscoveryDependencyRule -StatusFilter All. An unknown id also returns Success.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Dependency rule id

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssDiscoveryDependencyRule -TssSession $session -Id 4

    Delete dependency rule 4

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Remove-TssDiscoveryDependencyRule

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Remove-TssDiscoveryDependencyRule.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Discovery.OperationResult')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('RuleId')]
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
                $uri = $TssSession.ApiUrl, 'discovery', 'rules', 'dependencies', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'DELETE'
                if ($PSCmdlet.ShouldProcess("Discovery dependency rule: $currentId", "$($invokeParams.Method) $uri")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning 'Issue with Remove-TssDiscoveryDependencyRule request'
                        $err = $_
                        . $ErrorHandling $err
                    }
                    if ($restResponse) {
                        [Thycotic.PowerShell.Discovery.OperationResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Discovery.OperationResult]))
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
