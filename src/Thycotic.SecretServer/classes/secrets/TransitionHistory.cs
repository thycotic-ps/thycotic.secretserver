using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Secrets
{
    public class TransitionHistory
    {
        public DateTime? DateRecorded { get; set; }
        public string ItemValue { get; set; }
    }
}
