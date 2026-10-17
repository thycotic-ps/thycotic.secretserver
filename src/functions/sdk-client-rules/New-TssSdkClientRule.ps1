function New-TssSdkClientRule {
    <#
    .SYNOPSIS
    Create a new SDK client rule

    .DESCRIPTION
    Create a new SDK client rule. SDK clients register against a rule by name and run as the rule user.
    Details restricts the addresses SDK clients may register from.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Details
    IP address range or CIDR that SDK clients must register from, for example 10.20.0.0/16. Empty allows any address

    .PARAMETER Name
    Name of the SDK client rule

    .PARAMETER RequireOnboardingKey
    Require an onboarding key to register against the rule

    .PARAMETER UserId
    ID of the user SDK client accounts on this rule run as

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssSdkClientRule -TssSession $session -Name 'build-agents' -Details '10.20.0.0/16' -UserId 12 -RequireOnboardingKey

    Creates rule build-agents for clients in 10.20.0.0/16 that run as user 12 and need an onboarding key

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/sdk-client-rules/New-TssSdkClientRule

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/sdk-client-rules/New-TssSdkClientRule.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.SdkClientRules.SdkClientRule')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [string]
        $Details,

        [Parameter(Mandatory)]
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
            $uri = $TssSession.ApiUrl, 'sdk-client-rules' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ }
            switch ($tssParams.Keys) {
                'Details' {
                    $body.Add('details', $Details)
                }
                'Name' {
                    $body.Add('name', $Name)
                }
                'RequireOnboardingKey' {
                    $body.Add('requireOnboardingKey', [boolean]$RequireOnboardingKey)
                }
                'UserId' {
                    $body.Add('userId', $UserId)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Sdk client rule", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssSdkClientRule request'
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
