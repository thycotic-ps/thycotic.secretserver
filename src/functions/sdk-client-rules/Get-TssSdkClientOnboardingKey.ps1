function Get-TssSdkClientOnboardingKey {
    <#
    .SYNOPSIS
    Get the onboarding key of an SDK client rule

    .DESCRIPTION
    Get the onboarding key that SDK clients must present to register against the rule.
    The output is credential material.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    SDK client rule ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $onboardingKey = Get-TssSdkClientOnboardingKey -TssSession $session -Id 3

    Stores the onboarding key of SDK client rule 3 in $onboardingKey

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/sdk-client-rules/Get-TssSdkClientOnboardingKey

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/sdk-client-rules/Get-TssSdkClientOnboardingKey.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('System.String')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
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
                $uri = $TssSession.ApiUrl, 'sdk-client-rules', $currentId, 'onboarding-key' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssSdkClientOnboardingKey request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($null -ne $restResponse) {
                    ConvertFrom-Json -InputObject $restResponse
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
