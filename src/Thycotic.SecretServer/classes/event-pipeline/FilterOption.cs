using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.EventPipeline
{
    public class FilterOption
    {
        public int? EventEntityTypeId { get; set; }
        public string EventPipelineFilterDescription { get; set; }
        public string EventPipelineFilterDisplayName { get; set; }
        public int EventPipelineFilterId { get; set; }
        public int EventPipelineFilterMapId { get; set; }
        public string EventPipelineFilterName { get; set; }
        public int SortOrder { get; set; }
    }
}
