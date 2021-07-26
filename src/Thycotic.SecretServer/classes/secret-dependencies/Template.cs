using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretDependencies
{
    public class Template
    {
        public bool Active { get; set; }
        public int DependencyChangerId { get; set; }
        public int DependencyTypeId { get; set; }
        public int Id { get; set; }
        public string Name { get; set; }
    }
}