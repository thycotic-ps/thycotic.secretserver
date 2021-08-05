using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Secrets
{
    public class Audit
    {
        public string Action { get; set; }
        public string ActionForDisplay { get; set; }
        public string ByUserDisplayName { get; set; }
        public string DatabaseName { get; set; }
        public DateTime? DateRecorded { get; set; }
        public bool HasProxySessionData { get; set; }
        public int Id { get; set; }
        public string Notes { get; set; }
        public string RecordingMessage { get; set; }
        public string RecordingSessionId { get; set; }
        public int RecordingStatus { get; set; }
        public string Status { get; set; }
        public string TicketNumber { get; set; }
        public string Username { get; set; }
    }
}