function Confirm-TssManualUpgradeStaging {
    <#
    .SYNOPSIS
    Record that the staging test of a manual upgrade passed

    .DESCRIPTION
    Records the staging test step of the manual (multi-step) upgrade: the operator confirmed the staged upgrade works before it is promoted.
    Each call writes an audit entry and returns true.
    Requires the Administer Configuration permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Confirm-TssManualUpgradeStaging -TssSession $session

    Records that the staging test of the manual upgrade passed

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/upgrade/Confirm-TssManualUpgradeStaging

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/upgrade/Confirm-TssManualUpgradeStaging.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('System.Boolean')]
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
            $uri = $TssSession.ApiUrl, 'upgrade', 'manual', 'staging-test-successful' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            if ($PSCmdlet.ShouldProcess("Manual upgrade staging", "$($invokeParams.Method) $uri")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Confirm-TssManualUpgradeStaging request'
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
