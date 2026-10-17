using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Platform
{
    public class Vault
    {
        public string VaultId { get; set; }
        public string Name { get; set; }
        public string Type { get; set; }
        public bool IsDefault { get; set; }
        public bool IsGlobalDefault { get; set; }
        public bool IsActive { get; set; }
        public string Url { get; set; }
    }
}
