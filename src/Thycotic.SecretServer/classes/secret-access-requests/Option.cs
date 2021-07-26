using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.AccessRequests
{
    public class Option
    {
        public int CustomCheckoutIntervalDays { get; set; }
        public int CustomCheckoutIntervalHours { get; set; }
        public int CustomCheckoutIntervalMinutes { get; set; }
        public bool EditorsAlsoRequireApproval { get; set; }
        public bool EnableDoubleLock { get; set; }
        public bool EnableRequiresApprovalForAccess { get; set; }
        public bool IsDefaultCheckoutInterval { get; set; }
        public bool OwnersAndApproversAlsoRequireApproval { get; set; }
        public bool RequireCheckout { get; set; }
        public bool RequireCommentTicketNumber { get; set; }
    }
}
