using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Secrets
{
    public class PasswordStatus
    {
        public string Status { get; set; }
        public DateTime? LastRpcDate { get; set; }
        public string RpcMessage { get; set; }
        public int FailedAttempts { get; set; }
        public DateTime? NextRpcDate { get; set; }
    }
}