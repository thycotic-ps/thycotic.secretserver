using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using Thycotic.PowerShell.Enums;

namespace Thycotic.PowerShell.Secrets
{
    public class HeartbeatStatus
    {
        public HeartbeatStatus Status { get; set; }
        public DateTime? LastHeartbeatCheck { get; set; }
    }
}