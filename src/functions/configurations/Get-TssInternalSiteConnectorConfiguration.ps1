function Get-TssInternalSiteConnectorConfiguration {
    <#
    .SYNOPSIS
    Get the internal site connector configuration

    .DESCRIPTION
    Get the site connector Secret Server uses for its own internal traffic. SiteConnectorId is empty when none is assigned.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssInternalSiteConnectorConfiguration -TssSession $session

    Show which site connector Secret Server uses internally

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssInternalSiteConnectorConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssInternalSiteConnectorConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server on-premises only: Secret Server Cloud answers this endpoint with Access denied.
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Configuration.InternalSiteConnectorConfiguration')]
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
            $uri = $TssSession.ApiUrl, 'configuration', 'internal-site-connector' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssInternalSiteConnectorConfiguration request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Configuration.InternalSiteConnectorConfiguration](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.InternalSiteConnectorConfiguration]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
