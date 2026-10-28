function Get-TssDistributedEngineSiteConnectorStub {
    <#
    .SYNOPSIS
    Get the default values for a new site connector

    .DESCRIPTION
    Gets a site connector populated with the default values for the given queue type, such as the default port.
    Use it as a starting point for New-TssDistributedEngineSiteConnector.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER QueueType
    Queue type of the new site connector: MemoryMq, RabbitMq, RabbitMqQuorum or AzureServiceBus (cloud only)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDistributedEngineSiteConnectorStub -TssSession $session -QueueType RabbitMq

    Gets the default values for a new RabbitMQ site connector

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Get-TssDistributedEngineSiteConnectorStub

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Get-TssDistributedEngineSiteConnectorStub.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DistributedEngines.SiteConnector')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [ValidateSet('MemoryMq', 'RabbitMq', 'RabbitMqQuorum', 'AzureServiceBus')]
        [string]
        $QueueType
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'distributed-engine', 'site-connector', 'stub' -join '/'
            $queryParams = @()
            switch ($tssParams.Keys) {
                'QueueType' {
                    $queryParams += "queueType=$([uri]::EscapeDataString($QueueType))"
                }
            }
            if ($queryParams) {
                $uri = $uri, ($queryParams -join '&') -join '?'
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssDistributedEngineSiteConnectorStub request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.DistributedEngines.SiteConnector]@{
                    Active                   = $restResponse.active.value
                    HostName                 = $restResponse.hostName.value
                    Port                     = $restResponse.port.value
                    QueueType                = $restResponse.queueType.value
                    SharedAccessKeyName      = $restResponse.sharedAccessKeyName.value
                    SharedAccessKeyValue     = $restResponse.sharedAccessKeyValue.value
                    SiteConnectorId          = $restResponse.siteConnectorId
                    SiteConnectorName        = $restResponse.siteConnectorName.value
                    SslCertificateThumbprint = $restResponse.sslCertificateThumbprint.value
                    UseSsl                   = $restResponse.useSsl.value
                    Validated                = $restResponse.validated.value
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
