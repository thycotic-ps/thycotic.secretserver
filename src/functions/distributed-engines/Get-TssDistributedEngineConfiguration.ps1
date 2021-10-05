function Get-TssDistributedEngineConfiguration {
    <#
    .SYNOPSIS
    Get the configuration for Distributed Engine feature of Secret Server

    .DESCRIPTION
    Get the configuration for Distributed Engine feature of Secret Server

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDistributedEngineConfiguration -TssSession $session some test value

    Return configuration of Distributed Engine feature in Secret Server

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Get-TssDistributedEngineConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Get-TssDistributedEngineConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DistributedEngines.Configuration')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
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
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
                $uri = $TssSession.ApiUrl, 'distributed-engine', 'configuration' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue getting Distributed Engine configuration"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    [Thycotic.PowerShell.DistributedEngines.Configuration]$restResponse
                }
        } else {
            Write-Warning "No valid session found"
        }
    }
}