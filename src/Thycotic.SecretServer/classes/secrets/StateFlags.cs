using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Secrets
{
    public class StateFlags
    {
        public bool HeartbeatInUse { get; set; }
        public string HeartbeatStatus { get; set; }
        public string PasswordChangeState { get; set; }
        public string PasswordCompliance { get; set; }
        public int SecretId { get; set; }
    }
}
