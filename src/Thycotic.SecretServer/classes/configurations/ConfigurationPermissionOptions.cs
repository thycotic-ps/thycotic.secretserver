using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class ConfigurationPermissionOptions
    {
        public string AllowDuplicateSecretNamesOptionType { get; set; }
        public bool? AllowViewUserToRetrieveAutoChangeNextPassword { get; set; }
        public string DefaultSecretPermissions { get; set; }
        public bool? EnableApprovalFromEmail { get; set; }
        public string ForceSecretApproval { get; set; }
    }
}
