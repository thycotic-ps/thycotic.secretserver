using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Groups
{
    public class Summary
    {
        public DateTime? Created { get; set; }
        public string DomainGuid { get; set; }
        public int DomainId { get; set; }
        public string DomainName { get; set; }
        public bool Enabled { get; set; }
        public int Id { get; set; }
        public int MemberCount { get; set; }
        public string Name { get; set; }
        public bool Synchronized { get; set; }
        public bool SynchronizeNow { get; set; }
    }
}