function Update-TssLauncherAgent {
    <#
    .SYNOPSIS
    Update a launcher agent

    .DESCRIPTION
    Update the active flag and recording overrides of a launcher agent. The endpoint replaces the whole agent, so the current agent is read first (Get-TssLauncherAgent -IncludeInactive) and every parameter you omit keeps its current value. -InheritRecordingSettings clears both recording overrides so the agent follows its collection. Secret Server rejects updates to an agent whose collection is inactive.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Launcher agent Id

    .PARAMETER Active
    Set the agent active (-Active) or inactive (-Active:$false)

    .PARAMETER RecordKeystrokes
    Override the collection: record keystroke data on this agent (-RecordKeystrokes) or not (-RecordKeystrokes:$false)

    .PARAMETER RecordStandaloneSessions
    Override the collection: record standalone (headless) sessions on this agent (-RecordStandaloneSessions) or not (-RecordStandaloneSessions:$false)

    .PARAMETER InheritRecordingSettings
    Clear both recording overrides so the agent uses the recording settings of its collection

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssLauncherAgent -TssSession $session -Id 3 -Active:$false

    Deactivate launcher agent 3 and keep its recording settings

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssLauncherAgent -TssSession $session -Id 3 -RecordKeystrokes:$false

    Stop keystroke recording on agent 3 regardless of its collection

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssLauncherAgent -TssSession $session -Id 3 -InheritRecordingSettings

    Make agent 3 follow the recording settings of its collection again

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/launcher-agents/Update-TssLauncherAgent

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launcher-agents/Update-TssLauncherAgent.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'override')]
    [OutputType('Thycotic.PowerShell.LauncherAgents.LauncherAgent')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $Id,

        [switch]
        $Active,

        [Parameter(ParameterSetName = 'override')]
        [switch]
        $RecordKeystrokes,

        [Parameter(ParameterSetName = 'override')]
        [switch]
        $RecordStandaloneSessions,

        [Parameter(Mandatory, ParameterSetName = 'inherit')]
        [switch]
        $InheritRecordingSettings
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $current = Get-TssLauncherAgent -TssSession $TssSession -Id $Id -IncludeInactive -ErrorAction Stop
            if (-not $current) {
                throw "Launcher agent $Id was not found"
            }
            $uri = $TssSession.ApiUrl, 'launcheragents', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $body = @{
                id                       = $Id
                active                   = $current.Active
                recordKeystrokes         = $current.RecordKeystrokes
                recordStandaloneSessions = $current.RecordStandaloneSessions
            }
            switch ($tssParams.Keys) {
                'Active' {
                    $body.active = [boolean]$Active
                }
                'RecordKeystrokes' {
                    $body.recordKeystrokes = [boolean]$RecordKeystrokes
                }
                'RecordStandaloneSessions' {
                    $body.recordStandaloneSessions = [boolean]$RecordStandaloneSessions
                }
                'InheritRecordingSettings' {
                    $body.recordKeystrokes = $null
                    $body.recordStandaloneSessions = $null
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Launcher agent: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssLauncherAgent request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.LauncherAgents.LauncherAgent](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.LauncherAgents.LauncherAgent]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
