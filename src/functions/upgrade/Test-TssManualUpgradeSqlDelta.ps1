function Test-TssManualUpgradeSqlDelta {
    <#
    .SYNOPSIS
    Verify that the SQL script of a manual upgrade applies cleanly

    .DESCRIPTION
    Runs the generated SQL update script against the database in a verification pass, without committing the upgrade, to confirm the deltas, functions and stored procedures apply cleanly. Success false comes with a StatusMessage and Details.
    Run New-TssManualUpgradeSqlScript first. Without a script the call returns Success false.
    When the application pool identity cannot write to the application or temp folder (AppPoolHasDiskAccessApplication or AppPoolHasDiskAccessTemp false in Get-TssUpgradeState), pass -ImpersonationCredential with a Windows account that can. A failed logon returns LoginFail true.
    Requires the Administer Configuration permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER ImpersonationCredential
    Windows account the server impersonates for disk access when the application pool identity lacks it

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssManualUpgradeSqlScript -TssSession $session
    Test-TssManualUpgradeSqlDelta -TssSession $session

    Generates the SQL update script and verifies it applies cleanly

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/upgrade/Test-TssManualUpgradeSqlDelta

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/upgrade/Test-TssManualUpgradeSqlDelta.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Upgrade.ManualUpgradeSqlDelta')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [pscredential]
        $ImpersonationCredential
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'upgrade', 'manual', 'verify-sql-deltas' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            if ($tssParams.ContainsKey('ImpersonationCredential')) {
                $body.data.Add('impersonationUserName', $ImpersonationCredential.UserName)
                $body.data.Add('impersonationPassword', $ImpersonationCredential.GetNetworkCredential().Password)
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Manual upgrade sql delta", "$($invokeParams.Method) $uri (request body not shown: it carries sensitive values)")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri (request body not shown: it carries sensitive values)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Test-TssManualUpgradeSqlDelta request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Upgrade.ManualUpgradeSqlDelta](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Upgrade.ManualUpgradeSqlDelta]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
