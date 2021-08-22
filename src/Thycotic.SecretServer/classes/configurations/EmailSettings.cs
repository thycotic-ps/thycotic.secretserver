using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class EmailSettings
    {
        public string FromEmailAddress { get; set; }
        public bool SendLegacyEmails { get; set; }
        public bool SmtpCheckCertificateRevocation { get; set; }
        public string SmtpDomain { get; set; }
        public string SmtpPassword { get; set; }
        public int SmtpPort { get; set; }
        public string SmtpServer { get; set; }
        public bool SmtpUseCredentials { get; set; }
        public bool SmtpUseImplicitSSL { get; set; }
        public string SmtpUserName { get; set; }
        public bool SmtpUseSSL { get; set; }
    }
}