using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SshCommandBlocklist
{
    public class SshCommandBlocklist
    {
        public bool Active { get; set; }
        public string Description { get; set; }
        public string Name { get; set; }
        public string SshCommandBlocklistId { get; set; }
        public object[] SshCommands { get; set; }
    }
}
