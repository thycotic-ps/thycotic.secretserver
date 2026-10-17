using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SshCommandMenu
{
    public class State
    {
        public string[] Actions { get; set; }
        public bool ViewPolicy { get; set; }
    }
}
