function Remove-TssSdkClientRule {
    <#
    .SYNOPSIS
    Delete an SDK client rule

    .DESCRIPTION
    Delete one or more SDK client rules by ID. RevokeAccounts also revokes the SDK client accounts registered through the rule.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    SDK client rule ID

    .PARAMETER RevokeAccounts
    Also revoke the SDK client accounts registered through the rule

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssSdkClientRule -TssSession $session -Id 3 -RevokeAccounts

    Deletes SDK client rule 3 and revokes its SDK client accounts

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/sdk-client-rules/Remove-TssSdkClientRule

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/sdk-client-rules/Remove-TssSdkClientRule.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Common.Delete')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int[]]
        $Id,

        [switch]
        $RevokeAccounts
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
                $uri = $TssSession.ApiUrl, 'sdk-client-rules', $currentId -join '/'
                $queryParams = @()
                switch ($tssParams.Keys) {
                    'RevokeAccounts' {
                        $queryParams += "revokeAccounts=$([boolean]$RevokeAccounts)"
                    }
                }
                if ($queryParams) {
                    $uri = $uri, ($queryParams -join '&') -join '?'
                }
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'DELETE'
                if ($PSCmdlet.ShouldProcess("Sdk client rule: $currentId", "$($invokeParams.Method) $uri")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning 'Issue with Remove-TssSdkClientRule request'
                        $err = $_
                        . $ErrorHandling $err
                    }
                    if ($restResponse) {
                        [Thycotic.PowerShell.Common.Delete](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Common.Delete]))
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
