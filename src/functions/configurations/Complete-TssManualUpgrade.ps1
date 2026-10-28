function Complete-TssManualUpgrade {
    <#
    .SYNOPSIS
    Mark a manual upgrade as finished

    .DESCRIPTION
    Marks the manual (multi-step) upgrade as finished once every node runs the new version.
    Run Search-TssManualUpgradeNode first to confirm every node reached the target version.
    Requires the Administer Configuration permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssManualUpgradeNode -TssSession $session | Select-Object MachineName, Version
    Complete-TssManualUpgrade -TssSession $session

    Shows the version on every node, then marks the manual upgrade as finished

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Complete-TssManualUpgrade

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Complete-TssManualUpgrade.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Configuration.UpgradeFlag')]
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
            $uri = $TssSession.ApiUrl, 'configuration', 'finish-manual-upgrade' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ isFinished = $true } }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Manual upgrade", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Complete-TssManualUpgrade request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Configuration.UpgradeFlag](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.UpgradeFlag]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
