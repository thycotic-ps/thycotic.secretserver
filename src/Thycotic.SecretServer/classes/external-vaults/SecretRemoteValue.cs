using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.ExternalVaults
{
    public class SecretRemoteValue
    {
        public PSObject Entries { get; set; }
        public string Value { get; set; }
        public string Version { get; set; }
    }
}
