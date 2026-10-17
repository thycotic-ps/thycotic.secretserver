function Set-TssDiscoveryConfiguration {
    <#
    .SYNOPSIS
    Set the Discovery configuration

    .DESCRIPTION
    Updates only the settings passed; omitted settings stay unchanged. Returns the updated configuration.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER DependencyNotFoundThreshold
    Number of scans a dependency can be missing before it is removed

    .PARAMETER DiscoveryIntervalDays
    Days between Discovery runs

    .PARAMETER DiscoveryIntervalHours
    Hours between Discovery runs, added to DiscoveryIntervalDays

    .PARAMETER DiscoveryScanOffsetHours
    Hour offset for the Discovery scan schedule

    .PARAMETER EnableDiscovery
    Enable Discovery

    .PARAMETER EngineADDiscoveryBatchSize
    Number of AD objects a distributed engine processes per batch

    .PARAMETER IgnoreClusterNodeObjects
    Ignore cluster node objects during Discovery

    .PARAMETER MaxLogAgeDays
    Days to keep Discovery logs

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssDiscoveryConfiguration -TssSession $session -DiscoveryIntervalDays 1 -DiscoveryIntervalHours 0

    Run Discovery once a day

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssDiscoveryConfiguration -TssSession $session -EnableDiscovery:$false

    Disable Discovery

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Set-TssDiscoveryConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Set-TssDiscoveryConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Discovery.Configuration')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [int]
        $DependencyNotFoundThreshold,

        [int]
        $DiscoveryIntervalDays,

        [int]
        $DiscoveryIntervalHours,

        [int]
        $DiscoveryScanOffsetHours,

        [switch]
        $EnableDiscovery,

        [int]
        $EngineADDiscoveryBatchSize,

        [switch]
        $IgnoreClusterNodeObjects,

        [int]
        $MaxLogAgeDays
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'discovery', 'configuration' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'DependencyNotFoundThreshold' {
                    $body.data.Add('dependencyNotFoundThreshold', @{ dirty = $true; value = $DependencyNotFoundThreshold })
                }
                'DiscoveryIntervalDays' {
                    $body.data.Add('discoveryIntervalDays', @{ dirty = $true; value = $DiscoveryIntervalDays })
                }
                'DiscoveryIntervalHours' {
                    $body.data.Add('discoveryIntervalHours', @{ dirty = $true; value = $DiscoveryIntervalHours })
                }
                'DiscoveryScanOffsetHours' {
                    $body.data.Add('discoveryScanOffsetHours', @{ dirty = $true; value = $DiscoveryScanOffsetHours })
                }
                'EnableDiscovery' {
                    $body.data.Add('enableDiscovery', @{ dirty = $true; value = [boolean]$EnableDiscovery })
                }
                'EngineADDiscoveryBatchSize' {
                    $body.data.Add('engineADDiscoveryBatchSize', @{ dirty = $true; value = $EngineADDiscoveryBatchSize })
                }
                'IgnoreClusterNodeObjects' {
                    $body.data.Add('ignoreClusterNodeObjects', @{ dirty = $true; value = [boolean]$IgnoreClusterNodeObjects })
                }
                'MaxLogAgeDays' {
                    $body.data.Add('maxLogAgeDays', @{ dirty = $true; value = $MaxLogAgeDays })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Discovery configuration", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssDiscoveryConfiguration request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Discovery.Configuration](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Discovery.Configuration]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
