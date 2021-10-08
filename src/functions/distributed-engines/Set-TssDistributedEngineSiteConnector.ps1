function Set-TssDistributedEngineSiteConnector {
    <#
    .SYNOPSIS
    Set configurations for a Site Connector

    .DESCRIPTION
    Set configurations for a Site Connector

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssDistributedEngineSiteConnector -TssSession session -Id 5 -Enable:$false

    Disable Site Connector ID 5.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssDistributedEngineSiteConnector -TssSession session -Id 10 TransportType RabbitMq -Port 5671 -UseSsl

    Set Site Connector ID 10 queue type to RabbitMq, enable SSL and use port 5671 SSL port.

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Set-TssDistributedEngineSiteConnector

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Set-TssDistributedEngineSiteConnector.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess)]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Site Connector ID(s)
        [int[]]
        $Id,

        # Enable or Disable
        [switch]
        $Enable,

        # Site Connector Name
        [string]
        $Name,

        # Hostname
        [string]
        $Hostname,

        # Use SSL
        [switch]
        $UseSsl,

        # Port number
        [int]
        $Port,

        # Service Bus Transport Type (allowed: MemoryMq, RabbitMq)
        [ValidateSet('MemoryMq','RabbitMq')]
        [string]
        $TransportType
    )
    begin {
        $setParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($setParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            foreach ($connector in $Id) {
                $uri = $TssSession.ApiUrl, 'distributed-engine', 'site-connector', $connector -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'PATCH'

                $setBody = @{ data = @{ } }
                switch ($setParams.Keys) {
                    'Enable' {
                        $enableIt = @{
                            dirty = $true
                            value = [boolean]$Enable
                        }
                        $setBody.data.Add('active',$enableIt)
                    }
                    'Name' {
                        $nameIt = @{
                            dirty = $true
                            value = $Name
                        }
                        $setBody.data.Add('name',$nameIt)
                    }
                    'Hostname' {
                        $hostIt = @{
                            dirty = $true
                            value = $Hostname
                        }
                        $setBody.data.Add('hostName',$hostIt)
                    }
                    'UseSsl' {
                        $sslValue = @{
                            dirty = $true
                            value = [boolean]$UseSsl
                        }
                        $setBody.data.Add('useSsl',$sslValue)
                    }
                    'Port' {
                        $portValue = @{
                            dirty = $true
                            value = $Port
                        }
                        $setBody.data.Add('port',$portValue)
                    }
                    'TransportType' {
                        $transportValue = @{
                            dirty = $true
                            value = $TransportType
                        }
                        $setBody.data.Add('queueType',$transportValue)
                    }
                }
                $invokeParams.Body = $setBody | ConvertTo-Json -Depth 100

                if ($PSCmdlet.ShouldProcess("Site Connector: $connector", "$($invokeParams.Method) $($invokeParams.Uri) with:`n$($invokeParams.Body)`n")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri) with:`n$($invokeParams.Body)`n"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue setting configuration for Site Connector [$connector]"
                        $err = $_
                        . $ErrorHandling $err
                    }
                }
                if ($restResponse) {
                    Write-Verbose "Site Connector [$connector] updated successfully"
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}