function Get-TssDistributedEngineSettings {
    <#
    .SYNOPSIS
    Get the feature settings of a Distributed Engine or the default settings of a site

    .DESCRIPTION
    Gets the engine settings that control which kinds of work a Distributed Engine processes (directory sync, password changing, discovery, proxies, workflow and more) and its log level.
    With -EngineId returns the settings of each engine. Reading an engine that has no settings of its own saves a copy of its site's default settings as that engine's settings and returns them with the new EngineSettingsId.
    An ID that matches no engine returns the built-in defaults with EngineSettingsId 0 and saves nothing.
    With -SiteId returns the default settings applied to engines on each site. Reading a site that has no default settings saves the built-in defaults for that site.
    Each feature property has Enabled, Display and CanEdit.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER EngineId
    Distributed Engine ID

    .PARAMETER SiteId
    Site ID, for the default settings of the engines on that site

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDistributedEngineSettings -TssSession $session -EngineId 7

    Gets the settings of Distributed Engine 7

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDistributedEngineSettings -TssSession $session -SiteId 1 | Select-Object EngineSettingsId, @{n='SshProxy';e={$_.SshProxyEnabled.Enabled}}

    Gets the default engine settings of site 1 and shows whether SSH proxy work is enabled

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Get-TssDistributedEngineSettings

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Get-TssDistributedEngineSettings.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'Engine')]
    [OutputType('Thycotic.PowerShell.DistributedEngines.EngineSettings')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'Engine')]
        [int[]]
        $EngineId,

        [Parameter(Mandatory, ParameterSetName = 'Site')]
        [int[]]
        $SiteId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '11.0.000000' $PSCmdlet.MyInvocation
            $ids = if ($PSCmdlet.ParameterSetName -eq 'Site') { $SiteId } else { $EngineId }
            foreach ($currentId in $ids) {
                $restResponse = $null
                switch ($PSCmdlet.ParameterSetName) {
                    'Site' {
                        $uri = $TssSession.ApiUrl, 'distributed-engine', 'engine-settings', 'site', $currentId -join '/'
                    }
                    default {
                        $uri = $TssSession.ApiUrl, 'distributed-engine', 'engine-settings', $currentId -join '/'
                    }
                }
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssDistributedEngineSettings request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.DistributedEngines.EngineSettings](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.DistributedEngines.EngineSettings]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
