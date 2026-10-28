function Get-TssEventPipelineTaskSetting {
    <#
    .SYNOPSIS
    Get the settings of an event pipeline task

    .DESCRIPTION
    Returns the settings a task definition takes, with their default values. Setting.SettingName is the key to use in the Settings hashtable of a New-TssEventPipeline or Update-TssEventPipeline task.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Event pipeline task ID (EventPipelineTaskId from Get-TssEventPipelineTaskOption)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssEventPipelineTaskSetting -TssSession $session -Id 35

    Returns the settings of task 35

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssEventPipelineTaskOption -TssSession $session -EventEntityType Secret | Where-Object EventPipelineTaskName -eq 'AddCustomAudit' | Get-TssEventPipelineTaskSetting -TssSession $session

    Returns the settings of the AddCustomAudit task

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipelines/Get-TssEventPipelineTaskSetting

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline/Get-TssEventPipelineTaskSetting.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.EventPipeline.TaskSettingMap[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('EventPipelineTaskId')]
        [int[]]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'event-pipeline-settings', 'task-settings', 'list', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssEventPipelineTaskSetting request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.EventPipeline.TaskSettingMap[]](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.EventPipeline.TaskSettingMap]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
