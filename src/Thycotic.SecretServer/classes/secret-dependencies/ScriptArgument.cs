using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretDependencies
{
    public class ScriptArgument
    {
        public string Name { get; set; }
        public string Type { get; set; }
        public string Value { get; set; }
    }
}