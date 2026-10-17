function New-TssManualUpgradeAppZip {
    <#
    .SYNOPSIS
    Generate the application ZIP for a manual upgrade

    .DESCRIPTION
    Builds a ZIP of the changed application files of the staged upgrade patch in the manual upgrade temp folder. FileName is the generated name: download it with Save-TssManualUpgradePackage.
    Needs a staged upgrade patch. Without one the call returns Success false and a StatusMessage.
    Running it again regenerates the ZIP.
    When the application pool identity cannot write to the application or temp folder (AppPoolHasDiskAccessApplication or AppPoolHasDiskAccessTemp false in Get-TssUpgradeState), pass -ImpersonationCredential with a Windows account that can. A failed logon returns LoginFail true.
    Requires the Administer Configuration permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER ImpersonationCredential
    Windows account the server impersonates for disk access when the application pool identity lacks it

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $zip = New-TssManualUpgradeAppZip -TssSession $session
    Save-TssManualUpgradePackage -TssSession $session -FileName $zip.FileName -Output .

    Generates the application ZIP and downloads it to the current folder

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/upgrade/New-TssManualUpgradeAppZip

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/upgrade/New-TssManualUpgradeAppZip.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Upgrade.ManualUpgradeAppZip')]
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
            $uri = $TssSession.ApiUrl, 'upgrade', 'manual', 'generate-application-zip' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            if ($tssParams.ContainsKey('ImpersonationCredential')) {
                $body.data.Add('impersonationUserName', $ImpersonationCredential.UserName)
                $body.data.Add('impersonationPassword', $ImpersonationCredential.GetNetworkCredential().Password)
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Manual upgrade app zip", "$($invokeParams.Method) $uri (request body not shown: it carries sensitive values)")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri (request body not shown: it carries sensitive values)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssManualUpgradeAppZip request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Upgrade.ManualUpgradeAppZip](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Upgrade.ManualUpgradeAppZip]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
