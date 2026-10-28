function Get-TssDiscoverySourceFilter {
    <#
    .SYNOPSIS
    Get the OU filters of a discovery source

    .DESCRIPTION
    Gets the domain scope of an Active Directory discovery source: the organizational units and containers it includes or excludes, with the site, credential secret and scan target of each.
    Secret Server reads the domain to answer, so a domain controller must be reachable from the site of the source.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Discovery source ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    (Get-TssDiscoverySourceFilter -TssSession $session -Id 3).Filters

    List the OU filters of discovery source 3

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoverySourceFilter

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoverySourceFilter.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Discovery.SourceFilter')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
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
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'discovery', 'source', $currentId, 'filter' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssDiscoverySourceFilter request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Discovery.SourceFilter](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Discovery.SourceFilter]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
