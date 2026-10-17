using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Scripts
{
    public class UserScriptUsage
    {
        public int? ScriptId { get; set; }
        public string ScriptName { get; set; }
        public string ScriptType { get; set; }
        public string UsageDescription { get; set; }
        public string UsageType { get; set; }
        public string UsedBy { get; set; }
        public string UsedById { get; set; }
    }
}
