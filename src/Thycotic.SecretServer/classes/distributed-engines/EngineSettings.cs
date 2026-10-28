using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DistributedEngines
{
    public class EngineSettings
    {
        public EngineSetting AdSyncEnabled { get; set; }
        public EngineSetting AdvancedAuditingEnabled { get; set; }
        public int? EngineId { get; set; }
        public int EngineSettingsId { get; set; }
        public EngineSetting ExternalVaultsEnabled { get; set; }
        public EngineSetting FipsEnabled { get; set; }
        public EngineSetting LocalAccountDiscoveryEnabled { get; set; }
        public string LogLevel { get; set; }
        public EngineSetting PasswordChangingEnabled { get; set; }
        public EngineSetting RdpGatewayEnabled { get; set; }
        public int? RdpProxyCertificateSecretId { get; set; }
        public string RdpProxyCertificateSecretName { get; set; }
        public EngineSetting RdpProxyEnabled { get; set; }
        public EngineSetting SecretWorkflowEnabled { get; set; }
        public EngineSetting SecurityAnalyticsEnabled { get; set; }
        public EngineSetting ServiceAccountManagementEnabled { get; set; }
        public int? SiteId { get; set; }
        public EngineSetting SshProxyEnabled { get; set; }
        public EngineSetting SshTerminalEnabled { get; set; }
    }
}
