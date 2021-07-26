using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretHooks
{
    public class Summary
    {
        public string Description { get; set; }
        public string EventActionName { get; set; }
        public int HookId { get; set; }
        public string Name { get; set; }
        public string PrePostOption { get; set; }
        public string ScriptName { get; set; }
        public string ScriptTypeName { get; set; }
        public int SecretHookId { get; set; }
        public int SortOrder { get; set; }
        public bool Status { get; set; }
        public bool StopOnFailure { get; set; }
    }
}