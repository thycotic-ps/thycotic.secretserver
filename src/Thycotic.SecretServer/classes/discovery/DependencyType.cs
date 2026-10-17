using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class DependencyType
    {
        public bool HasRequiredLicensing { get; set; }
        public bool IsAssignableToDependencyTemplates { get; set; }
        public bool IsValidCustomDependencyChanger { get; set; }
        public int SecretDependencyTypeId { get; set; }
        public string SecretDependencyTypeName { get; set; }
    }
}
