using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.EventPipelinePolicy
{
    public class List
    {
        public bool Active { get; set; }
        public DateTime? CreatedDate { get; set; }
        public int EventEntityTypeId { get; set; }
        public string EventPipelinePolicyDescription { get; set; }
        public int EventPipelinePolicyId { get; set; }
        public string EventPipelinePolicyName { get; set; }
        public bool IsSystem { get; set; }
        public DateTime? LastModifiedDate { get; set; }
        public string LastModifiedDisplayName { get; set; }
    }
}