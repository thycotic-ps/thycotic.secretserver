using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretDependencies
{
    public class RunScript
    {
        public string MachineName { get; set; }
        public object[] OdbcConnectionArguments { get; set; }
        public object[] ScriptArguments { get; set; }
        public int ScriptId { get; set; }
        public string ScriptName { get; set; }
        public string ServiceName { get; set; }
    }
}