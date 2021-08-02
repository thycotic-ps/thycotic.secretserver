using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using Thycotic.PowerShell.Enums;

namespace Thycotic.PowerShell.EventPipeline
{
    public class FilterSetting
    {
        public int EventPipelineFilterSettingValueMapId { get; set; }
        public int EventPipelineFilterMapId { get; set; }
        public bool OverrideDefault { get; set; }
        public string SettingDisplay { get; set; }
        public string SettingDisplayValue { get; set; }
        public int SettingId { get; set; }
        public string SettingValue { get; set; }
        public bool UsingDefault { get; set; }
    }
}