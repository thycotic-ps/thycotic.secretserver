using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Secrets
{
    public class ImportConfiguration
    {
        public bool AllowDuplicateSecretNames { get; set; }
        public bool RequireFolderForSecret { get; set; }
    }
}
