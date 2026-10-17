using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class ServiceAccount
    {
        public string AccountDomain { get; set; }
        public int? AccountDomainId { get; set; }
        public bool AddedManually { get; set; }
        public bool CanLaunch { get; set; }
        public int ComputerId { get; set; }
        public string ComputerName { get; set; }
        public DateTime? CreatedDate { get; set; }
        public string Description { get; set; }
        public int? DiscoveryItemScannerId { get; set; }
        public string DiscoveryItemScannerName { get; set; }
        public int? DiscoverySourceId { get; set; }
        public string DiscoverySourceName { get; set; }
        public string DisplayName { get; set; }
        public bool Excluded { get; set; }
        public bool FoundOnComputer { get; set; }
        public bool HeartbeatFailed { get; set; }
        public string LastHeartBeatStatus { get; set; }
        public int NetworkItemId { get; set; }
        public int? PasswordExpirationStatus { get; set; }
        public DateTime? PasswordLastSet { get; set; }
        public int? ScanItemTemplateId { get; set; }
        public string ScanItemTemplateName { get; set; }
        public int? SecretId { get; set; }
        public string SecretName { get; set; }
    }
}
