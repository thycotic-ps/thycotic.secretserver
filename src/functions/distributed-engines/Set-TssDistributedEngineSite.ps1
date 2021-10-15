function Set-TssDistributedEngineSite {
    <#
    .SYNOPSIS
    Adjust Site configuration options

    .DESCRIPTION
    Adjust Site configuration options

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssDistributedEngineSite -TssSession session -Id 5 -EnableCredSsp:$false

    Disable CredSSP for Site ID 5

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssDistributedEngineSite -TssSession session -Id 10 -Active:$false

    Disable Site 10

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Set-TssDistributedEngineSite

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Set-TssDistributedEngineSite.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess)]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Site ID(s)
        [Parameter(Mandatory,ValueFromPipeline,Position = 1)]
        [Alias('SiteId')]
        [int[]]
        $Id,

        # Site Name
        [string]
        $SiteName,

        # Activate the Site
        [switch]
        $Active,

        # WinRM Endpoint URL
        [string]
        $WinRmEndpoint,

        # Enable or Disable CredSSP
        [switch]
        $EnableCredSsp,

        # Set Default PowerShell RunAs Secret ID
        [int]
        $PowerShellRunAsSecret,

        # Enable or Disable RDP Proxy
        [switch]
        $EnableRdpProxy,

        # Set RDP Proxy Port
        [int]
        $RdpProxyPort,

        # Enable or Disable SSH Proxy
        [switch]
        $EnableSshProxy,

        # Set SSH Proxy Port
        [int]
        $SshProxyPort,

        # Engine callbank interval in seconds (range: 30 - 300)
        [ValidateRange(30,300)]
        [int]
        $CallbackInterval,

        # Site Connector ID
        [int]
        $SiteConnectorId
    )
    begin {
        $setParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($setParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            foreach ($site in $Id) {
                $uri = $TssSession.ApiUrl, 'distributed-engine', 'site', $site -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'PATCH'

                $setBody = @{ data = @{ } }
                switch ($setParams.Keys) {
                    'TssSession' { <# do nothing, added for performance #> }
                    'Active' {
                        $activeValue = @{
                            dirty = $true
                            value = [boolean]$Active
                        }
                        $setBody.data.Add('active',$activeValue)
                    }
                    'EnableCredSsp' {
                        $credSspValue = @{
                            dirty = $true
                            value = [boolean]$EnableCredSsp
                        }
                        $setBody.data.Add('enableCredSspForWinRm',$credSspValue)
                    }
                    'SiteName' {
                        $siteNameValue = @{
                            dirty = $true
                            value = $SiteName
                        }
                        $setBody.data.Add('siteName',$siteNameValue)
                    }
                    'EnableRdpProxy' {
                        $rdpProxyValue = @{
                            dirty = $true
                            value = [boolean]$EnableRdpProxy
                        }
                        $setBody.data.Add('enableRdpProxy',$rdpProxyValue)
                    }
                    'RdpProxyPort' {
                        $rdpProxyPortValue = @{
                            dirty = $true
                            value = $rdpProxyPort
                        }
                        $setBody.data.Add('rdpProxyPort',$rdpProxyPortValue)
                    }
                    'CallbackInterval' {
                        $hbInterval = @{
                            dirty = $true
                            value = $CallbackInterval
                        }
                        $setBody.data.Add('heartbeatInterval',$hbInterval)
                    }
                    'PowerShellRunAsSecret' {
                        $psRunAs = @{
                            dirty = $true
                            value = $PowerShellRunAsSecret
                        }
                        $setBody.data.Add('powershellSecretId',$psRunAs)
                    }
                    'SiteConnectorId' {
                        $siteConnectorValue = @{
                            dirty = $true
                            value = $SiteConnectorId
                        }
                        $setBody.data.Add('siteConnectorId',$siteConnectorValue)
                    }
                    'EnableSshProxy' {
                        $sshProxyValue = @{
                            dirty = $true
                            value = [boolean]$EnableSshProxy
                        }
                        $setBody.data.Add('enableSshProxy',$sshProxyValue)
                    }
                    'SshProxyPort' {
                        $sshProxyPortValue = @{
                            dirty = $true
                            value = $SshProxyPort
                        }
                        $setBody.data.Add('sshProxyPort',$sshProxyPortValue)
                    }
                    'WinRmEndpoint' {
                        $winRmValue = @{
                            dirty = $true
                            value = $WinRmEndPoint
                        }
                        $setBody.data.Add('winRmEndPointUrl',$winRmValue)
                    }
                }
                $invokeParams.Body = $setBody | ConvertTo-Json -Depth 100

                if ($PSCmdlet.ShouldProcess("Site ID: $site", "$($invokeParams.Method) $($invokeParams.Uri) with:`n$($invokeParams.Body)`n")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri) with:`n$($invokeParams.Body)`n"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue updating Site [$site] configuration"
                        $err = $_
                        . $ErrorHandling $err
                    }
                }
                if ($restResponse) {
                    Write-Verbose 'Setting updated successfully'
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}