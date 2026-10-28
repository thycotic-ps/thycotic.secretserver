using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.RecordedSessions
{
    public class PointOfInterestSummary
    {
        public string ActivityTypeGroup { get; set; }
        public string LauncherSessionGuid { get; set; }
        public int Score { get; set; }
        public long SecondsFromStart { get; set; }
        public int SecretSessionId { get; set; }
        public string TimestampOffset { get; set; }
    }
}
