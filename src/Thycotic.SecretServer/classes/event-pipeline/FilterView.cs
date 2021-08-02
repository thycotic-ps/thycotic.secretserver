using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using Thycotic.PowerShell.Enums;

namespace Thycotic.PowerShell.EventPipeline
{
    public class FilterView
    {
        public EventEntityType EventEntityTypeId { get; set; }
        public string EventPipelineFilterDescription { get; set; }
        public string EventPipelineFilterDisplayName { get; set; }
        public int EventPipelineFilterId { get; set; }
        public int EventPipelineFilterMapId { get; set; }
        public string EventPipelineFilterName { get; set; }
        public FilterSetting[] Settings { get; set; }
        public int SortOrder { get; set; }
    }
}