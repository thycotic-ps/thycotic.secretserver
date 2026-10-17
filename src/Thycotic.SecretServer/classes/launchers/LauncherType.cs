using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Launchers
{
    public class LauncherType
    {
        public bool Active { get; set; }
        public bool AdditionalPromptField { get; set; }
        public string AdditionalPromptFieldName { get; set; }
        public string Application { get; set; }
        public bool CanGetProxyCredentials { get; set; }
        public bool CanUseSSHKey { get; set; }
        public string ConcurrencyId { get; set; }
        public PSObject CustomLauncher { get; set; }
        public int? CustomLauncherId { get; set; }
        public bool IsCustomLauncher { get; set; }
        public bool IsPuttyLauncherType { get; set; }
        public bool IsRDPReady { get; set; }
        public bool IsSessionConnectorLauncher { get; set; }
        public bool IsSystemInternalLauncherType { get; set; }
        public DateTime? LastModifiedDate { get; set; }
        public int LauncherTypeId { get; set; }
        public string LauncherTypeName { get; set; }
        public bool MstscLauncherOption { get; set; }
    }
}
