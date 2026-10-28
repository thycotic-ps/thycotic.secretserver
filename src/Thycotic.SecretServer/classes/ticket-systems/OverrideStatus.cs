using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.TicketSystems
{
    public class OverrideStatus
    {
        public bool? IsApproved { get; set; }
        public int TicketSystemOverrideId { get; set; }
    }
}
