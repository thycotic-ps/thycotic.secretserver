using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.EventPipeline
{
    public class PolicyMap
    {
        public int EventPipelineId { get; set; }
        public int EventPipelinePolicyId { get; set; }
        public int EventPipelinePolicyMapId { get; set; }
        public int SortOrder { get; set; }
    }
}
