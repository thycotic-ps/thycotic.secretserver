using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using Thycotic.PowerShell.Enums;

namespace Thycotic.PowerShell.DistributedEngines
{
    public class SiteConnector
    {
        public bool Active { get; set; }
        public string Hostname { get; set; }
        public int Port { get; set; }
        public SiteConnectorQueueType QueueType { get; set; }
        public string SharedAccessKeyName { get; set; }
        public string SharedAccessKeyValue { get; set; }
        public int SiteConnectorId { get; set; }
        public string SiteConnectorName { get; set; }
        public string SslCertificateThumbprint { get; set; }
        public bool UseSsl { get; set; }
        public bool Validated { get; set; }
    }
}