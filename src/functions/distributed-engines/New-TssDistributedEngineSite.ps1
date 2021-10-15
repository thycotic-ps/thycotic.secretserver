function New-TssDistributedEngineSite {
    <#
    .SYNOPSIS
    Create a new Site

    .DESCRIPTION
    Create a new Site.
    Note that on-premises requires a Site Connector to create a site. Secret Server Cloud subscriptions do not.

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/New-TssDistributedEngineSite

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/New-TssDistributedEngineSite.ps1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://tenant.secretservercloud.com -Credential $ssCred
    New-TssDistributedEngineSite -TssSession $session -SiteName 'New Site 1'

    Create a new Site in SSC subscription called "New Site 1"

    .EXAMPLE
    $session = New-TssSession -SecretServer https://tenant.secretservercloud.com -Credential $ssCred
    New-TssDistributedEngineSite -TssSession $session -SiteName 'New Site 2' -Active:$false

    Create a new Site in SSC subscription called "New Site 2" and disable it upon creation.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://vault.local/SecretServer -Credential $ssCred
    New-TssDistributedEngineSite -TssSession $session -SiteName 'Dev Network' -SiteConnector 4

    Create a new Site called "Dev Network", assigning Site Connector 4

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.DistributedEngines.Site')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Site Name
        [Parameter(Mandatory,ValueFromPipeline)]
        [string]
        $SiteName,

        # Activate/Disable the Site upon creation
        [switch]
        $Active,

        # Engine callbank interval in seconds, default 300
        [int]
        $CallbackInterval = 300,

        # Site Connector ID
        [int]
        $SiteConnectorId,

        # WinRM Endpoint URL, defaults to [http://localhost:5985/wsman]
        [string]
        $WinRmEndpoint = 'http://localhost:5985/wsman',

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
        $SshProxyPort
    )
    begin {
        $tssNewParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssNewParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'distributed-engine', 'site' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'

            $newBody = @{ data = @{} }
            $newBody.data.Add('heartbeatInterval',$CallbackInterval)
            $newBody.data.Add('winRmEndPointUrl',$WinRmEndPoint)
            switch ($tssNewParams.Keys) {
                'TssSession' { <# do nothing, added for performance #> }
                'SiteName' { $newBody.data.Add('siteName',$SiteName) }
                'Active' { $newBody.data.Add('active',[boolean]$Active) }
                'SiteConnectorId' { $newBody.data.Add('siteConnectorId',$SiteConnectorId) }
                'EnableCredSsp' { $newBody.data.Add('enableCredSspForWinRm',[boolean]$EnableCredSsp) }
                'EnableRdpProxy' { $newBody.data.Add('enableRdpProxy',[boolean]$EnableRdpProxy) }
                'RdpProxyPort' { $newBody.data.Add('rdpProxyPort',$rdpProxyPort) }
                'PowerShellRunAsSecret' { $newBody.data.Add('powershellSecretId',$PowerShellRunAsSecret) }
                'EnableSshProxy' { $newBody.data.Add('enableSshProxy',[boolean]$EnableSshProxy) }
                'SshProxyPort' { $newBody.data.Add('sshProxyPort',$SshProxyPort) }
            }
            $invokeParams.Body = ($newBody | ConvertTo-Json)

            Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri) with:`n $newBody"
            if (-not $PSCmdlet.ShouldProcess("Reference $SiteName", "$($invokeParams.Method) $($invokeParams.Uri) with $($invokeParams.Body)")) { return }
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning "Issue creating Reference [SiteName]"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                [Thycotic.PowerShell.DistributedEngines.Site]$restResponse
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}