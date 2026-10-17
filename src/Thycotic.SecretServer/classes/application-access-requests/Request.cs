using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.ApplicationAccessRequests
{
    public class Request
    {
        public DateTime? CreatedDate { get; set; }
        public int DeviceId { get; set; }
        public string RequestingApplicationUsername { get; set; }
        public string Status { get; set; }
    }
}
