using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using Thycotic.PowerShell.Enums;

namespace Thycotic.PowerShell.EventPipeline
{
    public class TaskView
    {
        public EventEntityType EventEntityTypeId { get; set; }
        public string EventPipelineTaskDescription { get; set; }
        public string EventPipelineTaskDisplayName { get; set; }
        public int EventPipelineTaskId { get; set; }
        public int EventPipelineTaskMapId { get; set; }
        public string EventPipelineTaskName { get; set; }
        public bool IsMultiSelect { get; set; }
        public TaskSetting[] Settings { get; set; }
        public int SortOrder { get; set; }
    }
}