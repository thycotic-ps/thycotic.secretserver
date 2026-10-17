using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Proxy
{
    public class SshConfiguration
    {
        public bool? AllowSiteSelectionForActiveDirectoryAccounts { get; set; }
        public string AvailablePortRange { get; set; }
        public int? DaysToKeepOperationalLogs { get; set; }
        public bool? EnablePasswordHiding { get; set; }
        public bool? EnableProxyBlockListing { get; set; }
        public bool? EnableProxyInactivityTimeout { get; set; }
        public bool? EnableSshProxy { get; set; }
        public bool EnableSshPublicKeyAuth { get; set; }
        public bool? EnableSshTerminal { get; set; }
        public bool? EnableSshTunneling { get; set; }
        public bool? EnableTerminalInactivityTimeout { get; set; }
        public bool? EnableWindowTitleChangeCommand { get; set; }
        public bool IsCloud { get; set; }
        public string PasswordRegexFilter { get; set; }
        public int? ProxyAutoBlockListingMaxHistory { get; set; }
        public int? ProxyAutoBlockListingMaxNum { get; set; }
        public int? ProxyAutoBlockListingTimeFrameMinutes { get; set; }
        public int? ProxyInactivityTimeoutSeconds { get; set; }
        public bool? ProxyNewSecretsByDefault { get; set; }
        public string SshHostKey { get; set; }
        public string SshProxyBanner { get; set; }
        public string SshProxyHostFingerprint { get; set; }
        public int? SshProxyPort { get; set; }
        public string SshTerminalBanner { get; set; }
        public int? TerminalInactivityTimeoutSeconds { get; set; }
        public int? TunnelKeepAliveInSeconds { get; set; }
    }
}
