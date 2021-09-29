function Disable-TssSecretCheckout {
    <#
    .SYNOPSIS
    Disables the Checkout setting for a Secret

    .DESCRIPTION
    Disables the Checkout setting for a Secret

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Disable-TssSecretCheckout -TssSession $session -Id 28

    Disable Secret 28's Checkout When Viewed setting

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Disable-TssSecretCheckout -TssSession $session -Id 42,43,45

    Disable Checkout When Viewed setting on Secret IDs 42, 43, and 45

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Disable-TssSecretCheckout

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Disable-TssSecretCheckout.ps1

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
                        checkOutEnabled = $false
                    }
                }
                $invokeParams.Method = 'PATCH'
                $invokeParams.Body = $CheckoutBody | ConvertTo-Json

                if ($PSCmdlet.ShouldProcess("SecretId: $secret", 'Pre-check out secret for setting Checkout settings')) {
                    $writeViewParams = @{
                        TssSession     = $TssSession
                        Id             = $secret
                        Comment        = $Comment
                        TicketNumber   = $TicketNumber
                        TicketSystemId = $TicketSystemId
                    }
                    Write-TssSecretAccessRequestViewComment @writeViewParams

                    $checkoutParams = @{
                        TssSession     = $TssSession
                        Id             = $secret
                        Comment        = $Comment
                        TicketNumber   = $TicketNumber
                        TicketSystemId = $TicketSystemId
                    }
                    Open-TssSecret @checkoutParams
                }

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

                    if (-not $restResponse.checkOutEnabled.value) {
                        Write-Verbose "Secret [$secret] Checkout disabled"
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}