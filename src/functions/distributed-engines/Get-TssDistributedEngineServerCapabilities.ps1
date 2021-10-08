function Get-TssDistributedEngineServerCapabilities {
    <#
    .SYNOPSIS
    Get the server capabilities for a Distributed Engine

    .DESCRIPTION
    Get the server capabilities for a Distributed Engine

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDistributedEngineServerCapabilities -TssSession $session -Id 5

    Return server capabilities for Distributed Engine Id 5

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Get-TssDistributedEngineServerCapabilities

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Get-TssDistributedEngineServerCapabilities.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DistributedEngine.ServerCapabilities')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Short description for parameter
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("EngineId")]
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
            foreach ($engine in $Id) {
                $uri = $TssSession.ApiUrl, 'distributed-engine', $engine, 'server-capabilities' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue getting server capabilities for Distributed Engine [$engine]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    . $GetServerCapabilities $restResponse
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}