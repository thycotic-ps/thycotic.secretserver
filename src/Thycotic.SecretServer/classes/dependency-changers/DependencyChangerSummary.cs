using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DependencyChangers
{
    public class DependencyChangerSummary
    {
        public bool Active { get; set; }
        public int SecretDependencyChangerId { get; set; }
        public string SecretDependencyChangerName { get; set; }
        public int SecretDependencyTypeId { get; set; }
        public string SecretDependencyTypeName { get; set; }
    }
}
