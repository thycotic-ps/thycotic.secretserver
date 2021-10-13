function Register-TssDistributedEngine {
    <#
    .SYNOPSIS
    Activate a Distributed Engine for a Site

    .DESCRIPTION
    Activate a Distributed Engine for a Site

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Register-TssDistributedEngine -TssSession $session -EngineId 6 -SiteId 5

    Activate Engine ID 6 on Site ID 5

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Register-TssDistributedEngine

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Register-TssDistributedEngine.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.DistributedEngines.EngineActivation')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Engine ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('EngineId')]
        [int[]]
        $Id,

        # Site ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $SiteId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'distributed-engine', 'update-engine-status' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'

            $registerBody = @{data = @{} }
            $allEngines = @()
            foreach ($engine in $Id) {
                $cEngine = @{}
                $cEngine.Add('changeType','Activate')
                $cEngine.Add('engineId',$engine)
                $cEngine.Add('siteId',$SiteId)
                $allEngines += $cEngine
            }
            $registerBody.data.Add('engines',$allEngines)

            $invokeParams.Body = $registerBody | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("description: $", "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)")) {
                Write-Verbose "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue warning message'
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse.results) {
                    foreach ($record in $restResponse.results) {
                        [Thycotic.PowerShell.DistributedEngines.EngineActivation]@{
                            EngineId     = $record.engineId
                            EngineName   = $record.engineName
                            Error        = $record.error
                            IsSuccessful = $record.success
                        }
                    }

                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}