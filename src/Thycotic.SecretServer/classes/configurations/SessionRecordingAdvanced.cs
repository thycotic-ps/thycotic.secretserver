using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class SessionRecordingAdvanced
    {
        public string AgentCallbackUrl { get; set; }
        public bool EnableAdvancedSessionRecording { get; set; }
    }
}
