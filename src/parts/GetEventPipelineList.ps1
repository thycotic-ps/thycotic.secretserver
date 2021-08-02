param(
    [Parameter(Position = 0)]
    [PSCustomObject]$Object
)
process {
    foreach ($pipeline in $Object) {
        if ($pipeline.filterList) {
            $filterLists = @()
            foreach ($filter in $pipeline.filterList) {
                $filterSettings = @()
                if ($filter.settings.value) {
                    foreach ($setting in $filter.settings.value) {
                        $filterSettings += [Thycotic.PowerShell.EventPipeline.FilterSetting]@{
                            EventPipelineFilterMapId             = $setting.EventPipelineFilterMapId
                            EventPipelineFilterSettingValueMapId = $setting.EventPipelineFilterSettingValueMapId
                            OverrideDefault                      = $setting.OverrideDefault
                            SettingDisplay                       = $setting.SettingDisplay
                            SettingDisplayValue                  = $setting.SettingDisplayValue
                            SettingId                            = $setting.SettingId
                            SettingValue                         = $setting.SettingValue
                            UsingDefault                         = $setting.UsingDefault
                        }
                    }
                }
                $filterLists += [Thycotic.PowerShell.EventPipeline.FilterView]@{
                    EventEntityTypeId              = if (-not $filter.EventEntityTypeId) { 0 } else { $filter.EventEntityTypeId }
                    EventPipelineFilterDescription = $filter.EventPipelineFilterDescription
                    EventPipelineFilterDisplayName = $filter.EventPipelineFilterDisplayName
                    EventPipelineFilterId          = $filter.EventPipelineFilterId
                    EventPipelineFilterMapId       = $filter.EventPipelineFilterMapId
                    EventPipelineFilterName        = $filter.EventPipelineFilterName
                    Settings                       = $filterSettings
                    SortOrder                      = $filter.SortOrder
                }
            }
        }
        if ($pipeline.taskList) {
            $taskLists = @()
            foreach ($task in $pipeline.taskList) {
                $taskSettings = @()
                if ($task.settings) {
                    foreach ($setting in $task.settings) {
                        $taskSettings += [Thycotic.PowerShell.EventPipeline.TaskSetting]@{
                            EventPipelineTaskMapId             = $setting.EventPipelineTaskMapId
                            EventPipelineTaskSettingValueMapId = $setting.EventPipelineTaskSettingValueMapId
                            OverrideDefault                    = $setting.OverrideDefault
                            SettingDisplay                     = $setting.SettingDisplay
                            SettingDisplayValue                = $setting.SettingDisplayValue
                            SettingId                          = $setting.SettingId
                            SettingValue                       = $setting.SettingValue
                            UsingDefault                       = $setting.UsingDefault
                        }
                    }
                }
                $taskLists = [Thycotic.PowerShell.EventPipeline.TaskView]@{
                    EventEntityTypeId            = if (-not $task.EventEntityTypeId) { 0 } else { $task.EventEntityTypeId }
                    EventPipelineTaskDescription = $task.EventPipelineTaskDescription
                    EventPipelineTaskDisplayName = $task.EventPipelineTaskDisplayName
                    EventPipelineTaskId          = $task.EventPipelineTaskId
                    EventPipelineTaskMapId       = $task.EventPipelineTaskMapId
                    EventPipelineTaskName        = $task.EventPipelineTaskName
                    IsMultiSelect                = $task.IsMultiSelect
                    Settings                     = $taskSettings
                    SortOrder                    = $task.SortOrder
                }
            }
        }
        if ($pipeline.triggers) {
            $triggerLists = @()
            foreach ($trigger in $pipeline.triggers) {
                $triggerLists = [Thycotic.PowerShell.EventPipeline.TriggerView]@{
                    EntityTypeDisplayName  = $trigger.EntityTypeDisplayName
                    EventActionId          = $trigger.EventActionId
                    EventPipelineId        = $trigger.EventPipelineId
                    EventPipelineTriggerId = $trigger.EventPipelineTriggerId
                    TriggerDisplayName     = $trigger.TriggerDisplayName
                }
            }
        }
        [Thycotic.PowerShell.EventPipeline.List] @{
            Active                   = $pipeline.active
            CreatedDate              = $pipeline.createdDate
            EventEntityTypeId        = if ([int]$pipeline.eventEntityTypeId -gt 0) { $pipeline.eventEntityTypeId } else { 0 }
            EventPipelineDescription = $pipeline.eventPipelineDescription
            EventPipelineId          = $pipeline.eventPipelineId
            EventPipelineName        = $pipeline.eventPipelineName
            EventPipelinePolicyId    = $pipeline.eventPipelinePolicyId
            EventPipelinePolicyMapId = if (-not $pipeline.eventPipelinePolicyMapId) { 0 } else { $pipeline.eventPipelinePolicyMapId }
            FilterList               = $filterLists
            IsSystem                 = $pipeline.isSystem
            LastModifiedDate         = $pipeline.lastModifiedDate
            LastModifiedDisplayName  = $pipeline.lastModifiedDisplayName
            SortOrder                = $pipeline.sortOrder
            TaskList                 = $taskLists
            Triggers                 = $triggerLists
        }
    }
}