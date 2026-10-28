using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.AppState
{
    public class Status
    {
        public DateTime? ProvisionDeletionDateTime { get; set; }
        public string State { get; set; }
        public string StatusText { get; set; }
    }
}
