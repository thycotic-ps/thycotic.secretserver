using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.RecordedSessions
{
    public class SessionMonitoringConfiguration
    {
        public int DefaultDays { get; set; }
    }
}
