using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.RecordedSessions
{
    public class SecretSessionSummary
    {
        public bool Active { get; set; }
        public DateTime? EndDate { get; set; }
        public int? LauncherTypeId { get; set; }
        public string MachineName { get; set; }
        public bool PlaybackCompatible { get; set; }
        public int SecretId { get; set; }
        public string SecretName { get; set; }
        public int SecretSessionId { get; set; }
        public DateTime? StartDate { get; set; }
        public int UserId { get; set; }
        public string UserName { get; set; }
    }
}
