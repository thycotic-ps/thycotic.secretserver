using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class SettingsMenu
    {
        public string[] Hidden { get; set; }
        public string PrivilegeManagerLink { get; set; }
    }
}
