function Update-TssServerNode {
    <#
    .SYNOPSIS
    Update Server Node configuration

    .DESCRIPTION
    Update Server Node configuration

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssServerNode -TssSession $session -NodeId 3 -EnableInCluster:$false

    Update Server Node 3 removing it from the cluster

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssServerNode -TssSession $session -NodeId 1,2,3 -EnableReadonly

    Update nodes 1-3 to be readonly

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssServerNode -TssSession $session -NodeId 3,4 -EnableInCluster -EnableSessionRecording

    Update nodes 3 and 4 to be in the cluster, and enable the Session Recording worker for each

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/server-nodes/Update-TssServerNode

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/server-nodes/Update-TssServerNode.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess)]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Server Node ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('Id')]
        [int[]]
        $NodeId,

        # Enable Background Worker
        [switch]
        $EnableBackground,

        # Enable Engine Worker
        [switch]
        $EnableEngine,

        # Enable Session Recording Worker
        [switch]
        $EnableSessionRecording,

        # Include in cluster
        [switch]
        $EnableInCluster,

        # Set readonly mode
        [switch]
        $EnableReadonly
    )
    begin {
        $updateParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($updateParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            foreach ($node in $NodeId) {
                $uri = $TssSession.ApiUrl, 'nodes', $node, 'configuration' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'PUT'

                $updateBody = @{}
                switch ($updateParams.Keys) {
                    'EnableBackground' { $updateBody.Add('enableBackgroundWorker',[boolean]$EnableBackground) }
                    'EnableEngine' { $updateBody.Add('enableEngineWorker',[boolean]$EnableEngine) }
                    'EnableSessionRecording' { $updateBody.Add('enableSessionRecordingWorker',[boolean]$EnableSessionRecording) }
                    'EnableInCluster' { $updateBody.Add('inCluster',[boolean]$EnableInCluster) }
                    'EnableReadonly' { $updateBody.Add('readonlyModeEnabled',[boolean]$EnableReadonly) }
                }
                $invokeParams.Body = $updateBody | ConvertTo-Json -Depth 10
                if ($PSCmdlet.ShouldProcess("Server Node: $node", "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)")) {
                    Write-Verbose "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning 'Issue updating Server Node configuration [$Server Node configuration]'
                        $err = $_
                        . $ErrorHandling $err
                    }

                    if ($restResponse) {
                        Write-Verbose "Server Node [$node] configuration updated successfully"
                    } else {
                        Write-Warning "Server Node [$node] configuration was not updated, see previous output for errors"
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}