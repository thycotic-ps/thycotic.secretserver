function Set-TssSdkClientEnabled {
    <#
    .SYNOPSIS
    Enable or disable SDK client accounts

    .DESCRIPTION
    Enable or disable the SDK client accounts feature. Returns the new state.
    The API toggles the state, so the current state is read first and no request is sent when it already matches Enabled.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Enabled
    True to enable SDK client accounts, false to disable them

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSdkClientEnabled -TssSession $session -Enabled $true

    Enables SDK client accounts

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSdkClientEnabled -TssSession $session -Enabled $false

    Disables SDK client accounts

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/sdk-client-accounts/Set-TssSdkClientEnabled

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/sdk-client-accounts/Set-TssSdkClientEnabled.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('System.Boolean')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [bool]
        $Enabled
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $currentState = Get-TssSdkClientEnabled -TssSession $TssSession
            if ($null -eq $currentState) {
                return
            }
            if ($currentState -eq $Enabled) {
                Write-Verbose "SDK client accounts enabled is already $Enabled, no request sent"
                return $currentState
            }
            $uri = $TssSession.ApiUrl, 'sdk-client-accounts', 'enabled' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            if ($PSCmdlet.ShouldProcess("SDK client accounts enabled: $Enabled", "$($invokeParams.Method) $uri")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssSdkClientEnabled request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($null -ne $restResponse) {
                    [System.Convert]::ToBoolean($restResponse)
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
