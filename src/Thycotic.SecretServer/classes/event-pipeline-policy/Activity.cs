using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using Thycotic.PowerShell.Enums;

namespace Thycotic.PowerShell.EventPipelinePolicy
{
    public class Activity
    {
        public string Duration { get; set; }
        public DateTime? EndDateTime { get; set; }
        public string EventAction { get; set; }
        public string EventEntityType { get; set; }
        public string EventPipelineDescription { get; set; }
        public int EventPipelineId { get; set; }
        public string EventPipelineName { get; set; }
        public string EventPipelinePolicyRunId { get; set; }
        public string EventPipelineTaskDescription { get; set; }
        public int EventPipelineTaskId { get; set; }
        public string EventPipelineTaskName { get; set; }
        public int ItemId { get; set; }
        public string ItemName { get; set; }
        public string Notes { get; set; }
        public DateTime? QueuedDateTime { get; set; }
        public int RunOrder { get; set; }
        public DateTime? StartDateTime { get; set; }
        public EventPipelineStatus Status { get; set; }
    }
}