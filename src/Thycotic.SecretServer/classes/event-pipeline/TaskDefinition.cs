using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.EventPipeline
{
    public class TaskDefinition
    {
        public int? EventEntityTypeId { get; set; }
        public string EventPipelineTaskDescription { get; set; }
        public int EventPipelineTaskId { get; set; }
        public string EventPipelineTaskName { get; set; }
        public bool IsMultiSelect { get; set; }
    }
}
