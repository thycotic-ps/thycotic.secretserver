using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Diagnostics
{
    public class AppSetting
    {
        public string Key { get; set; }
        public string Value { get; set; }
    }
}
