using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Secrets
{
    public class RdpLauncherSettings
    {
        public string AllowClipboard { get; set; }
        public string AllowDrives { get; set; }
        public string AllowPrinters { get; set; }
        public string AllowSmartCards { get; set; }
        public string ConnectToConsole { get; set; }
        public int LauncherHeight { get; set; }
        public int LauncherWidth { get; set; }
        public string UseCustomLauncherResolution { get; set; }
    }
}