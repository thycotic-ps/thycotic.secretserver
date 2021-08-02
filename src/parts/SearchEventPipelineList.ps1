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
                            EventPipelineFilterMapId             = $setting.EventPipelineFilterMapId.value
                            EventPipelineFilterSettingValueMapId = $setting.EventPipelineFilterSettingValueMapId.value
                            OverrideDefault                      = $setting.OverrideDefault.value
                            SettingDisplay                       = $setting.SettingDisplay.value
                            SettingDisplayValue                  = $setting.SettingDisplayValue.value
                            SettingId                            = $setting.SettingId.value
                            SettingValue                         = $setting.SettingValue.value
                            UsingDefault                         = $setting.UsingDefault.value
                        }
                    }
                }
                $filterLists += [Thycotic.PowerShell.EventPipeline.FilterView]@{
                    EventEntityTypeId              = if (-not $filter.EventEntityTypeId.value) { 0 } else { $filter.EventEntityTypeId.value }
                    EventPipelineFilterDescription = $filter.EventPipelineFilterDescription.value
                    EventPipelineFilterDisplayName = $filter.EventPipelineFilterDisplayName.value
                    EventPipelineFilterId          = $filter.EventPipelineFilterId.value
                    EventPipelineFilterMapId       = $filter.EventPipelineFilterMapId.value
                    EventPipelineFilterName        = $filter.EventPipelineFilterName.value
                    Settings                       = $filterSettings
                    SortOrder                      = $filter.SortOrder.value
                }
            }
        }
        if ($pipeline.taskList) {
            $taskLists = @()
            foreach ($task in $pipeline.taskList) {
                $taskSettings = @()
                if ($task.settings.value) {
                    foreach ($setting in $task.settings.value) {
                        $taskSettings += [Thycotic.PowerShell.EventPipeline.TaskSetting]@{
                            EventPipelineTaskMapId             = $setting.EventPipelineTaskMapId.value
                            EventPipelineTaskSettingValueMapId = $setting.EventPipelineTaskSettingValueMapId.value
                            OverrideDefault                    = $setting.OverrideDefault.value
                            SettingDisplay                     = $setting.SettingDisplay.value
                            SettingDisplayValue                = $setting.SettingDisplayValue.value
                            SettingId                          = $setting.SettingId.value
                            SettingValue                       = $setting.SettingValue.value
                            UsingDefault                       = $setting.UsingDefault.value
                        }
                    }
                }
                $taskLists = [Thycotic.PowerShell.EventPipeline.TaskView]@{
                    EventEntityTypeId            = if (-not $task.EventEntityTypeId.value) { 0 } else { $task.EventEntityTypeId.value }
                    EventPipelineTaskDescription = $task.EventPipelineTaskDescription.value
                    EventPipelineTaskDisplayName = $task.EventPipelineTaskDisplayName.value
                    EventPipelineTaskId          = $task.EventPipelineTaskId.value
                    EventPipelineTaskMapId       = $task.EventPipelineTaskMapId.value
                    EventPipelineTaskName        = $task.EventPipelineTaskName.value
                    IsMultiSelect                = $task.IsMultiSelect.value
                    Settings                     = $taskSettings
                    SortOrder                    = $task.SortOrder.value
                }
            }
        }
        if ($pipeline.triggers) {
            $triggerLists = @()
            foreach ($trigger in $pipeline.triggers) {
                $triggerLists = [Thycotic.PowerShell.EventPipeline.TriggerView]@{
                    EntityTypeDisplayName  = $trigger.EntityTypeDisplayName.value
                    EventActionId          = $trigger.EventActionId.value
                    EventEntityTypeId      = $trigger.EventEntityTypeId.value
                    EventPipelineId        = $trigger.EventPipelineId.value
                    EventPipelineTriggerId = $trigger.EventPipelineTriggerId.value
                    TriggerDisplayName     = $trigger.TriggerDisplayName.value
                }
            }
        }
        [Thycotic.PowerShell.EventPipeline.List] @{
            Active                   = $pipeline.active.value
            CreatedDate              = $pipeline.createdDate.value
            EventEntityTypeId        = if ([int]$pipeline.eventEntityTypeId -gt 0) { $pipeline.eventEntityTypeId } else { 0 }
            EventPipelineDescription = $pipeline.eventPipelineDescription.value
            EventPipelineId          = $pipeline.eventPipelineId
            EventPipelineName        = $pipeline.eventPipelineName.value
            EventPipelinePolicyId    = $pipeline.eventPipelinePolicyId
            EventPipelinePolicyMapId = if (-not $pipeline.eventPipelinePolicyMapId) { 0 } else { $pipeline.eventPipelinePolicyMapId }
            FilterList               = $filterLists
            IsSystem                 = $pipeline.isSystem
            LastModifiedDate         = $pipeline.lastModifiedDate.value
            LastModifiedDisplayName  = $pipeline.lastModifiedDisplayName.value
            SortOrder                = $pipeline.sortOrder.value
            TaskList                 = $taskLists
            Triggers                 = $triggerLists
        }
    }
}