using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.RecordedSessions
{
    public class SshSession
    {
        public object[] Data { get; set; }
        public int SecretSessionId { get; set; }
    }
}
