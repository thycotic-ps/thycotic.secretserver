using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class LauncherSettings
    {
        public bool CheckInSecretOnLastLauncherClose { get; set; }
        public bool CloseLauncherOnCheckInSecret { get; set; }
        public bool EnableDomainDownload { get; set; }
        public bool EnableDomainUpload { get; set; }
        public bool EnableLauncher { get; set; }
        public bool EnableLauncherAutoUpdate { get; set; }
        public bool EnableWebParsing { get; set; }
        public string LauncherDeploymentType { get; set; }
        public bool SendSecretUrlToLauncher { get; set; }
    }
}