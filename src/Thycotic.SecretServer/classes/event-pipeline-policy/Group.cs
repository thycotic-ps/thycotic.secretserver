using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.EventPipelinePolicy
{
    public class Group
    {
        public string DisplayName { get; set; }
        public string DomainName { get; set; }
        public int GroupId { get; set; }
        public string Name { get; set; }
        public int? UserId { get; set; }
    }
}
