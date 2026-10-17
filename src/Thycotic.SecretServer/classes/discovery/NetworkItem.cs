using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class NetworkItem
    {
        public int? AccountTotal { get; set; }
        public DateTime? CreatedDate { get; set; }
        public string Description { get; set; }
        public int? DiscoverySourceId { get; set; }
        public string DiscoverySourceName { get; set; }
        public string DisplayName { get; set; }
        public string FullName { get; set; }
        public bool? HasError { get; set; }
        public bool? HasLocalAdminRights { get; set; }
        public string HostEnvironment { get; set; }
        public int? HostId { get; set; }
        public string HostName { get; set; }
        public bool? IsLocalAdministrator { get; set; }
        public bool IsManaged { get; set; }
        public string ItemType { get; set; }
        public string ItemTypeDisplayName { get; set; }
        public DateTime? LastLogon { get; set; }
        public DateTime? LastPolledDate { get; set; }
        public DateTime? LastReachedDate { get; set; }
        public int NetworkItemId { get; set; }
        public string OrganizationUnitName { get; set; }
        public string PasswordExpirationStatus { get; set; }
        public DateTime? PasswordLastSet { get; set; }
        public int? ScanItemTemplateId { get; set; }
        public string ScanItemTemplateName { get; set; }
        public string SearchGroups { get; set; }
        public int? SecretId { get; set; }
        public string SecretName { get; set; }
    }
}
