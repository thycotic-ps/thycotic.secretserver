using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DisasterRecovery
{
    public class DataReplicationMessage
    {
        public string Message { get; set; }
        public string Status { get; set; }
        public bool Success { get; set; }
    }
}
