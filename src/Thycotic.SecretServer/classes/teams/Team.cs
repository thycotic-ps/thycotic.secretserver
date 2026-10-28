using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Teams
{
    public class Team
    {
        public bool Active { get; set; }
        public string ConcurrencyId { get; set; }
        public int? DomainId { get; set; }
        public string DomainName { get; set; }
        public bool ShouldRestrictLists { get; set; }
        public bool ShouldRestrictSites { get; set; }
        public string TeamDescription { get; set; }
        public int TeamId { get; set; }
        public string TeamName { get; set; }
    }
}
