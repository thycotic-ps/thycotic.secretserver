using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class Security
    {
        public bool AllowWebServiceHttpGet { get; set; }
        public bool AuditTlsErrors { get; set; }
        public bool AuditTlsErrorsDebug { get; set; }
        public string CertificateChainPolicyOptions { get; set; }
        public string ClientCertificateIds { get; set; }
        public string DatabaseIntegrityMonitoringSymmetricKey { get; set; }
        public bool EnableDatabaseIntegrityMonitoring { get; set; }
        public bool EnableFileRestrictions { get; set; }
        public bool EnableFrameBlocking { get; set; }
        public bool EnableHSTS { get; set; }
        public string FileExtensionRestrictions { get; set; }
        public bool FipsEnabled { get; set; }
        public bool ForceHttps { get; set; }
        public bool HideVersionNumber { get; set; }
        public int HstsMaxAge { get; set; }
        public string MaximumFileSizeBytes { get; set; }
        public bool MaximumFileSizeSupported { get; set; }
        public bool WebPasswordFillerRequiresFullDomainMatch { get; set; }
    }
}