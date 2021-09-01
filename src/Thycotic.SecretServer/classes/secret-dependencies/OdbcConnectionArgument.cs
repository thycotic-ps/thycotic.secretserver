using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretDependencies
{
    public class OdbcConnectionArgument
    {
        public string Name { get; set; }
        public string Value { get; set;}
    }
}