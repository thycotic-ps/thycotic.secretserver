function Get-TssPlatformStatus {
    <#
    .SYNOPSIS
    Get the status of a Delinea Platform tenant

    .DESCRIPTION
    Ask the Delinea Platform about a tenant host name and get its tenant id. Secret Server calls the Platform for each host name. An empty TenantId means no tenant has the host name: the Platform reports TenantExists True for any name it does not answer as not found, so check TenantId, not TenantExists.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Hostname
    Platform tenant host name to check

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssPlatformStatus -TssSession $session -Hostname contoso.delinea.app | Select-Object TenantId

    Get the tenant id of the contoso Platform tenant; an empty TenantId means no tenant has that host name

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Get-TssPlatformStatus

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Get-TssPlatformStatus.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server Cloud only: an on-premises Secret Server answers this endpoint with an error.
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Platform.TenantStatus')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string[]]
        $Hostname
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($currentHostname in $Hostname) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'platform', 'status' -join '/'
                $uri = $uri, "hostname=$([uri]::EscapeDataString($currentHostname))" -join '?'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue checking Platform tenant [$currentHostname]"
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Platform.TenantStatus](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Platform.TenantStatus]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
