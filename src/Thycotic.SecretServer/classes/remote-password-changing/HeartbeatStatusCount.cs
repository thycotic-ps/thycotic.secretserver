using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Rpc
{
    public class HeartbeatStatusCount
    {
        public string HeartbeatStatus { get; set; }
        public int Total { get; set; }
    }
}
