using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using Thycotic.PowerShell.Enums;

namespace Thycotic.PowerShell.DistributedEngines
{
    public class Configuration
    {
        public EngineAzServiceBusType AzureServiceBusTransportType { get; set; }
        public int CallbackPort { get; set; }
        public string CallbackUrl { get; set; }
        public int DefaultCallbackIntervalSeconds { get; set; }
        public bool EnableDistributedEngines { get; set; }
        public EngineProtocol Protocol { get; set; }
        public int ResponseBusSiteConnectorId { get; set; }
        public int SecretHeartbeatMessageMinutesToLive { get; set; }
        public int SecretHeartbeatMessageRetryMinutes { get; set; }
        public int SecretPasswordChangeMessageMinutesToLive { get; set; }
        public int SecretPasswordChangeMessageRetryMinutes { get; set; }
    }
}