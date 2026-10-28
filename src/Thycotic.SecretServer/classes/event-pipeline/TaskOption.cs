using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.EventPipeline
{
    public class TaskOption
    {
        public string EventEntityTypeId { get; set; }
        public string EventPipelineTaskDescription { get; set; }
        public string EventPipelineTaskDisplayName { get; set; }
        public int EventPipelineTaskId { get; set; }
        public int EventPipelineTaskMapId { get; set; }
        public string EventPipelineTaskName { get; set; }
        public bool IsMultiSelect { get; set; }
        public int SortOrder { get; set; }
    }
}
