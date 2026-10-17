function Set-TssInternalSiteConnectorConfiguration {
    <#
    .SYNOPSIS
    Set the internal site connector configuration

    .DESCRIPTION
    Assign the site connector Secret Server uses for its own internal traffic, or remove the assignment with -Clear. The site connector must already exist; Secret Server answers an unknown Id with an internal server error. Returns the configuration after the update.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER SiteConnectorId
    Id of the site connector Secret Server uses for internal traffic

    .PARAMETER Clear
    Remove the internal site connector assignment

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssInternalSiteConnectorConfiguration -TssSession $session -SiteConnectorId 2

    Use site connector 2 for internal traffic

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssInternalSiteConnectorConfiguration -TssSession $session -Clear

    Remove the internal site connector assignment

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssInternalSiteConnectorConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssInternalSiteConnectorConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server on-premises only: Secret Server Cloud answers this endpoint with Access denied.
    #>
    [CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'connector')]
    [OutputType('Thycotic.PowerShell.Configuration.InternalSiteConnectorConfiguration')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ParameterSetName = 'connector')]
        [int]
        $SiteConnectorId,

        [Parameter(Mandatory, ParameterSetName = 'clear')]
        [switch]
        $Clear
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'internal-site-connector' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $siteConnectorValue = if ($Clear) { $null } else { $SiteConnectorId }
            $body = @{ data = @{ siteConnectorId = @{ dirty = $true; value = $siteConnectorValue } } }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Internal site connector configuration", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssInternalSiteConnectorConfiguration request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Configuration.InternalSiteConnectorConfiguration](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.InternalSiteConnectorConfiguration]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
