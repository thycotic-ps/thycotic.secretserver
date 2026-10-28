function Update-TssLauncherAgentCollection {
    <#
    .SYNOPSIS
    Update a launcher agent collection

    .DESCRIPTION
    Update the name, active flag and recording defaults of a launcher agent collection. The endpoint replaces the whole collection, so the current collection is read first (Get-TssLauncherAgentCollection -IncludeInactive) and every parameter you omit keeps its current value. Secret Server rejects any update to an inactive collection, so -Active:$false cannot be undone through the API.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Launcher agent collection Id

    .PARAMETER Active
    Set the collection active (-Active) or inactive (-Active:$false)

    .PARAMETER Name
    New collection name

    .PARAMETER RecordKeystrokes
    Agents in the collection record keystroke data (-RecordKeystrokes) or not (-RecordKeystrokes:$false)

    .PARAMETER RecordStandaloneSessions
    Agents in the collection record standalone (headless) sessions (-RecordStandaloneSessions) or not (-RecordStandaloneSessions:$false)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssLauncherAgentCollection -TssSession $session -Id 1 -Name 'Jump hosts (EU)'

    Rename launcher agent collection 1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssLauncherAgentCollection -TssSession $session -Id 1 -Active:$false

    Deactivate launcher agent collection 1

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/launcher-agents/Update-TssLauncherAgentCollection

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launcher-agents/Update-TssLauncherAgentCollection.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.LauncherAgents.Collection')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $Id,

        [switch]
        $Active,

        [string]
        $Name,

        [switch]
        $RecordKeystrokes,

        [switch]
        $RecordStandaloneSessions
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $current = Get-TssLauncherAgentCollection -TssSession $TssSession -Id $Id -IncludeInactive -ErrorAction Stop
            if (-not $current) {
                throw "Launcher agent collection $Id was not found"
            }
            $uri = $TssSession.ApiUrl, 'launcheragents', 'collections', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $body = @{
                id                       = $Id
                name                     = $current.Name
                active                   = $current.Active
                recordKeystrokes         = $current.RecordKeystrokes
                recordStandaloneSessions = $current.RecordStandaloneSessions
            }
            switch ($tssParams.Keys) {
                'Active' {
                    $body.active = [boolean]$Active
                }
                'Name' {
                    $body.name = $Name
                }
                'RecordKeystrokes' {
                    $body.recordKeystrokes = [boolean]$RecordKeystrokes
                }
                'RecordStandaloneSessions' {
                    $body.recordStandaloneSessions = [boolean]$RecordStandaloneSessions
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Launcher agent collection: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssLauncherAgentCollection request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.LauncherAgents.Collection](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.LauncherAgents.Collection]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
