using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Secrets
{
    public class SshRestrictedCommand
    {
        public string CommandRestrictionType { get; set; }
        public object[] SshCommandBlocklists { get; set; }
        public object[] SshCommandMenus { get; set; }
    }
}
