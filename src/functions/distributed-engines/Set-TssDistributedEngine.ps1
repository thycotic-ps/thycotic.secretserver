function Set-TssDistributedEngine {
    <#
    .SYNOPSIS
    Set Distributed Engine configuration settings

    .DESCRIPTION
    Set Distributed Engine configuration settings

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssDistributedEngine -TssSession $session -Enable

    Enable Distributed Engine feature in Secret Server

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Set-TssDistributedEngine

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Set-TssDistributedEngine.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess)]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Enable Distributed Engine feature in Secret Server
        [switch]
        $Enable,

        # Azure Service Bus Transport Type, SSC only (allowed: Amqp, AmqpWebSockets)
        [Alias('AzureServiceBusTransportType')]
        [Thycotic.PowerShell.Enums.EngineAzServiceBusType]
        $TransportType,

        # Callback port
        [int]
        $CallbackPort,

        # Callback URL
        [string]
        $CallbackUrl,

        # Protocol used by the Distributed Engines (allowed: Http, Https, Tcp)
        [Thycotic.PowerShell.Enums.EngineProtocol]
        $Protocol,

        # Site Connector ID
        [int]
        $SiteConnectorId,

        # How long before a Secret Heartbeat message expires (in mintues)
        # **Retry time must be higher**
        [int]
        $HeartbeatTimeToLive,

        # How long before a Secret Heartbeat messsage will be resent (in minutes)
        [int]
        $HeartbeatRetry,

        # How long before a Secret Password Change message expires (in minutes)
        # **Retry time must be higher**
        [int]
        $RpcTimeToLive,

        # How long before a Secret Password Change message will be resent (in minutes)
        [int]
        $RpcRetry
    )
    begin {
        $setParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($setParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'distributed-engine', 'configuration' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'

            $setBody = @{ data = @{ } }
            switch ($setParams.Keys) {
                'Enable' {
                    $enableIt = @{
                        dirty = $true
                        value = [boolean]$Enable
                    }
                    $setBody.data.Add('enableDistributedEngines',$enableIt)
                }
                'TransportType' {
                    $azBusType = @{
                        dirty = $true
                        value = [string]$TransportType
                    }
                    $setBody.data.Add('azureServiceBusTransportType',$azBusType)
                }
                'CallbackPort' {
                    $cbPort = @{
                        dirty = $true
                        value = $CallbackPort
                    }
                    $setBody.data.Add('callbackPort',$cbPort)
                }
                'CallbackUrl' {
                    $cbUrl = @{
                        dirty = $true
                        value = $CallbackUrl
                    }
                    $setBody.data.Add('callbackUrl',$cbUrl)
                }
                'Protocol' {
                    $protocolValue = @{
                        dirty = $true
                        value = [string]$Protocol
                    }
                    $setBody.data.Add('protocol',$protocolValue)
                }
                'SiteConnectorId' {
                    $responseBusValue = @{
                        dirty = $true
                        value = $SiteConnectorId
                    }
                    $setBody.data.Add('responseBusSiteConnectorId',$responseBusValue)
                }
                'HeartbeatTimeToLive' {
                    $hbT2L = @{
                        dirty = $true
                        value = $HeartbeatTimeToLive
                    }
                    $setBody.data.Add('secretHeartbeatMessageMinutesToLive',$hbT2L)
                }
                'HeartbeatRetry' {
                    $hbRetry = @{
                        dirty = $true
                        value = $HeartbeatRetry
                    }
                    $setBody.data.Add('secretHeartbeatMessageRetryMinutes',$hbRetry)
                }
                'RpcTimeToLive' {
                    $rpcT2L = @{
                        dirty = $true
                        value = $RpcTimeToLive
                    }
                    $setBody.data.Add('secretPasswordChangeMessageMinutesToLive',$rpcT2L)
                }
                'RpcRetry' {
                    $rpcRetry = @{
                        dirty = $true
                        value = $RpcRetry
                    }
                    $setBody.data.Add('secretPasswordChangeMessageRetryMinutes',$RpcRetry)
                }
            }
            $invokeParams.Body = $setBody | ConvertTo-Json -Depth 100

            if ($PSCmdlet.ShouldProcess("Distributed Engine", "$($invokeParams.Method) $($invokeParams.Uri) with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri) with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue occurred setting configuration"
                    $err = $_
                    . $ErrorHandling $err
                }
            }
            if ($restResponse) {
                Write-Verbose 'Distributed Engine configuration updated successfully'
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}