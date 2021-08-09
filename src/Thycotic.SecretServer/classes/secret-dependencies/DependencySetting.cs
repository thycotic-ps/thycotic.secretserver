using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretDependencies
{
    public class DependencySetting
    {
        public string changerSettingValue { get; set; }
        public Setting[] Setting { get; set; }
        public int settingId { get; set; }
        public string SettingName { get; set; }
        public string SettingValue { get; set; }
    }
}