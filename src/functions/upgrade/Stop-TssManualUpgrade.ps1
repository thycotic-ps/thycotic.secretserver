function Stop-TssManualUpgrade {
    <#
    .SYNOPSIS
    Cancel a manual upgrade

    .DESCRIPTION
    Cancels the manual (multi-step) upgrade and removes the generated SQL script and application ZIP from the temp folder.
    Safe to run when no manual upgrade is in progress: it returns Success true.
    Requires the Administer Configuration permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Stop-TssManualUpgrade -TssSession $session

    Cancels the manual upgrade and removes its generated files

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/upgrade/Stop-TssManualUpgrade

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/upgrade/Stop-TssManualUpgrade.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Upgrade.ManualUpgradeCancel')]
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
            $uri = $TssSession.ApiUrl, 'upgrade', 'manual', 'cancel' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Manual upgrade", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Stop-TssManualUpgrade request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Upgrade.ManualUpgradeCancel](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Upgrade.ManualUpgradeCancel]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
