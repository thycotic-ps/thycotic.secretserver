using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SshCommandMenu
{
    public class SshCommandMenuItem
    {
        public bool Active { get; set; }
        public string Description { get; set; }
        public string Name { get; set; }
        public int SshCommandMenuId { get; set; }
    }
}
