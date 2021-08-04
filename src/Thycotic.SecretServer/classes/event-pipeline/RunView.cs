using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using Thycotic.PowerShell.Enums;

namespace Thycotic.PowerShell.EventPipeline
{
    public class RunView
    {
        public string Description { get; set; }
        public string Duration { get; set; }
        public DateTime? EndDate { get; set; }
        public string EntityTypeName { get; set; }
        public DateTime? EventDateTime { get; set; }
        public string EventDetails { get; set; }
        public string EventName { get; set; }
        public int EventPipelineId { get; set; }
        public string EventPipelinePolicyRunId { get; set; }
        public int ItemId { get; set; }
        public string ItemName { get; set; }
        public string Name { get; set; }
        public DateTime? QueuedDate { get; set; }
        public DateTime? StartDate { get; set; }
        public EventPipelineStatus Status { get; set; }
    }
}