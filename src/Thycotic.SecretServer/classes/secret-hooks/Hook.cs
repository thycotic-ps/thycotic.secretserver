using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretHooks
{
    public class Hook
    {
        public int SecretHookId { get; set; }
        public int HookId { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public int SortOrder { get; set; }
        public string PrePostOption { get; set; }
        public int EventActionId { get; set; }
        public int ScriptTypeId { get; set; }
        public int ScriptId { get; set; }
        public bool Status { get; set; }
        public bool StopOnFailure { get; set; }
        public string ServerName { get; set; }
        public string ServerKeyDigest { get; set; }
        public int Port { get; set; }
        public string Database { get; set; }
        public string Arguments { get; set; }
        public int SshKeySecretId { get; set; }
        public int PrivilegeSecretId { get; set; }
        public Parameter[] Parameters { get; set; }
        public string FailureMessage { get; set; }

        public void SetHookParameter(string Name, string Value)
        {
            foreach (var i in this.Parameters)
            {
                if (i.ParameterName.Equals(Name))
                {
                    i.ParameterValue = Value;
                }
            }
        }
    }
}
