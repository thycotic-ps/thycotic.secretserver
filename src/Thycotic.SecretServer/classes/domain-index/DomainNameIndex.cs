using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DomainIndex
{
    public class DomainNameIndex
    {
        public int? DiscoverySourceId { get; set; }
        public int? DiscoverySourceIdScanned { get; set; }
        public int? DiscoverySourceIdSuggested { get; set; }
        public bool DomainMarkedAsIgnored { get; set; }
        public string DomainNameDiscovered { get; set; }
        public int DomainNameIndexId { get; set; }
        public string DomainResolveType { get; set; }
        public DateTime? ExpiredDate { get; set; }
        public DateTime? LastIndexedDate { get; set; }
    }
}
