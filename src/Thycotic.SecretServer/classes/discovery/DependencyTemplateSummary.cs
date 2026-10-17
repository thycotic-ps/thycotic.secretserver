using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class DependencyTemplateSummary
    {
        public bool Active { get; set; }
        public int SecretDependencyTemplateId { get; set; }
        public string SecretDependencyTemplateName { get; set; }
        public int SecretDependencyTypeId { get; set; }
        public string SecretDependencyTypeName { get; set; }
    }
}
