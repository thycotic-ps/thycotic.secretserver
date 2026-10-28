using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.EventPipeline
{
    public class FilterSettingMap
    {
        public int EventPipelineFilterId { get; set; }
        public int EventPipelineFilterSettingMapId { get; set; }
        public PSObject Setting { get; set; }
        public string SettingDisplay { get; set; }
        public int SettingId { get; set; }
        public string SettingValue { get; set; }
        public int SortOrder { get; set; }
        public bool UsingDefault { get; set; }
    }
}
