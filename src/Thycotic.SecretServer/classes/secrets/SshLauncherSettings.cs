using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Secrets
{
    public class SshLauncherSettings
    {
        public bool CanConnectAsCredentials { get; set; }
        public string LauncherType { get; set; }
        public int SecretId { get; set; }
        public string SecretName { get; set; }
        public int SshKeyExtendedTypeId { get; set; }
    }
}