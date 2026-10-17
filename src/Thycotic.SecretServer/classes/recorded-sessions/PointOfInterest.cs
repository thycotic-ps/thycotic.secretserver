using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.RecordedSessions
{
    public class PointOfInterest
    {
        public string ActivityDetails { get; set; }
        public string ActivityTitle { get; set; }
        public string ActivityType { get; set; }
        public string ActivityTypeDisplayName { get; set; }
        public string Icon { get; set; }
        public string LauncherSessionGuid { get; set; }
        public int? SecretId { get; set; }
        public int? SecretSessionId { get; set; }
        public DateTime? Timestamp { get; set; }
        public string TimestampOffset { get; set; }
        public string TimestampOffsetDisplay { get; set; }
    }
}
