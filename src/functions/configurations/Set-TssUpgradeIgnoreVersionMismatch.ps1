function Set-TssUpgradeIgnoreVersionMismatch {
    <#
    .SYNOPSIS
    Turn the ignore version mismatch on upgrade setting on or off

    .DESCRIPTION
    Sets whether an upgrade ignores a mismatch between the application version and the version the database expects.
    Turn it on only to override that safety check during an upgrade, and off again afterwards.
    Requires the Administer Configuration permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Enabled
    True turns the setting on, false turns it off

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssUpgradeIgnoreVersionMismatch -TssSession $session -Enabled $true

    Turns on ignore version mismatch on upgrade

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssUpgradeIgnoreVersionMismatch -TssSession $session -Enabled $false

    Turns the setting off again after the upgrade

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssUpgradeIgnoreVersionMismatch

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssUpgradeIgnoreVersionMismatch.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Configuration.UpgradeFlag')]
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
            $uri = $TssSession.ApiUrl, 'configuration', 'set-ignore-version-mismatch-on-upgrade' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Enabled' {
                    $body.data.Add('enableVersionMismatchIgnore', $Enabled)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Upgrade ignore version mismatch", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssUpgradeIgnoreVersionMismatch request'
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
