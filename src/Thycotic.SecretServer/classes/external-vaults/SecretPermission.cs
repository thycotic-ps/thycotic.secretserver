using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.ExternalVaults
{
    public class SecretPermission
    {
        public string DisplayName { get; set; }
        public bool EditExternalSecret { get; set; }
        public bool EditExternalSecretPermissions { get; set; }
        public int GroupId { get; set; }
        public bool Push { get; set; }
        public bool SetExternalSecretRemoteValue { get; set; }
        public int? UserId { get; set; }
        public bool ViewExternalSecret { get; set; }
        public bool ViewExternalSecretRemoteValue { get; set; }
    }
}
