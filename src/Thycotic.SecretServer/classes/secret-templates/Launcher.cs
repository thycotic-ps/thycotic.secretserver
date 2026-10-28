using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretTemplates
{
    public class Launcher
    {
        public int? AllowList { get; set; }
        public string ConnectAsCommand { get; set; }
        public string ConnectAsCommandResponse { get; set; }
        public int? DenyList { get; set; }
        public object[] Fields { get; set; }
        public bool IncludeMachinesFromDependencies { get; set; }
        public int LauncherTypeId { get; set; }
        public string LauncherTypeName { get; set; }
        public string LineEnding { get; set; }
        public int? RestrictAs { get; set; }
        public int? RestrictBySecretField { get; set; }
        public bool RestrictUserInput { get; set; }
    }
}
