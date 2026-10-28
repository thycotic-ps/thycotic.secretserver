using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DirectoryServices
{
    public class DomainLookup
    {
        public int DomainId { get; set; }
        public string DomainName { get; set; }
    }
}
