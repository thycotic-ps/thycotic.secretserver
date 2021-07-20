using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Secrets
{
    public class DetailSettings
    {
        public DateTime? ExpirationDate { get; set; }
        public int ExpirationDayInterval { get; set; }
        public string ExpirationTemplateText { get; set; }
        public string ExpirationType { get; set; }
        public OneTimePasswordSettings OneTimePasswordSettings { get; set; }
        public RdpLauncherSettings RdpLauncherSettings { get; set; }
        public bool SendEmailWhenChanged { get; set; }
        public bool SendEmailWhenHeartbeatFails { get; set; }
        public bool SendEmailWhenViewed { get; set; }
        public SshLauncherSettings SshLauncherSettings { get; set; }
    }
}