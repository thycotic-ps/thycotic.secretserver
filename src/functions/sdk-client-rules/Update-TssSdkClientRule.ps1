function Update-TssSdkClientRule {
    <#
    .SYNOPSIS
    Update an SDK client rule

    .DESCRIPTION
    Update the name, IP address restriction (Details), user or onboarding key requirement of an SDK client rule.
    The current rule is read first, so parameters not given keep their value.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    SDK client rule ID

    .PARAMETER Details
    IP address range or CIDR that SDK clients must register from, for example 10.20.0.0/16. Empty allows any address

    .PARAMETER Name
    New name of the SDK client rule

    .PARAMETER RequireOnboardingKey
    Require an onboarding key to register against the rule

    .PARAMETER UserId
    ID of the user SDK client accounts on this rule run as

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssSdkClientRule -TssSession $session -Id 3 -RequireOnboardingKey:$false

    Stops requiring an onboarding key on SDK client rule 3

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/sdk-client-rules/Update-TssSdkClientRule

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/sdk-client-rules/Update-TssSdkClientRule.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.SdkClientRules.SdkClientRule')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $Id,

        [string]
        $Details,

        [string]
        $Name,

        [switch]
        $RequireOnboardingKey,

        [int]
        $UserId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $currentRule = Get-TssSdkClientRule -TssSession $TssSession -Id $Id
            if (-not $currentRule) {
                return
            }
            $uri = $TssSession.ApiUrl, 'sdk-client-rules', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $body = @{
                details              = $currentRule.Details
                name                 = $currentRule.Name
                requireOnboardingKey = $currentRule.RequireOnboardingKey
                userId               = $currentRule.UserId
            }
            switch ($tssParams.Keys) {
                'Details' {
                    $body.details = $Details
                }
                'Name' {
                    $body.name = $Name
                }
                'RequireOnboardingKey' {
                    $body.requireOnboardingKey = [boolean]$RequireOnboardingKey
                }
                'UserId' {
                    $body.userId = $UserId
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Sdk client rule: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssSdkClientRule request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.SdkClientRules.SdkClientRule](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SdkClientRules.SdkClientRule]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
