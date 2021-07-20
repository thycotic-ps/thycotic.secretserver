using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Secrets
{
    public class HeartbeatStatus
    {
        public string Status { get; set; }
        public DateTime? LastHeartbeatCheck { get; set; }
    }
}