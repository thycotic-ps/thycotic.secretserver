using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class Computer
    {
        public int? AccountTotal { get; set; }
        public string AdditionalData { get; set; }
        public object[] ComputerAccounts { get; set; }
        public DateTime? CreatedDate { get; set; }
        public string Description { get; set; }
        public int? DiscoveryItemScannerId { get; set; }
        public string DiscoveryItemScannerName { get; set; }
        public int? DiscoverySourceId { get; set; }
        public string DiscoverySourceName { get; set; }
        public string DisplayName { get; set; }
        public string DistinguishedName { get; set; }
        public string DnsHostName { get; set; }
        public object[] EntraIDRoleMembers { get; set; }
        public string LastErrorMessage { get; set; }
        public DateTime? LastLogon { get; set; }
        public DateTime? LastPolledDate { get; set; }
        public DateTime? LastReachedDate { get; set; }
        public int NetworkItemId { get; set; }
        public int? OrganizationUnitId { get; set; }
        public string OrganizationUnitName { get; set; }
        public object[] PublicKeyAccounts { get; set; }
        public int? ScanItemTemplateId { get; set; }
        public string ScanItemTemplateName { get; set; }
        public object[] ServiceAccounts { get; set; }
    }
}
