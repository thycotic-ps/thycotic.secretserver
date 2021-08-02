using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using Thycotic.PowerShell.Enums;

namespace Thycotic.PowerShell.EventPipeline
{
    public class Summary
    {
        public bool Active { get; set; }
        public DateTime? CreatedDate { get; set; }
        public EventEntityType EventEntityTypeId { get; set; }
        public string EventPipelineDescription { get; set; }
        public int EventPipelineId { get; set; }
        public string EventPipelineName { get; set; }
        public int EventPipelinePolicyId { get; set; }
        public int EventPipelinePolicyMapId { get; set; }
        public bool IsSystem { get; set; }
        public DateTime? LastModifiedDate { get; set; }
        public string LastModifiedDisplayName { get; set; }
        public int SortOrder { get; set; }
    }
}