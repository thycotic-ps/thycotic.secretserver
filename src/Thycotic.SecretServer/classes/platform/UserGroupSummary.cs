using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Platform
{
    public class UserGroupSummary
    {
        public string DisplayName { get; set; }
        public string DomainName { get; set; }
        public string EntityType { get; set; }
        public bool ExistingEntity { get; set; }
        public int? GroupId { get; set; }
        public string Name { get; set; }
        public string PlatformEntityUuid { get; set; }
        public bool ServiceUser { get; set; }
        public int? UserId { get; set; }
    }
}
