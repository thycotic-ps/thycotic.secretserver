function Clear-TssUpgradeInProgress {
    <#
    .SYNOPSIS
    Clear the upgrade in progress flag

    .DESCRIPTION
    Clears the flag Secret Server sets while an upgrade runs, so an administrator can retry after a failed or aborted upgrade.
    Returns true when the flag was cleared.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Clear-TssUpgradeInProgress -TssSession $session

    Clears the upgrade in progress flag after a failed upgrade

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Clear-TssUpgradeInProgress

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Clear-TssUpgradeInProgress.ps1

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
            $uri = $TssSession.ApiUrl, 'diagnostics', 'clear-upgrade-in-progress' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            if ($PSCmdlet.ShouldProcess("Upgrade in progress", "$($invokeParams.Method) $uri")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Clear-TssUpgradeInProgress request'
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
