using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.ConnectionManager
{
    public class Settings
    {
        public bool AllowLocalConnections { get; set; }
        public bool AllowSavingCredentials { get; set; }
        public string DownloadUrl { get; set; }
        public bool HasValidLicense { get; set; }
        public bool IsTrialLicense { get; set; }
    }
}
