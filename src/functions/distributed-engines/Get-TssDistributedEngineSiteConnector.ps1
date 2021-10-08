function Get-TssDistributedEngineSiteConnector {
    <#
    .SYNOPSIS
    Get Site Connector by ID

    .DESCRIPTION
    Get Site Connector by ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDistributedEngineSiteConnector -TssSession $session -Id 2

    Get Site Connector ID 2

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Get-TssDistributedEngineSiteConnector

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Get-TssDistributedEngineSiteConnector.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DistributedEngines.SiteConnector')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Site Connector ID
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("SiteConnectorId")]
        [int[]]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            foreach ($connector in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'distributed-engine', 'site-connector', $connector -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue getting reference name on [$connector]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    . $GetSiteConnector $restResponse
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}