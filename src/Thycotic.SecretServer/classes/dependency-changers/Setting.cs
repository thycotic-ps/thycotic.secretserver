using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DependencyChangers
{
    public class Setting
    {
        public string DefaultValue { get; set; }
        public int SettingId { get; set; }
        public string SettingName { get; set; }
    }
}
