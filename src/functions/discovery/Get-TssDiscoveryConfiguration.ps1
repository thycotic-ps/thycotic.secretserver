function Get-TssDiscoveryConfiguration {
    <#
    .SYNOPSIS
    Get the Discovery configuration

    .DESCRIPTION
    Returns whether Discovery is enabled, how often it runs, the AD batch size for engines and how long Discovery logs are kept.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDiscoveryConfiguration -TssSession $session

    Get the Discovery configuration

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Discovery.Configuration')]
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
            $uri = $TssSession.ApiUrl, 'discovery', 'configuration' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssDiscoveryConfiguration request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Discovery.Configuration](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Discovery.Configuration]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
