using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Secrets
{
    public class Share
    {
        public bool InheritPermissions { get; set; }
        public int SecretId { get; set; }
    }
}
