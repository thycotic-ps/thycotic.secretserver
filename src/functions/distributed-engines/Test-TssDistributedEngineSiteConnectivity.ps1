function Test-TssDistributedEngineSiteConnectivity {
    <#
    .SYNOPSIS
    Test the round trip from Secret Server to the engines of a site

    .DESCRIPTION
    Sends a test message through the site connector to the engines of a site and waits for the reply.
    Returns ValidationSuccess and a ValidationMessage with the round-trip times or the failure reason.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Site ID

    .PARAMETER Timeout
    Seconds to wait for the round trip, 1 to 3600 (default 30)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Test-TssDistributedEngineSiteConnectivity -TssSession $session -Id 3

    Tests the connectivity of site 3 with the default 30 second timeout

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Test-TssDistributedEngineSiteConnectivity -TssSession $session -Id 3 -Timeout 120

    Tests the connectivity of site 3, waiting up to two minutes

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Test-TssDistributedEngineSiteConnectivity

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Test-TssDistributedEngineSiteConnectivity.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    A session created with -UseWindowsAuth cannot use this cmdlet: the server publishes the Windows authentication route of this endpoint without the site segment (distributed-engine/{siteId}/validate-connectivity), so the request fails.
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DistributedEngines.SiteConnectivity')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SiteId')]
        [int]
        $Id,

        [ValidateRange(1, 3600)]
        [int]
        $Timeout = 30
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '11.2.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'distributed-engine', 'site', $Id, 'validate-connectivity' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ timeout = $Timeout } }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Test-TssDistributedEngineSiteConnectivity request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.DistributedEngines.SiteConnectivity](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.DistributedEngines.SiteConnectivity]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
