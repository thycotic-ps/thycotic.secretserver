using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.EventPipeline
{
    public class TaskSettingMap
    {
        public int EventPipelineTaskId { get; set; }
        public int? EventPipelineTaskSettingMapId { get; set; }
        public PSObject Setting { get; set; }
        public string SettingDisplay { get; set; }
        public int SettingId { get; set; }
        public string SettingValue { get; set; }
        public int SortOrder { get; set; }
        public bool UsingDefault { get; set; }
    }
}
