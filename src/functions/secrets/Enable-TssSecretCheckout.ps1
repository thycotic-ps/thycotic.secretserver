function Enable-TssSecretCheckout {
    <#
    .SYNOPSIS
    Enables the Checkout setting for a Secret

    .DESCRIPTION
    Enables the Checkout setting for a Secret

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Enable-TssSecretCheckout -TssSession $session -Id 28

    Enable Secret 28's Checkout When Viewed setting

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Enable-TssSecretCheckout -TssSession $session -Id 42,43,45

    Enable Checkout When Viewed setting on Secret IDs 42, 43, and 45

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Enable-TssSecretCheckout

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Enable-TssSecretCheckout.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Secret Id
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretId')]
        [int[]]
        $Id,

        # Change password on Check In
        [switch]
        $ChangePasswordOnCheckIn,

        # Checkout intervale in Minutes
        [ValidateRange(0, 43200)]
        [int]
        $Interval,

        # Comment to provide for restricted secret (Require Comment is enabled)
        [Parameter(ParameterSetName = 'restricted')]
        [string]
        $Comment,

        # Associated Ticket Number
        [Parameter(ParameterSetName = 'restricted')]
        [int]
        $TicketNumber,

        #Associated Ticket System ID
        [Parameter(ParameterSetName = 'restricted')]
        [int]
        $TicketSystemId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession

        $restrictedParamSet = . $ParameterSetParams $PSCmdlet.MyInvocation.MyCommand.Name 'restricted'
        $restrictedParams = @()
        foreach ($r in $restrictedParamSet) {
            if ($tssParams.ContainsKey($r)) {
                $restrictedParams += $r
            }
        }
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($secret in $Id) {
                $uri = $TssSession.ApiUrl, 'secrets', $secret, 'security-checkout' -join '/'
                $invokeParams.Uri = $uri

                # data object for Checkout Settings
                $CheckoutBody = @{
                    data = @{
                        checkOutEnabled = $true
                    }
                }
                if ($tssParams.ContainsKey('Interval')) {
                    $intervalMinutes = @{
                        dirty = $true
                        value = $Interval
                    }
                    $CheckoutBody.data.Add('checkOutIntervalMinutes', $intervalMinutes)
                }
                if ($tssParams.ContainsKey('ChangePasswordOnCheckIn')) {
                    $intervalMinutes = @{
                        dirty = $true
                        value = $true
                    }
                    $CheckoutBody.data.Add('checkOutChangePasswordEnabled', $intervalMinutes)
                }
                $invokeParams.Method = 'PATCH'
                $invokeParams.Body = $CheckoutBody | ConvertTo-Json

                if ($PSCmdlet.ShouldProcess("SecretId: $secret", "$($invokeParams.Method) $($invokeParams.Uri) with:`n$($invokeParams.Body)`n")) {
                    Write-Verbose "$($invokeParams.Method) $($invokeParams.Uri) with:`n$($invokeParams.Body)`n"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue configuring [$secret] Checkout settings"
                        $err = $_
                        . $ErrorHandling $err
                    }

                    if ($restResponse.checkOutEnabled.value) {
                        Write-Verbose "Secret [$secret] Checkout enabled"
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}