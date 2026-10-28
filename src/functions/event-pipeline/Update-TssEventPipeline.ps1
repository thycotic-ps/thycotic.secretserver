function Update-TssEventPipeline {
    <#
    .SYNOPSIS
    Update an event pipeline

    .DESCRIPTION
    Updates an existing event pipeline. Only the parameters provided are changed.
    TriggerActionId, Task and Filter each replace the whole set of triggers, tasks or filters of the pipeline.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Event pipeline ID

    .PARAMETER Name
    New event pipeline name

    .PARAMETER Description
    New event pipeline description

    .PARAMETER Active
    Set the pipeline active (-Active) or inactive (-Active:$false)

    .PARAMETER TriggerActionId
    Event action IDs that trigger the pipeline (EventActionId from Get-TssEventPipelineTriggerOption). Replaces the current triggers

    .PARAMETER Task
    Tasks to run, in order. Each item is a hashtable or object with EventPipelineTaskId (required), EventPipelineTaskName, SortOrder and Settings (hashtable of setting name to value). Output of Get-TssEventPipelineTaskOption can be used as items. Replaces the current tasks

    .PARAMETER Filter
    Filters the event must pass, in order. Each item is a hashtable or object with EventPipelineFilterId (required), EventPipelineFilterName, SortOrder and Settings (hashtable of setting name to value). Replaces the current filters

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssEventPipeline -TssSession $session -Id 12 -Name 'Audit approvals (secrets)' -Description 'Writes an audit entry on approval'

    Renames pipeline 12 and sets its description; triggers, tasks and filters are unchanged

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssEventPipeline -TssSession $session -Id 12 -Active:$false

    Deactivates pipeline 12

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipelines/Update-TssEventPipeline

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline/Update-TssEventPipeline.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.EventPipeline.List')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('EventPipelineId')]
        [int]
        $Id,

        [Alias('EventPipelineName')]
        [string]
        $Name,

        [Alias('EventPipelineDescription')]
        [string]
        $Description,

        [switch]
        $Active,

        [Alias('EventActionId')]
        [int[]]
        $TriggerActionId,

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
            $uri = $TssSession.ApiUrl, 'event-pipeline', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $settingsOf = {
                param($source)
                $pairs = if ($source -is [System.Collections.IDictionary]) { $source.GetEnumerator() } elseif ($source -and $source.GetType().FullName -eq 'System.Management.Automation.PSCustomObject') { $source.PSObject.Properties }
                foreach ($pair in $pairs) {
                    @{ settingName = @{ dirty = $true; value = [string]$pair.Name }; settingValue = @{ dirty = $true; value = [string]$pair.Value } }
                }
            }
            $body = @{
                data = @{
                    triggers = @{ dirty = $false; value = @() }
                    tasks    = @{ dirty = $false; value = @() }
                    filters  = @{ dirty = $false; value = @() }
                }
            }
            switch ($tssParams.Keys) {
                'Name' {
                    $body.data.Add('eventPipelineName', @{ dirty = $true; value = $Name })
                }
                'Description' {
                    $body.data.Add('eventPipelineDescription', @{ dirty = $true; value = $Description })
                }
                'Active' {
                    $body.data.Add('active', @{ dirty = $true; value = [boolean]$Active })
                }
                'TriggerActionId' {
                    $triggers = foreach ($actionId in $TriggerActionId) {
                        @{ eventActionId = @{ dirty = $true; value = $actionId } }
                    }
                    $body.data.triggers = @{ dirty = $true; value = @($triggers) }
                }
                'Task' {
                    $tasks = for ($i = 0; $i -lt $Task.Count; $i++) {
                        $item = $Task[$i]
                        $taskMap = @{
                            eventPipelineTaskId   = @{ dirty = $true; value = [int]$item.EventPipelineTaskId }
                            eventPipelineTaskName = @{ dirty = $true; value = [string]$item.EventPipelineTaskName }
                            sortOrder             = @{ dirty = $true; value = $(if ($item.SortOrder -gt 0) { [int]$item.SortOrder } else { $i + 1 }) }
                            settings              = @{ dirty = $true; value = @(& $settingsOf $item.Settings) }
                        }
                        if ($item.EventPipelineTaskMapId -gt 0) {
                            $taskMap.eventPipelineTaskMapId = @{ dirty = $true; value = [int]$item.EventPipelineTaskMapId }
                        }
                        $taskMap
                    }
                    $body.data.tasks = @{ dirty = $true; value = @($tasks) }
                }
                'Filter' {
                    $filters = for ($i = 0; $i -lt $Filter.Count; $i++) {
                        $item = $Filter[$i]
                        $filterMap = @{
                            eventPipelineFilterId   = @{ dirty = $true; value = [int]$item.EventPipelineFilterId }
                            eventPipelineFilterName = @{ dirty = $true; value = [string]$item.EventPipelineFilterName }
                            sortOrder               = @{ dirty = $true; value = $(if ($item.SortOrder -gt 0) { [int]$item.SortOrder } else { $i + 1 }) }
                            settings                = @{ dirty = $true; value = @(& $settingsOf $item.Settings) }
                        }
                        if ($item.EventPipelineFilterMapId -gt 0) {
                            $filterMap.eventPipelineFilterMapId = @{ dirty = $true; value = [int]$item.EventPipelineFilterMapId }
                        }
                        $filterMap
                    }
                    $body.data.filters = @{ dirty = $true; value = @($filters) }
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Event pipeline: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssEventPipeline request'
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
