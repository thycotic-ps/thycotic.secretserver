using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class DependencyTemplate
    {
        public bool Active { get; set; }
        public bool CanEdit { get; set; }
        public int ScanItemTemplateId { get; set; }
        public int? SecretDependencyChangerId { get; set; }
        public string SecretDependencyTemplateDescription { get; set; }
        public int SecretDependencyTemplateId { get; set; }
        public string SecretDependencyTemplateName { get; set; }
        public int SecretDependencyTypeId { get; set; }
    }
}
