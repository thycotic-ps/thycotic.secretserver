using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretDependencies
{
    public class DependencyTemplate
    {
        public int ChangerScriptId { get; set; }
        public ScanItemFields[] DependencyScanItemFields { get; set; }
        public string ScriptName { get; set; }
        public int SecretDependencyChangerId { get; set; }
        public int SecretDependencyTemplateId { get; set; }
    }
}
