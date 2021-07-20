using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Secrets
{
    public class OneTimePasswordSettings
    {
        public string BackupCodes { get; set; }
        public DateTime? DateChanged { get; set; }
        public bool Enabled { get; set; }
        public bool EnabledOnTemplate { get; set; }
        public string Key { get; set; }
    }
}