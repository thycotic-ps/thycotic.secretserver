function Get-TssDistributedEngineSiteStub {
    <#
    .SYNOPSIS
    Get the default values for a new Distributed Engine site

    .DESCRIPTION
    Gets a site populated with the default values a new site starts with, such as the heartbeat interval and the WinRM endpoint.
    Use it as a starting point for New-TssDistributedEngineSite.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDistributedEngineSiteStub -TssSession $session

    Gets the default values for a new site

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Get-TssDistributedEngineSiteStub

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Get-TssDistributedEngineSiteStub.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DistributedEngines.Site')]
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
            $uri = $TssSession.ApiUrl, 'distributed-engine', 'site', 'stub' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssDistributedEngineSiteStub request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.DistributedEngines.Site](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.DistributedEngines.Site]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
