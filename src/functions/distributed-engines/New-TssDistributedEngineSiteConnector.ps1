function New-TssDistributedEngineSiteConnector {
    <#
    .SYNOPSIS
    Create a new Site Connector

    .DESCRIPTION
    Create a new Site Connector

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/New-TssDistributedEngineSiteConnector

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/New-TssDistributedEngineSiteConnector.ps1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssDistributedEngineSiteConnector -TssSession $session -Name 'New Site Connector 1'

    Add minimum example for each parameter

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.DistributedEngine.SiteConnector')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Service Bus Transport Type (allowed: MemoryMq, RabbitMq)
        [ValidateSet('MemoryMq','RabbitMq')]
        [string]
        $TransportType,

        # Service Bus Transport Port
        [int]
        $Port,

        # Site Connector Name
        [Parameter(Mandatory)]
        [string]
        $Name,

        # Hostname
        [Parameter(Mandatory)]
        [string]
        $Hostname,

        # Do not activate on creation
        [switch]
        $Disable,

        # Use SSL
        [switch]
        $UseSsl,

        # SSL Certificate Thumbprint
        [string]
        $SslThumbprint
    )
    begin {
        $tssNewParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssNewParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'distributed-engine', 'site-connector' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'

            $newBody = @{data = @{}}
            switch ($tssNewParams.Keys) {
                'TransportType' { $newBody.data.Add('queueType',$TransportType)}
                'Port' {$newBody.data.Add('port',$Port)}
                'Name' {$newBody.data.Add('siteConnectorName',$Name)}
                'Hostname' {$newBody.data.Add('hostName',$Hostname)}
                'Disable' {$newBody.data.Add('active',$false)}
                'UseSsl' {
                    if ($tssNewParams.ContainsKey('SslThumbprint')) {
                        $newBody.data.Add('useSsl',$UseSsl)
                        $newBody.data.Add('sslCertificateThumbprint')
                    } else {
                        Write-Warning "SslThumbprint must be provided when using SSL"
                        return
                    }
                }
            }
            $invokeParams.Body = ($newBody | ConvertTo-Json)

            Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri) with:`n $newBody"
            if (-not $PSCmdlet.ShouldProcess("Reference $Name", "$($invokeParams.Method) $($invokeParams.Uri) with $($invokeParams.Body)")) { return }
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning "Issue creating Reference [Name]"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                . $GetSiteConnector $restResponse
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}