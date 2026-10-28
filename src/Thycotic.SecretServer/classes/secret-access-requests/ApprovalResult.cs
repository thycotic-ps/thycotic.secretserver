using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.AccessRequests
{
    public class ApprovalResult
    {
        public string Message { get; set; }
        public bool Success { get; set; }
    }
}
