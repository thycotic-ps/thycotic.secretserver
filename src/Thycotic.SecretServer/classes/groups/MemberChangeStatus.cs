using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Groups
{
    public class MemberChangeStatus
    {
        public PSObject FailedUserIdsByReason { get; set; }
        public bool Success { get; set; }
    }
}
