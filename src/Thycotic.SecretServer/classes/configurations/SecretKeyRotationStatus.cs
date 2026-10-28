using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class SecretKeyRotationStatus
    {
        public DateTime? LastRequestDate { get; set; }
        public DateTime? LastRunDate { get; set; }
        public string LastStatus { get; set; }
        public string Message { get; set; }
        public PSObject ProgressStatus { get; set; }
    }
}
