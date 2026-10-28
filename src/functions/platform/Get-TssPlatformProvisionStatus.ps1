function Get-TssPlatformProvisionStatus {
    <#
    .SYNOPSIS
    Get the Platform provisioning status

    .DESCRIPTION
    Get the status of Delinea Platform provisioning for this Secret Server: when it started and whether Platform integration is enabled.
    The status can include a one-time Platform login URL: treat it as a credential.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssPlatformProvisionStatus -TssSession $session | Select-Object RequestStartDateTime, OpenIdConnectEnabled

    Show when provisioning started and whether Platform integration is on

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Get-TssPlatformProvisionStatus

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Get-TssPlatformProvisionStatus.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server Cloud only: an on-premises Secret Server answers this endpoint with an error.
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Platform.ProvisionStatus')]
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
            $uri = $TssSession.ApiUrl, 'platform', 'provision-status' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssPlatformProvisionStatus request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Platform.ProvisionStatus](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Platform.ProvisionStatus]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
