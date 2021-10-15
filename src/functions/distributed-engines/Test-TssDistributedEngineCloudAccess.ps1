function Test-TssDistributedEngineCloudAccess {
    <#
    .SYNOPSIS
    Validate network and firewall access to Secret Server Cloud from a device

    .DESCRIPTION
    Validate network and firewall access to Secret Server Cloud (SSC) from a device. The command validates port access for SSC and the Azure Service Bus host.
    This function would be used from your Distributed Engine to verify the proper outputbound access is in place for a Distributed Engine to communicate with SSC.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://tenant.secretservercloud.com -Credential $ssCred
    Test-TssDistributedEngineCloudAccess -TssSession $session -TransportType AMQP -Timeout 30

    Run Hostname and IP port test for SSC URL and Service Bus with ports 5671 and 5672 for AMQP, with a timeout of 30 seconds

    .EXAMPLE
    $session = New-TssSession -SecretServer https://tenant.secretservercloud.eu -Credential $ssCred
    Test-TssDistributedEngineCloudAccess -TssSession $session

    Run Hostname and IP port test for SSC URL and Service Bus with port 443 (Web Sockets), with a default timeout of 5 seconds

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Test-TssDistributedEngineCloudAccess

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Test-TssDistributedEngineCloudAccess.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Details on IP and Hostnames used:
        - https://docs.thycotic.com/ss/11.0.0/secret-server-setup/upgrading/ssc-ip-change-3-21#new_ip_addresses_and_hostnames
        - https://docs.thycotic.com/ss-arc/1.0.0/secret-server/secret-server-cloud
    #>
    [cmdletbinding()]
    [OutputType('Thycotic.PowerShell.DistributedEngines.CloudAccessResult')]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Azure ServiceBus Transport Type (Admin > Distributed Engine > Configuration tab), defaults to WebSockets
        [ValidateSet('Web Sockets', 'AMQP')]
        $TransportType = 'Web Sockets',

        # Timeout for connection test, defaults to 5 seconds
        [int]
        $Timeout = 5
    )
    begin {
        $tssParams = $PSBoundParameters
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            $secretServerUrl = $TssSession.SecretServer
            $secretServerHost = ([uri]$TssSession.SecretServer).Host
            $tssSscDomains = . $SscDomains
            $tssSscDomainIps = . $sscDomainIps
            $tssServiceBusHosts = . $SscAzureServiceBusHosts

            switch ([string]$TransportType) {
                'Web Sockets' { $testPortServiceBus = 443 }
                'AMQP' { $testPortServiceBus = 5671,5672 }
            }

            $regionDomain = $tssSscDomains.Where({ $secretServerUrl -match $_.Domain })
            $region = $regionDomain.Region
            $domain = $regionDomain.Domain
            Write-Verbose "Setting region to: $region"
            Write-Verbose "Host domain for Secret Server Cloud: $domain"

            $testSBHosts = $tssServiceBusHosts.Where({ $_.Domain -eq $domain })
            $testDomainIPs = $tssSscDomainIps.Where({ $_.Domain -eq $domain })
            $results = @()

            $ssTcp = [System.Net.Sockets.TcpClient]::new()
            $sscResult = [Thycotic.PowerShell.DistributedEngines.CloudAccessResult]@{
                ItemName    = 'Secret Server Cloud Domain'
                HostAddress = $secretServerHost
                Port        = 443
                Status      = $null
            }
            Write-Verbose "Testing Secret Server Cloud Domain [$secretServerHost] on port [443]"
            if ($ssTcp.ConnectAsync($secretServerHost,443).Wait([timespan]::FromSeconds($Timeout))) {
                Write-Warning "Secret Server Cloud Domain test failed on port [443]"
                $sscResult.Status = 'Failed'
            } else {
                Write-Verbose "Secret Server Cloud Domain test successful on port [443]"
                $sscResult.Status = 'Successful'
            }
            $results += $sscResult

            $siteConnector = Search-TssDistributedEngineConnector -TssSession $TssSession
            if ($siteConnector) {
                foreach ($port in $testPortServiceBus) {
                    $customerServiceBus = $siteConnector.Hostname
                    Write-Verbose "Testing Customer Service Bus host [$CustomerServiceBus] on port [$port]"

                    $cSbTcp = [System.Net.Sockets.TcpClient]::new()
                    $cSbResult = [Thycotic.PowerShell.DistributedEngines.CloudAccessResult]@{
                        ItemName    = 'Customer Service Bus Hostname'
                        HostAddress = $customerServiceBus
                        Port        = $port
                        Status      = $null
                    }
                    if ($cSbTcp.ConnectAsync($customerServiceBus,$port).Wait([timespan]::FromSeconds($Timeout))) {
                        Write-Warning "Service Bus Host test failed on port [$port]"
                        $cSbResult.Status = 'Failed'
                    } else {
                        Write-Verbose "Service Bus Host test successful on port [$port]"
                        $cSbResult.Status = 'Successful'
                    }
                    $results += $cSbResult

                    <# Test Azure Service Bus Hostname connection #>
                    foreach ($sbHost in $testSBHosts) {
                        $currentSBResult = [Thycotic.PowerShell.DistributedEngines.CloudAccessResult]@{
                            ItemName    = 'Azure Service Bus Hostname'
                            HostAddress = $sbHost.HostAddress
                            Port        = $port
                            Status      = $null
                        }
                        $sbTcp = [System.Net.Sockets.TcpClient]::new()
                        Write-Verbose "Testing Azure Service Bus hostname: [$($sbHost.HostAddress)]"
                        if ($sbTcp.ConnectAsync($sbHost.HostAddress,$port).Wait([timespan]::FromSeconds($Timeout))) {
                            Write-Warning "Azure Service Bus hostname test failed on port [$port]"
                            $currentSBResult.Status = 'Failed'
                        } else {
                            Write-Verbose "Azure Service Bus hostname test successful on port [$port]"
                            $currentSBResult.Status = 'Successful'
                        }
                        $sbTcp.Close()
                        $sbTcp.Dispose()
                        $results += $currentSBResult
                    }
                }
            } else {
                Write-Warning "Unable to retrieve Site Connector details"
            }
            <# Test Domain IPs #>
            foreach ($domainIP in $testDomainIPs) {
                $currentIPResult = [Thycotic.PowerShell.DistributedEngines.CloudAccessResult]@{
                    ItemName    = 'Secret Server Cloud Domain IP'
                    HostAddress = $domainIP.HostAddress
                    Port        = 443
                    Status      = $null
                }
                $dTcp = [System.Net.Sockets.TcpClient]::new()
                Write-Verbose "Testing Secret Server Cloud Domain IP: [$($domainIP.HostAddress)]"
                if ($dTcp.ConnectAsync($domainIP.HostAddress,443).Wait([timespan]::FromSeconds($Timeout))) {
                    Write-Warning "Secret Server Cloud Domain IP test failed [$($domainIP.HostAddress)]"
                    $currentIPResult.Status = 'Failed'
                } else {
                    Write-Verbose "Secret Server Cloud Domain IP test successful [$($domainIP.HostAddress)]"
                    $currentIPResult.Status = 'Successful'
                }
                $dTcp.Close()
                $dTcp.Dispose()
                $results += $currentIPResult
            }
            $results | Sort-Object ItemName
        } else {
            Write-Warning "No valid session found"
        }
    }
}