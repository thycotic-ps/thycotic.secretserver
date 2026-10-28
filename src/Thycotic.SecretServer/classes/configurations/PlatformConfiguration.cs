using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class PlatformConfiguration
    {
        public bool EnablePlatformAuditIntegration { get; set; }
        public bool EnablePlatformInventoryForwarding { get; set; }
        public bool EnablePlatformOnLoginPage { get; set; }
        public bool ForcePlatformOnlyLogin { get; set; }
        public string OpenIdConnectClientId { get; set; }
        public string OpenIdConnectClientSecret { get; set; }
        public bool OpenIdConnectEnabled { get; set; }
        public string OpenIdConnectLoginUrl { get; set; }
        public string OpenIdConnectLogoutUrl { get; set; }
        public string OpenIdConnectReplyUrl { get; set; }
        public int PlatformPermissionCacheExpirationInMinutes { get; set; }
        public int PlatformPermissionSynchronizationIntervalMinutes { get; set; }
        public string PlatformTenantId { get; set; }
        public int SynchronizationIntervalDays { get; set; }
        public int SynchronizationIntervalHours { get; set; }
        public bool UsePlatformSettings { get; set; }
        public string VaultId { get; set; }
    }
}
