using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretTemplates
{
    public class LauncherSummary
    {
        public int? AllowListSecretFieldId { get; set; }
        public string ConnectAsCommand { get; set; }
        public string ConnectAsCommandResponse { get; set; }
        public int? ConnectAsTimeoutInSeconds { get; set; }
        public int? DenyListSecretFieldId { get; set; }
        public string ExpectedPromptEnding { get; set; }
        public object[] Fields { get; set; }
        public string LauncherTypeDescription { get; set; }
        public int LauncherTypeId { get; set; }
        public string LauncherTypeName { get; set; }
        public string LineEnding { get; set; }
        public bool RestrictHostDependencyMachines { get; set; }
        public int? RestrictHostSecretFieldId { get; set; }
        public int? RestrictHostType { get; set; }
        public bool RestrictUserInput { get; set; }
        public int SecretTypeId { get; set; }
    }
}
