function New-TssSdkClientAccount {
    <#
    .SYNOPSIS
    Register a new SDK client account

    .DESCRIPTION
    Register a new SDK client account against an SDK client rule, as the SDK client does on init.
    The server appends the registration date and time to Name.
    The output carries the new ClientSecret: treat it as a credential.
    Initialize-TssSdkClient does the same through the SDK client tool and stores the result locally; this cmdlet only calls the REST API.
    The onboarding key is not shown in Verbose or WhatIf output.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER ClientId
    Client ID (GUID) to register, unique per SDK client account. A new GUID is used when omitted

    .PARAMETER Description
    Description of the SDK client account

    .PARAMETER Name
    Name of the SDK client account

    .PARAMETER OnboardingKey
    Onboarding key of the rule, required when the rule requires one

    .PARAMETER RuleName
    Name of the SDK client rule to register against

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssSdkClientAccount -TssSession $session -Name 'build-agent-01' -Description 'Build agent' -RuleName 'build-agents' -OnboardingKey $onboardingKey

    Registers SDK client account build-agent-01 against rule build-agents using the onboarding key in $onboardingKey

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/sdk-client-accounts/New-TssSdkClientAccount

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/sdk-client-accounts/New-TssSdkClientAccount.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.SdkClientAccounts.SdkClientAccount')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [guid]
        $ClientId,

        [Parameter(Mandatory)]
        [string]
        $Description,

        [Parameter(Mandatory)]
        [string]
        $Name,

        [string]
        $OnboardingKey,

        [Parameter(Mandatory)]
        [string]
        $RuleName
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'sdk-client-accounts' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{
                clientId = [guid]::NewGuid()
            }
            switch ($tssParams.Keys) {
                'ClientId' {
                    $body.clientId = $ClientId
                }
                'Description' {
                    $body.Add('description', $Description)
                }
                'Name' {
                    $body.Add('name', $Name)
                }
                'OnboardingKey' {
                    $body.Add('onboardingKey', $OnboardingKey)
                }
                'RuleName' {
                    $body.Add('ruleName', $RuleName)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Sdk client account: $Name", "$($invokeParams.Method) $uri")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssSdkClientAccount request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.SdkClientAccounts.SdkClientAccount](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SdkClientAccounts.SdkClientAccount]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
