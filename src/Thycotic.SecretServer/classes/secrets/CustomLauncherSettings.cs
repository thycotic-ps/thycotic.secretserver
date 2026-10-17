using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Secrets
{
    public class CustomLauncherSettings
    {
        public object[] AssociatedSecrets { get; set; }
        public int LauncherId { get; set; }
        public string LauncherName { get; set; }
    }
}
