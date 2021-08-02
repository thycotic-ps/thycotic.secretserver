using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using Thycotic.PowerShell.Enums;

namespace Thycotic.PowerShell.EventPipeline
{
    public class TriggerView
    {
        public string EntityTypeDisplayName { get; set; }
        public int EventActionId { get; set; }
        public EventEntityType EventEntityTypeId { get; set; }
        public int EventPipelineId { get; set; }
        public int EventPipelineTriggerId { get; set; }
        public string TriggerDisplayName { get; set; }
    }
}