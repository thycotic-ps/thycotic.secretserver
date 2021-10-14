function Update-TssDistributedEngine {
    <#
    .SYNOPSIS
    Update a Distributed Engine

    .DESCRIPTION
    Update a Distributed Engine

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssDistributedEngine -TssSession $session -Id 24 -SiteId 6 -Status Activate

    Activate Engine 24 on Site 6

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssDistributedEngine -TssSession $session -Id 12,56,34,23 -SiteId 2 -Status RemoveFromSite

    Remove the Engines provided from Site 2

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Update-TssDistributedEngine

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Update-TssDistributedEngine.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.DistributedEngines.EngineActivation')]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Distributed Engine ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('Id')]
        [int[]]
        $EngineId,

        # Site ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $SiteId,

        # Change Engine Status (allowed: Activate, Deactivate, Delete, RemoveFromSite)
        [Parameter(Mandatory)]
        [Thycotic.PowerShell.Enums.EngineStatusType]
        $Status
    )
    begin {
        $updateParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($updateParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'distributed-engine', 'update-engine-status' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'

            $updateBody = @{data = @{} }
            $allEngines = @()
            foreach ($engine in $EngineId) {
                $cEngine = @{}
                $cEngine.Add('changeType',[string]$Status)
                $cEngine.Add('engineId',$engine)
                $cEngine.Add('siteId',$SiteId)
                $allEngines += $cEngine
            }
            $updateBody.data.Add('engines',$allEngines)

            $invokeParams.Body = $updateBody | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Distributed Engine", "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)")) {
                Write-Verbose "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue updating a Distributed Engine [$a Distributed Engine]'
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