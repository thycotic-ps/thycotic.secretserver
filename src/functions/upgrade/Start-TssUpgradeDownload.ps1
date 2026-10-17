function Start-TssUpgradeDownload {
    <#
    .SYNOPSIS
    Download and stage the latest upgrade from the Delinea update server

    .DESCRIPTION
    Has the server download the latest upgrade package from the Delinea update server, unzip it, check its integrity, and stage it for Install-TssUpgrade or Start-TssUpgrade.
    -EarlyAdopter downloads early adopter (pre-release) versions instead of generally available ones.
    This is a real download on the server. Get-TssUpgradeState shows whether a newer version is available (IsLatestVersion, LatestVersionToDownload).
    When the application pool identity cannot write to the application or temp folder (AppPoolHasDiskAccessApplication or AppPoolHasDiskAccessTemp false in Get-TssUpgradeState), pass -ImpersonationCredential with a Windows account that can. A failed logon returns LoginFail true. Nothing is downloaded when the logon fails.
    Requires the Administer Configuration permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER EarlyAdopter
    Download early adopter (pre-release) versions instead of generally available ones

    .PARAMETER ImpersonationCredential
    Windows account the server impersonates for disk access when the application pool identity lacks it

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Start-TssUpgradeDownload -TssSession $session

    Downloads and stages the latest generally available upgrade

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Start-TssUpgradeDownload -TssSession $session -EarlyAdopter

    Downloads and stages the latest early adopter upgrade

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/upgrade/Start-TssUpgradeDownload

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/upgrade/Start-TssUpgradeDownload.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Upgrade.Download')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $EarlyAdopter,

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
            $uri = $TssSession.ApiUrl, 'upgrade', 'download' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'EarlyAdopter' {
                    $body.data.Add('earlyAdopterEnabled', [boolean]$EarlyAdopter)
                }
            }
            if ($tssParams.ContainsKey('ImpersonationCredential')) {
                $body.data.Add('impersonationUserName', $ImpersonationCredential.UserName)
                $body.data.Add('impersonationPassword', $ImpersonationCredential.GetNetworkCredential().Password)
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Upgrade download", "$($invokeParams.Method) $uri (request body not shown: it carries sensitive values)")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri (request body not shown: it carries sensitive values)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Start-TssUpgradeDownload request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Upgrade.Download](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Upgrade.Download]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
