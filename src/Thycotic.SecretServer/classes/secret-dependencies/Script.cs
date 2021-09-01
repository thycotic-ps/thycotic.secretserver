using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretDependencies
{
    public class Script
    {
        public ScriptArgument[] Arguments { get; set; }
        public int Id { get; set; }
        public string Name { get; set; }
        public OdbcConnectionArgument[] OdbcConnectionArguments { get; set; }
    }
}