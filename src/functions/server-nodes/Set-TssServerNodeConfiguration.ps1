function Set-TssServerNodeConfiguration {
    <#
    .SYNOPSIS
    Update the roles, cluster membership, read-only mode and log level of a server node

    .DESCRIPTION
    Updates the configuration of a Secret Server web node.
    The server expects the complete node configuration, so this cmdlet reads the node with Get-TssServerNode first and changes only the parameters provided; every other setting keeps its current value.
    Unlike Update-TssServerNode, which sends a partial body with PUT, this cmdlet sends the full configuration with POST.
    Returns the result the server sends back: True when it accepted the configuration, also when nothing changed.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Server node ID

    .PARAMETER ChangeRootLogLevel
    Also apply the log level to the root logger; needs a log level on the node or -LogLevel

    .PARAMETER EnableBackgroundWorker
    Enable the background worker role

    .PARAMETER EnableEngineWorker
    Enable the engine worker role

    .PARAMETER EnableSessionRecordingWorker
    Enable the session recording worker role

    .PARAMETER InCluster
    Include the node in the cluster

    .PARAMETER LogLevel
    Node log level: All, Debug, Info, Warn, Error or Off

    .PARAMETER ReadonlyModeEnabled
    Put the node in read-only mode

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssServerNodeConfiguration -TssSession $session -Id 2 -EnableSessionRecordingWorker:$false

    Turns off the session recording worker role on node 2 and keeps every other setting

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssServerNode -TssSession $session | Set-TssServerNodeConfiguration -TssSession $session -LogLevel Debug -WhatIf

    Shows the request that would set every node to Debug logging, without sending it

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/server-nodes/Set-TssServerNodeConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/server-nodes/Set-TssServerNodeConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('System.Boolean')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('NodeId')]
        [int]
        $Id,

        [switch]
        $ChangeRootLogLevel,

        [switch]
        $EnableBackgroundWorker,

        [switch]
        $EnableEngineWorker,

        [switch]
        $EnableSessionRecordingWorker,

        [switch]
        $InCluster,

        [ValidateSet('All', 'Debug', 'Info', 'Warn', 'Error', 'Off')]
        [string]
        $LogLevel,

        [switch]
        $ReadonlyModeEnabled
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $node = Get-TssServerNode -TssSession $TssSession -Id $Id
            if ($node) {
                $uri = $TssSession.ApiUrl, 'nodes', $Id, 'configuration' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'POST'
                $body = @{
                    inCluster                    = [boolean]$node.InCluster
                    enableBackgroundWorker       = [boolean]$node.EnableBackgroundWorker
                    enableEngineWorker           = [boolean]$node.EnableEngineWorker
                    enableSessionRecordingWorker = [boolean]$node.EnableSessionRecordingWorker
                    readonlyModeEnabled          = [boolean]$node.ReadonlyModeEnabled
                    logLevel                     = if ($node.LogLevel) { $node.LogLevel } else { $null }
                    changeRootLogLevel           = [boolean]$node.ChangeRootLogLevel
                }
                switch ($tssParams.Keys) {
                    'InCluster' {
                        $body['inCluster'] = [boolean]$InCluster
                    }
                    'EnableBackgroundWorker' {
                        $body['enableBackgroundWorker'] = [boolean]$EnableBackgroundWorker
                    }
                    'EnableEngineWorker' {
                        $body['enableEngineWorker'] = [boolean]$EnableEngineWorker
                    }
                    'EnableSessionRecordingWorker' {
                        $body['enableSessionRecordingWorker'] = [boolean]$EnableSessionRecordingWorker
                    }
                    'ReadonlyModeEnabled' {
                        $body['readonlyModeEnabled'] = [boolean]$ReadonlyModeEnabled
                    }
                    'LogLevel' {
                        $body['logLevel'] = $LogLevel
                    }
                    'ChangeRootLogLevel' {
                        $body['changeRootLogLevel'] = [boolean]$ChangeRootLogLevel
                    }
                }
                $invokeParams.Body = $body | ConvertTo-Json -Depth 100
                if ($PSCmdlet.ShouldProcess("Server node: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                    $restResponse = $null
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning 'Issue with Set-TssServerNodeConfiguration request'
                        $err = $_
                        . $ErrorHandling $err
                    }
                    if ($null -ne $restResponse) {
                        [boolean]$restResponse
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
