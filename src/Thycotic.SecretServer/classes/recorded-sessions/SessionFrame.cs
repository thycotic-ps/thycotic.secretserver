using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.RecordedSessions
{
    public class SessionFrame
    {
        public DateTime? CaptureTime { get; set; }
        public string Description { get; set; }
        public int ImageId { get; set; }
    }
}
