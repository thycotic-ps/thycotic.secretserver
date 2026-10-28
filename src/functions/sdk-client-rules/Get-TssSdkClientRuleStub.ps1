function Get-TssSdkClientRuleStub {
    <#
    .SYNOPSIS
    Get the default values for a new SDK client rule

    .DESCRIPTION
    Get an SDK client rule object with the default values for a new rule.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSdkClientRuleStub -TssSession $session

    Returns the default values for a new SDK client rule

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/sdk-client-rules/Get-TssSdkClientRuleStub

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/sdk-client-rules/Get-TssSdkClientRuleStub.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SdkClientRules.SdkClientRule')]
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
            $uri = $TssSession.ApiUrl, 'sdk-client-rules', 'stub' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssSdkClientRuleStub request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.SdkClientRules.SdkClientRule](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SdkClientRules.SdkClientRule]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
