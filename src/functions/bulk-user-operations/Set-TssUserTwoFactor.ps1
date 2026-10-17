function Set-TssUserTwoFactor {
    <#
    .SYNOPSIS
    Enable, disable, or reset a two-factor method for users in bulk

    .DESCRIPTION
    Enable, disable, or reset one two-factor authentication method (email, RADIUS, TOTP, Duo, FIDO2) for one or more users in one bulk operation.
    Reset applies to TOTP and FIDO2 only and clears the user's registration for that method.
    The operation runs in the background: pipe the output (BulkOperationId is the task identifier) to Get-TssBulkOperationProgress to follow it.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    IDs of the users to change

    .PARAMETER Action
    Two-factor change to make: EnableEmail, DisableEmail, EnableRadius, DisableRadius, EnableTotp, DisableTotp, ResetTotp, EnableDuo, DisableDuo, EnableFido2, DisableFido2, ResetFido2

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssUserTwoFactor -TssSession $session -Id 12, 13 -Action EnableEmail

    Turn on email two-factor for users 12 and 13

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssUserTwoFactor -TssSession $session -Id 12 -Action ResetTotp

    Reset TOTP for user 12 so the user registers a new authenticator

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/bulk-user-operations/Set-TssUserTwoFactor

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/bulk-user-operations/Set-TssUserTwoFactor.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.BulkOperations.Response')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [Alias('UserId')]
        [int[]]
        $Id,

        [Parameter(Mandatory)]
        [ValidateSet('EnableEmail', 'DisableEmail', 'EnableRadius', 'DisableRadius', 'EnableTotp', 'DisableTotp', 'ResetTotp', 'EnableDuo', 'DisableDuo', 'EnableFido2', 'DisableFido2', 'ResetFido2')]
        [string]
        $Action
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '11.2.000004' $PSCmdlet.MyInvocation
            switch ($Action) {
                'EnableEmail' {
                    $uri = $TssSession.ApiUrl, 'bulk-user-operations', 'enable-email-two-factor' -join '/'
                }
                'DisableEmail' {
                    $uri = $TssSession.ApiUrl, 'bulk-user-operations', 'disable-email-two-factor' -join '/'
                }
                'EnableRadius' {
                    $uri = $TssSession.ApiUrl, 'bulk-user-operations', 'enable-radius-two-factor' -join '/'
                }
                'DisableRadius' {
                    $uri = $TssSession.ApiUrl, 'bulk-user-operations', 'disable-radius-two-factor' -join '/'
                }
                'EnableTotp' {
                    $uri = $TssSession.ApiUrl, 'bulk-user-operations', 'enable-totp-auth' -join '/'
                }
                'DisableTotp' {
                    $uri = $TssSession.ApiUrl, 'bulk-user-operations', 'disable-totp-auth' -join '/'
                }
                'ResetTotp' {
                    $uri = $TssSession.ApiUrl, 'bulk-user-operations', 'reset-totp-auth' -join '/'
                }
                'EnableDuo' {
                    $uri = $TssSession.ApiUrl, 'bulk-user-operations', 'enable-duo-auth' -join '/'
                }
                'DisableDuo' {
                    $uri = $TssSession.ApiUrl, 'bulk-user-operations', 'disable-duo-auth' -join '/'
                }
                'EnableFido2' {
                    $uri = $TssSession.ApiUrl, 'bulk-user-operations', 'enable-fido2-two-factor' -join '/'
                }
                'DisableFido2' {
                    $uri = $TssSession.ApiUrl, 'bulk-user-operations', 'disable-fido2-two-factor' -join '/'
                }
                'ResetFido2' {
                    $uri = $TssSession.ApiUrl, 'bulk-user-operations', 'reset-fido2-two-factor' -join '/'
                }
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ userIds = $Id } }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("User IDs: $($Id -join ', ')", "$Action with $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssUserTwoFactor request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.BulkOperations.Response](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.BulkOperations.Response]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
