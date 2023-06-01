using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class SessionRecording
    {
        public bool archiveLocationBySite { get; set; }
        public string archivePath { get; set; }
        public SessionRecordingArchivePathMappings[] archivePathMappings { get; set; } //
        public int daysUntilArchive { get; set; }
        public int daysUntilDelete { get; set; }
        public bool enableArchive { get; set; }
        public bool enableDelete { get; set; }
        public bool enableHardwareAcceleration { get; set; }
        public bool enableInactivityTimeout { get; set; }
        public bool  enableOnDemandVideoProcessing { get; set; }
        public bool enableSessionRecording { get; set; }
        public bool encryptArchive { get; set; }
        public bool hideRecordingIndicator { get; set; }
        public int inactivityTimeoutMinutes { get; set; }
        public int maxSessionLength { get; set; }
        public bool rdpProxyRecordKeyStrokes { get; set; }
        public bool rdpProxyRecordVideo { get; set; }
        public bool sshProxyRecordKeyStrokes { get; set; }
        public bool sshProxyRecordVideo { get; set; }
        public bool storeInDatabase { get; set; }
        public bool useTemporaryArchives { get; set; }
        public int videoCodecId { get; set; }

    }
}