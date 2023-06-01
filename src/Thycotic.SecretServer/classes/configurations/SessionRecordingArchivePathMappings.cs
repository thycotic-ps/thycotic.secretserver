using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class SessionRecordingArchivePathMappings
    {
        public int siteId { get; set; }
        public string SiteName { get; set; }
        public string Path { get; set; }
    }
}