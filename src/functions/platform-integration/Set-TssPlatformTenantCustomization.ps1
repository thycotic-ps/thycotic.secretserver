function Set-TssPlatformTenantCustomization {
    <#
    .SYNOPSIS
    Update the Platform tenant customization

    .DESCRIPTION
    Push the tenant customization information of this Secret Server to the Delinea Platform tenant. Sends no body. Returns Success.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssPlatformTenantCustomization -TssSession $session

    Update the Platform tenant customization

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-integration/Set-TssPlatformTenantCustomization

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-integration/Set-TssPlatformTenantCustomization.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Requires Platform integration: a Secret Server without it answers a generic 500 error with no error code.
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.PlatformMigration.OperationResult')]
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
            $uri = $TssSession.ApiUrl, 'platform-integration', 'update-tenant-customization' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            if ($PSCmdlet.ShouldProcess("Platform tenant customization", "$($invokeParams.Method) $uri")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssPlatformTenantCustomization request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.PlatformMigration.OperationResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.PlatformMigration.OperationResult]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
