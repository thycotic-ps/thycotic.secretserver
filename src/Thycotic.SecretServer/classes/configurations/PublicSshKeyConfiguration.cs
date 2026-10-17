using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class PublicSshKeyConfiguration
    {
        public bool Enabled { get; set; }
        public string ExpirationMessage { get; set; }
        public bool IsPassphraseRequired { get; set; }
    }
}
