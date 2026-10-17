using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Scripts
{
    public class UserScriptHistory
    {
        public string Script { get; set; }
        public string ScriptName { get; set; }
        public string ScriptType { get; set; }
    }
}
