function New-TssEventPipeline {
    <#
    .SYNOPSIS
    Create a new event pipeline

    .DESCRIPTION
    Creates an event pipeline with its triggers, tasks and optional filters, and adds it to an event pipeline policy when EventPipelinePolicyId is given.
    Trigger event action IDs come from Get-TssEventPipelineTriggerOption, task definitions from Get-TssEventPipelineTaskOption and filter definitions from Get-TssEventPipelineFilterOption.
    A task that has settings (Get-TssEventPipelineTaskSetting) must be given a value for each of them in its Settings hashtable.
    Without -Active the pipeline is created inactive.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER EventPipelinePolicyId
    Event pipeline policy to add the pipeline to

    .PARAMETER EventEntityType
    Entity type the pipeline acts on, such as Secret, User or Group. Must match the policy

    .PARAMETER Name
    Event pipeline name

    .PARAMETER Description
    Event pipeline description

    .PARAMETER Active
    Create the pipeline active. Without it the pipeline is created inactive

    .PARAMETER TriggerActionId
    Event action IDs that trigger the pipeline (EventActionId from Get-TssEventPipelineTriggerOption)

    .PARAMETER Task
    Tasks to run, in order. Each item is a hashtable or object with EventPipelineTaskId (required), EventPipelineTaskName, SortOrder and Settings (hashtable of setting name to value). Output of Get-TssEventPipelineTaskOption can be used as items

    .PARAMETER Filter
    Filters the event must pass, in order. Each item is a hashtable or object with EventPipelineFilterId (required), EventPipelineFilterName, SortOrder and Settings (hashtable of setting name to value)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $task = @{ EventPipelineTaskId = 35; EventPipelineTaskName = 'AddCustomAudit'; Settings = @{ Comment = 'Access approved' } }
    New-TssEventPipeline -TssSession $session -EventPipelinePolicyId 3 -EventEntityType Secret -Name 'Audit approvals' -TriggerActionId 10044 -Task $task -Active

    Creates an active pipeline in policy 3 that writes a custom audit entry when access to a secret is approved

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $deactivate = Get-TssEventPipelineTaskOption -TssSession $session -EventEntityType Secret | Where-Object EventPipelineTaskName -eq 'Deactivate'
    New-TssEventPipeline -TssSession $session -EventEntityType Secret -Name 'Deactivate on expiry' -TriggerActionId 10010 -Task $deactivate

    Creates an inactive pipeline, outside any policy, that deactivates a secret when the trigger fires

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipelines/New-TssEventPipeline

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline/New-TssEventPipeline.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.EventPipeline.List')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Alias('PolicyId')]
        [int]
        $EventPipelinePolicyId,

        [Parameter(Mandatory)]
        [Alias('EventEntityTypeId')]
        [Thycotic.PowerShell.Enums.EventEntityType]
        $EventEntityType,

        [Parameter(Mandatory)]
        [Alias('EventPipelineName')]
        [string]
        $Name,

        [Alias('EventPipelineDescription')]
        [string]
        $Description,

        [switch]
        $Active,

        [Parameter(Mandatory)]
        [Alias('EventActionId')]
        [int[]]
        $TriggerActionId,

        [Parameter(Mandatory)]
        [object[]]
        $Task,

        [object[]]
        $Filter
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'event-pipeline' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $settingsOf = {
                param($source)
                $pairs = if ($source -is [System.Collections.IDictionary]) { $source.GetEnumerator() } elseif ($source -and $source.GetType().FullName -eq 'System.Management.Automation.PSCustomObject') { $source.PSObject.Properties }
                foreach ($pair in $pairs) {
                    @{ settingName = @{ dirty = $true; value = [string]$pair.Name }; settingValue = @{ dirty = $true; value = [string]$pair.Value } }
                }
            }
            $triggers = foreach ($actionId in $TriggerActionId) {
                @{ eventActionId = @{ dirty = $true; value = $actionId } }
            }
            $tasks = for ($i = 0; $i -lt $Task.Count; $i++) {
                $item = $Task[$i]
                @{
                    eventPipelineTaskId   = @{ dirty = $true; value = [int]$item.EventPipelineTaskId }
                    eventPipelineTaskName = @{ dirty = $true; value = [string]$item.EventPipelineTaskName }
                    sortOrder             = @{ dirty = $true; value = $(if ($item.SortOrder -gt 0) { [int]$item.SortOrder } else { $i + 1 }) }
                    settings              = @{ dirty = $true; value = @(& $settingsOf $item.Settings) }
                }
            }
            $filters = for ($i = 0; $i -lt $Filter.Count; $i++) {
                $item = $Filter[$i]
                @{
                    eventPipelineFilterId   = @{ dirty = $true; value = [int]$item.EventPipelineFilterId }
                    eventPipelineFilterName = @{ dirty = $true; value = [string]$item.EventPipelineFilterName }
                    sortOrder               = @{ dirty = $true; value = $(if ($item.SortOrder -gt 0) { [int]$item.SortOrder } else { $i + 1 }) }
                    settings                = @{ dirty = $true; value = @(& $settingsOf $item.Settings) }
                }
            }
            $body = @{
                eventEntityTypeId = [int]$EventEntityType
                data              = @{
                    eventPipelineName        = @{ dirty = $true; value = $Name }
                    eventPipelineDescription = @{ dirty = $true; value = [string]$Description }
                    active                   = @{ dirty = $true; value = [boolean]$Active }
                    triggers                 = @{ dirty = $true; value = @($triggers) }
                    tasks                    = @{ dirty = $true; value = @($tasks) }
                    filters                  = @{ dirty = $true; value = @($filters) }
                }
            }
            switch ($tssParams.Keys) {
                'EventPipelinePolicyId' {
                    $body.Add('eventPipelinePolicyId', $EventPipelinePolicyId)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Event pipeline", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssEventPipeline request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    . $GetEventPipelineList $restResponse
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
