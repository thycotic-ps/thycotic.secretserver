using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class ApplicationSettings
    {
        public bool AllowSendTelemetry { get; set; }
        public bool AllowSoftwareUpdateChecks { get; set; }
        public bool ApiRefreshTokensEnabled { get; set; }
        public int ApiSessionTimeoutDays { get; set; }
        public int ApiSessionTimeoutHours { get; set; }
        public int ApiSessionTimeoutMinutes { get; set; }
        public bool ApiSessionTimeoutUnlimited { get; set; }
        public bool ConfigurationEarlyAdopterEnabled { get; set; }
        public string CustomUrl { get; set; }
        public bool DisplayDowntimeMessageToAdminsOnly { get; set; }
        public bool EnableCredSsp { get; set; }
        public bool EnableSyslogCefLogging { get; set; }
        public bool EnableWebServices { get; set; }
        public int MaximumTokenRefreshesAllowed { get; set; }
        public int MaxSecretLogLength { get; set; }
        public int MobileMaxOfflineDays { get; set; }
        public int MobileMaxOfflineHours { get; set; }
        public bool PreventApplicationFromSleeping { get; set; }
        public bool PreventDirectApiAuthentication { get; set; }
        public int SyslogCefLogSite { get; set; }
        public int SyslogCefPort { get; set; }
        public string SyslogCefProtocol { get; set; }
        public string SyslogCefServer { get; set; }
        public string SyslogCefTimeZone { get; set; }
        public string TmsInstallationPath { get; set; }
        public string WinRmEndpointUrl { get; set; }
        public bool WriteSyslogToEventLog { get; set; }
    }
}