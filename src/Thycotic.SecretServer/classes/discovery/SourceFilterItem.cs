using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class SourceFilterItem
    {
        public int DiscoveryFilterId { get; set; }
        public string DisplayName { get; set; }
        public string FilterType { get; set; }
        public string Guid { get; set; }
        public string ScanTargetType { get; set; }
        public int? SecretId { get; set; }
        public string SecretName { get; set; }
        public int? SiteId { get; set; }
        public string SiteName { get; set; }
    }
}
