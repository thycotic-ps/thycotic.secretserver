using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.AdvancedConfigSettings
{
    public class Summary
    {
        public int AdvancedSettingId { get; set; }
        public string SettingName { get; set; }
        public string TypeName { get; set; }
        public string Value { get; set; }
    }
}
